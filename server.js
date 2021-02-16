require('dotenv').config({ path: './config.env' });
const express = require('express');

const eventsRouter = require('./routes/eventsRoute');
const trackRouter = require('./routes/trackRoute');

const app = express();
app.use(express.json());

// Add headers
app.use(function (req, res, next) {

  // Website you wish to allow to connect
  const allowedOrigins = [process.env.UI_DEV_DOMAIN, process.env.UI_PROD_DOMAIN];
  const origin = req.headers.origin;
  if (allowedOrigins.includes(origin)) {
       res.setHeader('Access-Control-Allow-Origin', origin);
  }

  // Request methods you wish to allow
  res.setHeader('Access-Control-Allow-Methods', 'GET');

  // Request headers you wish to allow
  res.setHeader('Access-Control-Allow-Headers', '*');

  // Pass to next layer of middleware
  next();
});

app.use('/events', eventsRouter);
app.use('/track', trackRouter);

// ---------------------------
// START SERVER
// ---------------------------
const port = process.env.PORT || 8080;

app.listen(port, () => {
  console.log('------------------------');
  console.log(`listening on port:${port}`);
});
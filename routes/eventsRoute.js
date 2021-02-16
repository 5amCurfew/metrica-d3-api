const express = require('express');
const controller = require('../controllers/eventsController');

const router = express.Router();

// ---------------------------
// Route Methods
// ---------------------------
router.route('/').get(controller.getEvents);

module.exports = router;
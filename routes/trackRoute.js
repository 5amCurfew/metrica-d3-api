const express = require('express');
const controller = require('../controllers/trackController');

const router = express.Router();

// ---------------------------
// Route Methods
// ---------------------------
router.route('/:id').get(controller.getTrack);

module.exports = router;
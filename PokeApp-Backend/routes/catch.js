const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    const success = Math.random() < 0.5;
    res.json({ success });
});

module.exports = router;

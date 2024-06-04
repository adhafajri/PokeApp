const express = require('express');
const router = express.Router();

router.post('/', (req, res) => {
    const number = Math.floor(Math.random() * 100) + 1;
    res.json({ number });
});

module.exports = router;
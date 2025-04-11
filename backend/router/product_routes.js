const express = require('express');
const products = require('../data/product');
const router = express.Router();
router.get('/get', async (req, res) => {
    return res.status(200).json({
        "status": 200,
        "data": products,
    })
})
module.exports = router;
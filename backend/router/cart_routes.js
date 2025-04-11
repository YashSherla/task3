const express = require('express');
const { getCart, addCart, removeCart } = require('../data/cart');
const router = express.Router();

router.post('/addcart', async (req, res) => {
    const productId = Number(req.body.productId);
    const quantity = Number(req.body.quantity);
    console.log(typeof productId);
    if (typeof productId !== 'number' || typeof quantity !== 'number') {
        return res.status(400).json({ error: "Invalid productId or quantity" });
    }
    addCart(productId, quantity);
    res.status(200).json({ message: "Product added to cart successfully" });
})
router.get('/getcart', async (req, res) => {
    return res.status(200).json({
        "status": 200,
        "data": getCart(),
    });
})
router.post('/removecart/:id', async (req, res) => {
    const productId = Number(req.params.id);
    console.log(productId);
    if (typeof productId !== 'number') {
        return res.status(400).json({ error: "Invalid productId" });
    }
    const removed = removeCart(productId);
    if (removed) {
        return res.status(200).json({ message: "Product removed from cart successfully" });
    } else {
        return res.status(404).json({ error: "Product not found in cart" });
    }
})
module.exports = router;

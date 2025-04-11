const cart = [];
const addCart = (productId, quantity) => {
    const existing = cart.find(item => item.productId === productId);
    if (existing) {
        existing.quantity += quantity;
    } else {
        cart.push({ productId, quantity });
    }
};

const getCart = () => cart;
const removeCart = (productId) => {
    const index = cart.findIndex(item => item.productId === productId);
    if (index !== -1) {
        cart.splice(index, 1);
        return true;
    }
    return false;
};
module.exports = {
    addCart,
    getCart,
    removeCart
};
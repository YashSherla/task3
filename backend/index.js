const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const cartRouter = require('./router/cart_routes')
const productRouter = require('./router/product_routes')
const app = express();
app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
app.use('/product', productRouter)
app.use('/cart', cartRouter)

app.listen(3000, () => {
    console.log('Server started on http://localhost:3000/?');
})
module.exports = app;
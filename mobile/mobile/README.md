# MemoNeet E-Commerce Application

## Project Overview

This project is an implementation of MemoNeet's e-commerce and sale section using Flutter for the frontend and Node.js for the backend API integration. The application follows the MVVM (Model-View-ViewModel) architectural pattern and uses Provider for state management.

## Features Implemented

### Frontend (Flutter)

- **UI Implementation**: Converted Figma designs into Flutter code with precise UI matching
- **Product Pages & Cart**: Functional product detail pages with add to cart functionality
- **Checkout & Payment Flow**: Intuitive checkout process with discount code support
- **Discount Code Implementation**: Discount codes are only applicable for orders with a total value of 1800 or above
- **User Interaction & Error Handling**: Proper error handling for edge cases
- **Responsive Design**: Works across multiple device sizes

### Backend (Node.js)

- **Express.js Server**: Simple setup using Express
- **API Endpoints**:
  - `GET /products/get`: Returns list of available products
  - `POST /cart/addcart`: Adds products to cart
  - `GET /cart/getcart`: Retrieves current cart items
- **In-memory Data Storage**: Temporary storage without database requirement

## Project Structure

### Flutter Application

```
lib/
├── models/
│   ├── product_model.dart
├── views/
│   ├── screens/
│       ├── product_screen.dart
│       ├── product_detail_screen.dart
│       └── checkout_screen.dart
├── provider/         # API and other services
│   ├── cart_provider.dart
│   └── product_provider.dart
└── main.dart         # Entry point

### Node.js Application



server/
├── routes/ # API routes
│ ├── product_routes.js
│ └── cart_routes.js
├── data/ # Mock data
│ └── products.js
├── package.json # Dependencies
└── index.js # Entry point


```
## Implementation Details

### MVVM Architecture

The application follows the MVVM (Model-View-ViewModel) architecture:

- **Models**: Data classes representing entities like products and cart items
- **Views**: UI components that display data to users and capture interactions
- **ViewModels**: Connect models and views, handle business logic and state management

### State Management with Provider

Provider is used for state management:

- **ProductModel**: Manages product listing and details

### API Integration

The Flutter app communicates with the Node.js backend through:

- **ApiService**: Handles all HTTP requests to the backend
- RESTful API calls for product fetching and cart operations
- JSON parsing and error handling

## Running the Project

### Flutter Application

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Ensure the backend server is running
4. Run `flutter run` to start the application

### Node.js Backend

1. Navigate to the server directory
2. Run `npm install` to install dependencies
3. Start the server with `npm start`
4. The server will run on `http://localhost:3000` by default

## Dependencies

### Flutter

- `provider`: For state management
- `http`: For API requests

### Node.js

- `express`: Web framework
- `body-parser`: Request body parsing
- `cors`: Cross-origin resource sharing

## Credits

This project was developed as part of the internship assignment for MemoNeet.
UI/UX designs were provided by MemoNeet through Figma.
```

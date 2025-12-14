# 🛒 MiniShop – Flutter E-Commerce App

MiniShop is a **modern Flutter-based e-commerce mobile application** built to demonstrate **real-world app architecture, clean UI, state management, and backend-ready integration**.

This project is designed as a **learning + showcase project**, following **industry practices** used in production mobile apps.

---

## 🚀 Features

### 🔐 Authentication
- Login & Signup with email and password
- Local authentication using SharedPreferences
- Auto-login on app restart
- Logout without deleting user data
- Professional form validation
- Show / Hide password functionality

### 🛍️ Product Management
- Fetch products from API (currently FakeStore API)
- Product listing with grid layout
- Product detail page
- Search products by name
- Filter products by category

### 🛒 Cart System
- Add / remove products from cart
- Quantity increment & decrement
- Persistent cart (saved locally)
- Professional cart UI with total price
- Cart badge indicator

### 👤 Profile
- Professional profile screen UI
- Dummy profile avatar
- Display user name & email
- Profile options (Orders, Address, Settings – coming soon)
- Logout option

### 🎨 UI / UX
- Clean and modern UI
- Consistent spacing & typography
- Material Design principles
- Production-style layouts

---

## 🧠 Architecture Overview

This project follows **clean separation of concerns**:

```
lib/
├── models/        # Data models (Product, User)
├── services/      # API layer (auth, products, cart)
├── providers/     # State management (Provider)
├── screens/       # UI screens
├── widgets/       # Reusable UI components
```

### Key Principles Used
- Provider for state management
- Service layer for API calls (backend-ready)
- UI independent of data source
- Scalable & maintainable structure

---

## 🔧 Tech Stack
- Flutter (Dart)
- Provider – State Management
- HTTP – API calls
- SharedPreferences – Local storage
- Material UI

---

## 🔄 Backend Ready

This project is fully backend-ready.

To connect a real backend:
- Replace API URLs in the services folder
- Update request payloads & API responses
- No UI changes required

Planned backend endpoints:

```
POST   /auth/login
POST   /auth/signup
GET    /user/profile
GET    /products
POST   /cart/add
GET    /cart
```

---

## 🏗️ Getting Started

### Clone the repository
```
git clone https://github.com/arpitkesharwani/flutter_learning.git
```

### Install dependencies
```
flutter pub get
```

### Run the app
```
flutter run
```

---

## 🧪 Current Status
- Core features completed
- Backend integration planned
- UI polishing ongoing

---

## 🛣️ Future Enhancements
- Real backend integration (Flask / FastAPI)
- JWT token handling
- Order placement flow
- Address management
- Profile editing
- Dark / Light theme
- Payment gateway integration

---

## 👨‍💻 Author

**Arpit Kesharwani**  
Backend & Flutter Learner  

GitHub: https://github.com/arpitkesharwani77

---

## ⭐ Support
If you like this project, please consider giving it a ⭐ on GitHub.

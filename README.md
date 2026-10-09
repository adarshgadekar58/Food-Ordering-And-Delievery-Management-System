# Food-Ordering-And-Delievery-Management-System
# 🍔 Food Ordering & Delivery Management System

A full-stack, server-rendered web application where customers browse restaurants, explore menus and manage a shopping cart, while administrators manage restaurants and menu items. Built with **Java 17, Spring Boot, Spring MVC, JSP, Spring Data JPA/Hibernate and Oracle Database**, with a strong focus on **security and clean layered architecture**.

![Java](https://img.shields.io/badge/Java-17-orange?logo=openjdk)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-4.1-6DB33F?logo=springboot&logoColor=white)
![JPA](https://img.shields.io/badge/Spring%20Data%20JPA-Hibernate-59666C?logo=hibernate)
![Oracle](https://img.shields.io/badge/Database-Oracle-F80000?logo=oracle&logoColor=white)
![Maven](https://img.shields.io/badge/Build-Maven-C71A36?logo=apachemaven&logoColor=white)
![JSP](https://img.shields.io/badge/View-JSP%20%2F%20JSTL-blue)

---

## 👀 For recruiters: what this project demonstrates

| Skill area | Evidence in this repository |
|---|---|
| **Backend development** | Layered Spring MVC app (Controller → Service → Repository → Entity) with constructor injection and transactional services |
| **Database design** | JPA entities with relationships (`User`, `Restaurant`, `FoodItem`, `CartItem`), unique constraints, enums, `BigDecimal` money handling, fetch joins to avoid N+1 queries |
| **Application security** | BCrypt password hashing, role-based access control, CSRF protection, session-fixation protection, XSS-safe output, mass-assignment protection, per-user data ownership checks |
| **Input validation** | Jakarta Bean Validation on entities with user-friendly form errors |
| **Clean code practices** | Single-responsibility classes, custom 404 exception, no secrets in source (environment-based config), consistent naming |
| **Full-stack ability** | Responsive JSP/JSTL front-end with forms, confirmations and error pages |

---

## ✨ Features

**Customers**
- Register and log in securely (passwords are hashed, never stored in plain text)
- Browse restaurants and view restaurant details
- View a restaurant's menu and individual food item details
- Add items to a cart, increase/decrease quantity, remove items
- Live cart total, with a per-item quantity limit
- Items marked *unavailable* cannot be added to the cart

**Administrators**
- Add and delete restaurants
- Add and delete menu items for any restaurant
- Deleting a restaurant cleanly removes its menu and related cart entries
- Admin-only buttons are hidden from regular users, and the endpoints are protected server-side

---

## 🔐 Security highlights

Security was a deliberate focus rather than an afterthought:

- **Password hashing:** BCrypt via `spring-security-crypto`
- **Authorization:** `HandlerInterceptor`-based authentication plus an **ADMIN role** guard for management endpoints
- **CSRF protection:** per-session token verified on every state-changing request (all deletes, cart actions and logout are `POST`, not `GET`)
- **Session fixation protection:** session ID is rotated on login
- **IDOR prevention:** cart rows are always loaded by `(id, userId)`, so users can only change their own cart
- **XSS prevention:** all user-supplied output is escaped with `<c:out>`
- **Mass-assignment protection:** `id` / `role` fields cannot be set from a submitted form
- **Secrets management:** database credentials and the first admin account come from environment variables
- **Hardened session cookie:** `HttpOnly`, `SameSite=Lax`, 30-minute timeout

---

## 🧱 Tech stack

| Layer | Technology |
|---|---|
| Language | Java 17 |
| Framework | Spring Boot 4.1, Spring MVC |
| Persistence | Spring Data JPA, Hibernate |
| Database | Oracle Database |
| View | JSP + JSTL (Jakarta) |
| Validation | Jakarta Bean Validation |
| Security utilities | Spring Security Crypto (BCrypt) |
| Build | Maven (WAR packaging) |
| Other | Lombok |

---

## 🗂️ Project structure

```
src/main
├── java/com
│   ├── config        # Interceptors (auth, admin, CSRF), password encoder, admin bootstrap
│   ├── controller    # Spring MVC controllers (Home, User, Dashboard, Restaurant, FoodItem, Cart, Logout)
│   ├── exception     # ResourceNotFoundException (renders 404 page)
│   ├── model         # JPA entities and enums (User, Restaurant, FoodItem, CartItem, Role, ...)
│   ├── repository    # Spring Data JPA repositories
│   └── service       # Business logic and transactions
├── resources
│   └── application.properties
└── webapp/WEB-INF/view   # JSP pages
```

---

## 🚀 Getting started

### Prerequisites
- JDK 17+
- Maven 3.9+
- Oracle Database (XE or 19c+) running locally

### 1. Create a database user
Connect as a DBA and run (change the password):

```sql
CREATE USER food_app IDENTIFIED BY "change_me"
  DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE TO food_app;
```

### 2. Clone the repository
```bash
git clone https://github.com/<your-username>/<your-repo-name>.git
cd <your-repo-name>
```

### 3. Set environment variables

| Variable | Required | Description |
|---|---|---|
| `DB_USERNAME` | ✅ | Oracle user (e.g. `food_app`) |
| `DB_PASSWORD` | ✅ | Oracle password |
| `DB_URL` | ❌ | Defaults to `jdbc:oracle:thin:@localhost:1521:ORCL` |
| `ADMIN_EMAIL` | ❌ | Creates (or promotes) the first admin account |
| `ADMIN_PASSWORD` | ❌ | Password for that admin (minimum 8 characters) |

Linux / macOS:
```bash
export DB_USERNAME=food_app
export DB_PASSWORD=change_me
export ADMIN_EMAIL=admin@example.com
export ADMIN_PASSWORD=ChangeMe123
```

Windows (PowerShell):
```powershell
$env:DB_USERNAME="food_app"
$env:DB_PASSWORD="change_me"
$env:ADMIN_EMAIL="admin@example.com"
$env:ADMIN_PASSWORD="ChangeMe123"
```

### 4. Run the application
```bash
mvn spring-boot:run
```
Or run the main class from your IDE (with the environment variables set in the run configuration).

Open **http://localhost:8080**. Tables are created automatically on first start (`spring.jpa.hibernate.ddl-auto=update`).

### 5. Try it out
1. Register a customer account and log in
2. Log in as the admin account you configured to add a restaurant and menu items
3. Switch to a customer to browse the menu and use the cart

---

## 🧭 Main routes

| Route | Access | Purpose |
|---|---|---|
| `/` | Public | Landing page |
| `/register`, `/login` | Public | Create account / sign in |
| `/dashboard` | Logged in | User home |
| `/restaurants`, `/restaurants/{id}` | Logged in | Browse restaurants |
| `/food/restaurant/{id}`, `/food/{id}`, `/food/all` | Logged in | Menus and food details |
| `/cart` | Logged in | View and manage cart |
| `/restaurants/add`, `/restaurants/save`, `/restaurants/delete/{id}` | **Admin** | Manage restaurants |
| `/food/add/{restaurantId}`, `/food/save`, `/food/delete/{id}` | **Admin** | Manage menu items |

---

## 🗺️ Roadmap

Planned improvements (not implemented yet):

- [ ] Checkout and order placement (the cart currently stops before checkout)
- [ ] Order history ("My Orders") and order status tracking
- [ ] Delivery fee calculation and delivery tracking
- [ ] Search and filter restaurants by cuisine / location
- [ ] Database migrations with Flyway instead of `ddl-auto=update`
- [ ] Automated tests (unit tests for services, MockMvc tests for controllers)
- [ ] Migrate to Spring Security for authentication and authorization
- [ ] REST API and Docker setup

---

## 📸 Screenshots

<!-- Add 3-4 screenshots to a /docs folder and reference them here, e.g.:
![Restaurants page](docs/restaurants.png)
![Cart page](docs/cart.png)
-->

---

## 👤 Author

**[Your Name]**
- 💼 LinkedIn: [linkedin.com/in/your-profile](https://linkedin.com/in/your-profile)
- 📧 Email: your.email@example.com
- 🐙 GitHub: [@your-username](https://github.com/your-username)

I'm actively looking for **[Java / Backend / Full-Stack developer]** opportunities. Feel free to reach out.

---

## 📄 License

This project is licensed under the MIT License. See the `LICENSE` file for details.

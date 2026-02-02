# Design Patterns Project

Spring Boot backend + Flutter frontend demonstrating Creational, Behavioral, and Structural design patterns.

## Requirements

- Java 17
- Maven 3.6+
- Flutter SDK 3.0+

## Installation (Linux)

```bash
# Java 17
sudo apt install openjdk-17-jdk -y

# Maven
sudo apt install maven -y

# Flutter
git clone https://github.com/flutter/flutter.git -b stable ~/flutter
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.bashrc
source ~/.bashrc
sudo apt install clang cmake ninja-build pkg-config libgtk-3-dev -y
```

## Running

### Backend (Terminal 1)
```bash
cd backend
mvn spring-boot:run
```
Runs at http://localhost:8080

### Frontend (Terminal 2)
```bash
cd frontend
flutter pub get
flutter run -d chrome
```

## API Endpoints

### Creational (`/api/creational`)
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/factory/types` | Get document types |
| POST | `/factory/document` | Create document (Factory) |
| POST | `/builder/car` | Build car (Builder) |

### Behavioral (`/api/behavioral`)
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/orders` | Get all orders |
| GET | `/orders/{id}` | Get order by ID |
| POST | `/orders` | Place order (Command, Chain, Observer, Strategy) |

### Structural (`/api/structural/books`)
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/` | Get all books (Facade) |
| GET | `/{id}` | Get book by ID (Facade) |
| POST | `/` | Add book (Facade) |
| PUT | `/{id}` | Update book (Facade) |
| DELETE | `/{id}` | Delete book (Facade) |
| GET | `/category/{category}` | Filter by category (Facade) |
| GET | `/featured` | Get featured books (Decorator) |
| GET | `/bestsellers` | Get bestsellers (Decorator) |

## Swagger UI

http://localhost:8080/swagger

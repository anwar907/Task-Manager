# Task Manager (WillDo)

A Task Manager application built with Flutter using BLoC architecture and Supabase as backend.

## 📱 Key Features

- ✅ Task management (CRUD operations)
- 🔐 User authentication (Login/Signup)
- 📊 Dashboard for task overview
- 💾 Local storage with SharedPreferences
- ☁️ Data synchronization with Supabase
- 🎨 Responsive UI for multiple platforms (Android, iOS, Web, Desktop)

## 🏗️ Architecture

This project uses **Clean Architecture** with **BLoC** pattern for state management:

```
lib/
├── app/
│   ├── modules/           # Feature modules
│   │   ├── dashboard/     # Dashboard feature
│   │   ├── login/         # Login feature
│   │   ├── signup/        # Signup feature
│   │   └── splash/        # Splash screen
│   ├── app_routes.dart    # Route configuration
│   └── app.dart          # Main app widget
└── main.dart             # Entry point

packages/
├── auth_repository/       # Authentication logic
├── storage_repository/    # Local storage
├── supabase_repository/   # Supabase integration
└── task_repository/       # Task management
```

## 🛠️ Tech Stack

- **Framework**: Flutter 3.8.1+
- **State Management**: BLoC/Cubit
- **Backend**: Supabase
- **Local Storage**: SharedPreferences
- **Architecture**: Clean Architecture + Repository Pattern

### Main Dependencies

```yaml
dependencies:
  flutter_bloc: ^9.1.1 # State management
  equatable: ^2.0.7 # Value equality
  supabase_flutter: ^2.9.1 # Supabase client
```

## 🚀 Setup & Installation

### Prerequisites

- Flutter SDK 3.8.1 or newer
- Dart SDK
- Android Studio / VS Code
- Supabase account

### Installation Steps

1. **Clone repository**

   ```bash
   git clone <repository-url>
   cd Task-Manager
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Setup Supabase**

   - Create new project at [Supabase](https://supabase.com)
   - Configure database schema for tasks
   - Update Supabase configuration in the app

4. **Run application**
   ```bash
   flutter run
   ```

## 📦 Package Structure

### 1. Auth Repository

Manages user authentication with Supabase:

- Login/Logout
- User registration
- Session management

### 2. Task Repository

Manages CRUD operations for tasks:

- Create, Read, Update, Delete tasks
- Filter and search tasks
- Status completion

### 3. Supabase Repository

Abstraction layer for Supabase communication:

- API client configuration
- Data models (TaskModel)
- Error handling

### 4. Storage Repository

Manages local storage:

- SharedPreferences wrapper
- Cache management
- Offline data handling

## 🎯 Feature Modules

### 1. Splash Screen

- Loading screen with branding
- Auto-navigation based on auth status

### 2. Authentication

- **Login**: Email/password authentication
- **Signup**: User registration with validation

### 3. Dashboard

- Overview of all tasks
- Quick actions (add, edit, delete)
- Filter by status

## 🔧 Development

### Adding New Features

1. Create new module in `lib/app/modules/`
2. Implement BLoC/Cubit for state management
3. Add route in `app_routes.dart`
4. Update repository if needed

### Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/
```

### Build for Production

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🤝 Contributing

1. Fork repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Create Pull Request

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

## 📞 Contact

Project Link: [https://github.com/username/Task-Manager](https://github.com/username/Task-Manager)

---

**Built with ❤️ using Flutter & Supabase**

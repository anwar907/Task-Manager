# Task Manager (WillDo)

A Task Manager application built with Flutter using BLoC architecture and Supabase as backend.

## 📱 Key Features

- ✅ Task management (CRUD operations)
- 🔐 User authentication (Login/Signup)
- 📊 Dashboard with task overview and filtering
- 📅 Due date management with status tracking
- 💾 Local storage with SharedPreferences
- ☁️ Data synchronization with Supabase
- 🔄 Real-time task status updates (To do, In Progress, Done)

## 🏗️ Architecture

This project uses **Clean Architecture** with repository pattern using **BLoC** for state management:

```
lib/
├── app/
│   ├── modules/           # Feature modules
│   │   ├── dashboard/     # Dashboard feature
│   │   │   ├── bloc/      # Task & Form BLoCs
│   │   │   └── view/      # UI components
│   │   ├── login/         # Login feature
│   │   │   ├── bloc/      # Auth BLoC
│   │   │   └── view/      # Login UI
│   │   ├── signup/        # Signup feature
│   │   │   ├── bloc/      # Signup BLoC
│   │   │   └── view/      # Signup UI
│   │   └── splash/        # Splash screen
│   │       └── cubit/     # Splash Cubit
│   ├── utils/             # Utilities
│   │   └── task_status.dart # Date & status extensions
│   ├── app_routes.dart    # Route configuration
│   └── app.dart          # Main app widget
└── main.dart             # Entry point

packages/
├── auth_repository/       # Authentication logic
├── storage_repository/    # Local storage (SharedPreferences)
├── supabase_repository/   # Supabase integration & models
└── task_repository/       # Task management
```

## Diagram Architecture

<img width="933" height="414" alt="Screenshot 2025-08-26 at 19 04 49" src="https://github.com/user-attachments/assets/cf85b844-433d-440b-aa3d-ffc909adee51" />

## 🛠️ Tech Stack

- **Framework**: Flutter 3.8.1+
- **State Management**: BLoC/Cubit
- **Backend**: Supabase
- **Local Storage**: SharedPreferences
- **Architecture**: Clean Architecture + Repository Pattern
- **SDK**: Dart ^3.8.1

### Main Dependencies

```yaml
dependencies:
  flutter_bloc: ^9.1.1 # State management
  equatable: ^2.0.7 # Value equality
  cupertino_icons: ^1.0.8 # iOS style icons
  supabase_flutter: ^2.9.1 # Supabase client
  shared_preferences: ^2.3.4 # Local storage
  uuid: ^4.5.1 # UUID generation
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

3. **Run application**
   ```bash
   flutter run --dart-define=SUPABASE_ANON_KEY={ANON_KEY_HERE} --dart-define=URL=https://{PROJECT_ID_HERE}.supabase.co --dart-define=STORAGE_RETRY_ATTEMPTS=5
   ```

## Demo Example

https://github.com/user-attachments/assets/0809625a-ad8a-4d1a-8890-9b846e5e6f3f

## 📦 Package Structure

### 1. Auth Repository

Manages user authentication with Supabase:

- Login/Logout functionality
- User registration
- Session management
- Integration with Supabase Repository

### 2. Task Repository

Manages CRUD operations for tasks:

- Create, Read, Update, Delete tasks
- Task filtering and search
- Status completion tracking
- Integration with Supabase Repository

### 3. Supabase Repository

Abstraction layer for Supabase communication:

- API client configuration
- TaskModel data model with JSON serialization
- Supabase API implementation
- Error handling and response management
- UUID generation for unique identifiers

### 4. Storage Repository

Manages local storage with SharedPreferences:

- Preference helper utilities
- Cache management
- Offline data handling
- Key-value storage abstraction

## 🎯 Feature Modules

### 1. Splash Screen

- Loading screen with branding
- Auto-navigation based on authentication status
- Cubit-based state management

### 2. Authentication

- **Login**: Email/password authentication with BLoC
- **Signup**: User registration with validation and BLoC
- Form validation and error handling
- Secure session management

### 3. Dashboard

- Overview of all tasks with real-time updates
- Task creation and editing with dedicated form
- Task status management (To do, In Progress, Done)
- Due date tracking with automatic status calculation
- Quick actions (add, edit, delete, complete)
- Form management with separate Cubit
- Task filtering and status-based organization

## 🔧 Development

### Adding New Features

1. Create new module in `lib/app/modules/`
2. Implement BLoC/Cubit for state management
3. Add route in `app_routes.dart`
4. Create or update repository packages if needed
5. Follow the existing architecture patterns

### Testing

```bash
# Run unit tests
flutter test

# Run tests for specific packages
cd packages/auth_repository && flutter test
cd packages/task_repository && flutter test
```

### Build for Production

```bash
# Android
flutter build apk --release --dart-define=SUPABASE_ANON_KEY={ANON_KEY_HERE} --dart-define=URL=https://{PROJECT_ID_HERE}.supabase.co --dart-define=STORAGE_RETRY_ATTEMPTS=5

# iOS
flutter build ios --release --dart-define=SUPABASE_ANON_KEY={ANON_KEY_HERE} --dart-define=URL=https://{PROJECT_ID_HERE}.supabase.co --dart-define=STORAGE_RETRY_ATTEMPTS=5

# Web
flutter build web --release --dart-define=SUPABASE_ANON_KEY={ANON_KEY_HERE} --dart-define=URL=https://{PROJECT_ID_HERE}.supabase.co --dart-define=STORAGE_RETRY_ATTEMPTS=5
```

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🚀 Current Status

- ✅ Authentication system implemented
- ✅ Task CRUD operations working
- ✅ Dashboard with task management
- ✅ Due date tracking and status calculation
- ✅ Form management with BLoC
- ✅ Multi-platform support (Android, iOS, Web, Desktop)
- ✅ Clean architecture with repository pattern
- ✅ Dependency Inversion Principle (DIP)
- ✅ Unit Test on Domain + Data layers.

## 📞 Contact

Project Link: [https://github.com/username/Task-Manager](https://github.com/username/Task-Manager)

---

**Built with ❤️ using Flutter & Supabase**

# 🚀 Router Usage Guide

## Replace Old Navigation with New Router Methods

### ❌ **OLD WAY (Don't use anymore)**

```dart
// Old manual navigation
Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
Navigator.pop(context);
```

### ✅ **NEW WAY (Use these instead)**

#### **Basic Navigation**

```dart
// Go to different screens
AppRouter.goToHome(context);           // Replaces manual home navigation
AppRouter.goToAuth(context);           // Go to auth screen
AppRouter.goToLogin(context);          // Go to login screen
AppRouter.goToProfile(context);        // Go to profile screen
AppRouter.goToFeedback(context);       // Go to feedback screen
AppRouter.goToSettings(context);       // Go to settings screen

// Onboarding flow
AppRouter.goToOnboardingProfile1(context);  // First profile setup
AppRouter.goToOnboardingProfile2(context);  // Second profile setup
AppRouter.goToOnboardingShare(context);     // Share screen
AppRouter.goToOnboardingDemo(context);      // Demo screen

// Go back
AppRouter.goBack(context);             // Smart back navigation
```

#### **Advanced Navigation**

```dart
// Named route navigation with parameters
AppRouter.pushNamed(context, 'profile',
  pathParameters: {'userId': '123'},
  queryParameters: {'tab': 'settings'}
);

// Replace current screen
AppRouter.replaceNamed(context, 'home');

// Clear entire navigation stack and go to specific screen
AppRouter.clearStackAndGoTo(context, '/home');

// Show as modal
AppRouter.pushAsModal(context, SomeWidget());

// Show as dialog
AppRouter.pushAsDialog(context, SomeDialog());
```

#### **Route Information**

```dart
// Get current route information
String currentRoute = AppRouter.getCurrentRoute(context);
String? routeName = AppRouter.getCurrentRouteName(context);
Map<String, String> pathParams = AppRouter.getCurrentPathParameters(context);
Map<String, String> queryParams = AppRouter.getCurrentQueryParameters(context);
```

## 🔧 **Migration Examples**

### **1. Welcome Screen Navigation**

```dart
// OLD ❌
Navigator.push(
  context,
  AppAnimations.fadeSlideTransition(const LoginScreen()),
);

// NEW ✅
AppRouter.goToLogin(context);
```

### **2. Profile Screen Logout**

```dart
// OLD ❌
Navigator.pushReplacement(
  context,
  AppAnimations.fadeTransition(const AuthScreen()),
);

// NEW ✅
AppRouter.goToAuth(context);
```

### **3. Onboarding Flow**

```dart
// OLD ❌
Navigator.pushReplacement(
  context,
  AppAnimations.slideTransition(const ShareScreen()),
);

// NEW ✅
AppRouter.goToOnboardingShare(context);
```

### **4. Back Navigation**

```dart
// OLD ❌
Navigator.pop(context);

// NEW ✅
AppRouter.goBack(context);  // Smart back that handles edge cases
```

### **5. Complete Flow Example**

```dart
// Complete authentication flow
void handleSuccessfulLogin() {
  if (isNewUser) {
    AppRouter.goToOnboardingProfile1(context);
  } else {
    AppRouter.goToHome(context);
  }
}

void handleProfileCompletion() {
  AppRouter.goToOnboardingShare(context);
}

void handleShareCompletion() {
  AppRouter.goToOnboardingDemo(context);
}

void handleDemoCompletion() {
  AppRouter.goToHome(context);
}
```

## 🎯 **Benefits of New Router**

1. **Type Safety**: No more string-based routes that can break
2. **Automatic Authentication**: Routes automatically redirect based on auth state
3. **Clean Code**: One-liner navigation calls
4. **Consistent**: Same API across the entire app
5. **Debug Friendly**: Built-in logging and error handling
6. **Future Proof**: Easy to add new routes and features

## 🚨 **Important Notes**

- **Always use AppRouter methods instead of Navigator**
- **The router handles authentication redirects automatically**
- **Routes are type-safe and compile-time checked**
- **Splash screen automatically navigates to auth**
- **All animations and transitions are handled automatically**

## 🔗 **Available Routes**

| Route                   | Method                               | Description                    |
| ----------------------- | ------------------------------------ | ------------------------------ |
| `/`                     | N/A                                  | Splash screen (auto-navigates) |
| `/auth`                 | `AppRouter.goToAuth()`               | Authentication welcome screen  |
| `/login`                | `AppRouter.goToLogin()`              | Phone/OTP login screen         |
| `/onboarding/profile-1` | `AppRouter.goToOnboardingProfile1()` | First profile setup            |
| `/onboarding/profile-2` | `AppRouter.goToOnboardingProfile2()` | Second profile setup           |
| `/onboarding/share`     | `AppRouter.goToOnboardingShare()`    | Share app screen               |
| `/onboarding/demo`      | `AppRouter.goToOnboardingDemo()`     | Demo completion screen         |
| `/home`                 | `AppRouter.goToHome()`               | Main home screen               |
| `/home/map`             | `AppRouter.goToMap()`                | Map view                       |
| `/profile`              | `AppRouter.goToProfile()`            | User profile screen            |
| `/feedback`             | `AppRouter.goToFeedback()`           | Feedback screen                |
| `/settings`             | `AppRouter.goToSettings()`           | Settings (placeholder)         |

Start using these methods in your screens and enjoy the improved navigation experience! 🎉

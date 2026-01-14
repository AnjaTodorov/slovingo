# Slovingo

<div align="center">

**Dive into the delightful world of Slovene with Slovingo, your personal AI-powered language tutor that makes learning fun, interactive, and super efficient!**

[![Flutter](https://img.shields.io/badge/Flutter-3.6.0-02569B?logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.6.0-0175C2?logo=dart)](https://dart.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFCA28?logo=firebase)](https://firebase.google.com/)

</div>

---

## Table of Contents

- [About](#about)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Project Structure](#project-structure)
- [Key Features Explained](#key-features-explained)
- [Authors](#authors)

---

## About

Slovingo is a modern, feature-rich mobile application designed to help users learn the Slovenian language through an engaging and structured approach. The app combines interactive lessons, AI-powered assistance, progress tracking, and gamification elements to create an effective and motivating learning experience.

### Vision

Our vision is to provide users with an accessible and intuitive tool for learning Slovenian, regardless of their starting knowledge level. By combining structured lessons, intelligent feedback, AI assistance, and comprehensive progress tracking, Slovingo aims to make language learning efficient, enjoyable, and motivating.

---

## Features

### **Structured Learning**
- **Progressive Levels**: Multiple learning levels organized by difficulty (Starter, Beginner, Intermediate, Upper Intermediate, Advanced, Expert)
- **Interactive Lessons**: Engaging lesson content with vocabulary, grammar, and examples
- **Level Locking System**: Unlock new levels by completing previous ones
- **Lesson Search**: Quick search functionality to find specific lessons

### **Quizzes & Assessment**
- **Interactive Quizzes**: Test your knowledge with various question types
- **Score Tracking**: Track your performance and progress
- **Level Completion**: Unlock new levels by achieving passing scores

### **Translation**
- **Bilingual Translation**: English ↔ Slovenian translation powered by Google Gemini AI
- **Translation History**: View and review your past translations
- **Modern UI**: Clean, user-friendly interface with organized history

### **AI Chat Tutor**
- **Virtual Tutor**: Practice Slovenian through natural conversation
- **AI-Powered Assistance**: Get explanations, corrections, and vocabulary suggestions
- **Conversation History**: Review past conversations for learning

### **Progress Tracking**
- **Statistics Dashboard**: Comprehensive statistics with visual charts
  - Level progress visualization
  - Translation activity charts
  - Learning overview with key metrics
- **Trophies & Achievements**: Unlock trophies based on your learning milestones
- **Streak Tracking**: Maintain daily learning streaks with calendar visualization
- **Points System**: Earn points for completed activities

### **Daily Engagement**
- **Word of the Day**: Learn a new Slovenian word daily with examples
- **Streak Calendar**: Visual calendar showing your learning streaks
- **Daily Reminders**: Local notifications to encourage daily practice

### **User Management**
- **Firebase Authentication**: Secure user authentication
- **Google Sign-In**: Quick login with Google account
- **User Profiles**: Customizable profiles with avatar support
- **Progress Sync**: Cloud-synced progress across devices

### **Modern UI/UX**
- **Material Design 3**: Beautiful, modern interface following Material Design principles
- **Dark/Light Theme**: Toggle between themes for comfortable viewing
- **Responsive Design**: Optimized for various screen sizes
- **Smooth Navigation**: Intuitive navigation with bottom navigation bar

---

## Tech Stack

### Core Framework
- **Flutter** (`^3.6.0`) - Cross-platform mobile framework
- **Dart** (`^3.6.0`) - Programming language

### State Management & Navigation
- **Provider** (`^6.0.0`) - State management
- **GoRouter** (`^17.0.0`) - Declarative routing

### Backend & Database
- **Firebase Core** (`^3.6.0`) - Firebase integration
- **Firebase Auth** (`^5.3.0`) - User authentication
- **Cloud Firestore** (`^5.4.4`) - Cloud database
- **Firebase Storage** (`^12.4.10`) - File storage
- **SQLite (sqflite)** (`^2.0.0`) - Local database for offline data

### AI & APIs
- **Google Gemini AI** - Translation services
- **HTTP** (`^1.0.0`) - API communication

### UI & Design
- **Google Fonts** (`^6.1.0`) - Typography
- **fl_chart** (`^0.69.0`) - Data visualization and charts
- **Cached Network Image** (`^3.4.1`) - Image loading and caching

### Utilities
- **Shared Preferences** (`^2.0.0`) - Local storage
- **intl** (`0.20.2`) - Internationalization
- **flutter_dotenv** (`^5.1.0`) - Environment variables
- **Image Picker** (`^1.2.1`) - Image selection
- **Share Plus** (`^12.0.1`) - Content sharing
- **Local Notifications** (`^19.5.0`) - Push notifications
- **Google Sign In** (`^6.2.1`) - Google authentication

### Development Tools
- **Flutter Lints** (`^5.0.0`) - Code linting
- **Flutter Launcher Icons** (`^0.13.1`) - App icon generation

---

## Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.6.0 or higher)  
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/flutter/flutter-original.svg" width="45" height="45" alt="Flutter"/>
- **Dart SDK** (3.6.0 or higher)  
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/dart/dart-original.svg" width="45" height="45" alt="Dart"/>
- **Android Studio** with Android SDK  
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/androidstudio/androidstudio-original.svg" width="45" height="45" alt="Android Studio"/>
- **Android Emulator** or physical Android device  
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/android/android-original.svg" width="45" height="45" alt="Android"/>
- **Firebase Account** (for backend services)  
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/firebase/firebase-plain.svg" width="45" height="45" alt="Firebase"/>
- **Google Cloud Account** (for Gemini API)  
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/googlecloud/googlecloud-original.svg" width="45" height="45" alt="Google Cloud"/>

### Verify Installation

```bash
flutter doctor
```

Ensure all checks pass before proceeding.

---

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/AnjaTodorov/slovingo.git
cd slovingo
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Add Android app to your Firebase project
3. Download `google-services.json` and place it in `android/app/`
4. Enable the following Firebase services:
   - Authentication (Email/Password and Google Sign-In)
   - Cloud Firestore
   - Firebase Storage (optional, for profile images)

### 4. Environment Configuration

Create a `.env` file in the root directory:

```env
GEMINI_API_KEY=your_gemini_api_key_here
```

To get a Gemini API key:
1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Create a new API key
3. Add it to your `.env` file

### 5. Run the Application

```bash
flutter run
```

---

## Configuration

### Firebase Configuration

1. **Authentication Setup**:
   - Enable Email/Password authentication
   - Enable Google Sign-In and configure OAuth credentials

2. **Firestore Setup**:
   - Create a Firestore database
   - Set up security rules (start with test mode for development)

3. **Storage Setup** (optional):
   - Enable Firebase Storage
   - Configure storage rules

### API Keys

- **Gemini API Key**: Required for translation functionality
  - Get your key from [Google AI Studio](https://makersuite.google.com/app/apikey)
  - Add to `.env` file as `GEMINI_API_KEY`

---

## Project Structure

```
slovingo/
├── android/                 # Android-specific files
├── lib/
│   ├── models/             # Data models
│   │   ├── user.dart
│   │   ├── level.dart
│   │   ├── word.dart
│   │   ├── progress.dart
│   │   ├── quiz.dart
│   │   ├── translation.dart
│   │   ├── chat_message.dart
│   │   └── lesson_task.dart
│   ├── screens/            # UI screens
│   │   ├── home_screen.dart
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   ├── profile_screen.dart
│   │   ├── translate_screen.dart
│   │   ├── chat_screen.dart
│   │   ├── quiz_screen.dart
│   │   ├── level_detail_screen.dart
│   │   ├── statistics_screen.dart
│   │   ├── trophies_screen.dart
│   │   ├── streak_calendar_screen.dart
│   │   ├── lesson_search_screen.dart
│   │   └── main_navigation.dart
│   ├── services/           # Business logic services
│   │   ├── auth_service.dart
│   │   ├── database_helper.dart
│   │   ├── level_service.dart
│   │   ├── word_service.dart
│   │   ├── translation_service.dart
│   │   ├── chat_service.dart
│   │   ├── firestore_user_service.dart
│   │   ├── firestore_progress_service.dart
│   │   ├── storage_service.dart
│   │   └── notification_service.dart
│   ├── providers/          # State management
│   │   └── app_provider.dart
│   ├── widgets/            # Reusable widgets
│   │   ├── level_card.dart
│   │   └── word_of_the_day_card.dart
│   ├── theme.dart          # App theming
│   └── main.dart           # Entry point
├── assets/                 # Assets (images, etc.)
│   └── character.png
├── dokumentacija/          # Documentation
├── .env                    # Environment variables (not in git)
├── pubspec.yaml            # Dependencies
└── README.md
```

---

## Key Features Explained

### Learning Levels System

The app organizes learning content into progressive levels:
- **Starter**: Introduction to basics
- **Beginner**: Foundational vocabulary and grammar
- **Intermediate**: More complex structures
- **Upper Intermediate**: Advanced concepts
- **Advanced**: Near-native level content
- **Expert**: Mastery-level materials

Each level contains multiple lessons, and users must complete quizzes with a passing score to unlock subsequent levels.

### Statistics & Analytics

The statistics screen provides:
- **Visual Charts**: Bar charts for level progress and translation activity
- **Key Metrics**: Total points, current level, streak, and translation count
- **Learning Overview**: Member since, last active, levels completed
- **Progress Tracking**: Comprehensive view of learning journey

### Trophies & Achievements

Users can unlock trophies based on:
- Level completion milestones
- Points earned
- Streak maintenance
- Translation activity

Each trophy has unique icons and colors, providing visual feedback and motivation.

### Translation System

Powered by Google Gemini AI:
- Real-time translation between English and Slovenian
- Translation history with modern, organized UI
- Language direction swapping
- Timestamp tracking

---

## Authors

**Slovingo Development Team**

- **Anastasija Todorov**
- **Konstantin Mihajlov**
- **Anastasija Nechoska**

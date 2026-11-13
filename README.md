# first_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

# Findr 360

### A Mobile Application for Discovering PG Accommodations, Mess Facilities, and Coaching Classes

Findr 360 is a Flutter-based mobile application developed to help students and individuals discover important local services through a single platform.

Instead of searching through multiple websites, advertisements, and social media platforms, users can browse PG accommodations, Mess facilities, and Coaching Classes in one place.

The application provides service information such as names, locations, prices or fees, contact details, and images.

## 🎯 Project Objectives

- Provide a centralized platform for discovering local services.
- Help students find suitable PG accommodations and Mess facilities.
- Help users discover Coaching Classes.
- Make service information easy to access and search.
- Allow administrators to manage service listings.
- Provide a simple and user-friendly mobile interface.

## ✨ Main Features

- **User Registration and Login:** Secure user authentication using Firebase Authentication.
- **PG Listings:** Browse PG accommodation details, locations, prices, and contact information.
- **Mess Listings:** Explore Mess facilities and meal-related information.
- **Coaching Classes:** Discover coaching classes, subjects, fees, and other details.
- **Search Functionality:** Search for relevant service listings.
- **Admin Module:** Manage service information and listings.
- **Splash Screen:** Displays the application logo when the app starts.
- **Image Display:** Loads service images from Azure Blob Storage.

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Flutter | Mobile application development |
| Dart | Programming language |
| Firebase Authentication | User registration and login |
| Cloud Firestore | Storing user and service information |
| Azure Blob Storage | Storing service images |
| Android Studio | Development environment |
| VS Code | Code editing |

## 🏗️ System Architecture

Findr 360 uses a combination of mobile application and cloud services.

1. **Frontend:** Flutter and Dart provide the mobile user interface.
2. **Authentication:** Firebase Authentication manages user authentication.
3. **Database:** Cloud Firestore stores user details and service listings.
4. **Image Storage:** Azure Blob Storage stores images.
5. **Image Retrieval:** Image URLs or references stored in Firestore are used to display images in the application.

## 📂 Main Modules

1. Registration Module
2. Login Module
3. Admin Module
4. PG Module
5. Mess Module
6. Coaching Classes Module
7. Search Module
8. Authentication and Security Module

## ⚙️ Installation and Setup

### Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio or Visual Studio Code
- Firebase project
- Azure Blob Storage account configured for the application's images

### Steps to Run the Project

**1. Clone the repository**

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
```

**2. Open the project folder**

```bash
cd YOUR_PROJECT_FOLDER
```

**3. Install dependencies**

```bash
flutter pub get
```

**4. Configure Firebase**

Connect the Flutter application to your Firebase project and configure Firebase Authentication and Cloud Firestore.

**5. Configure Azure Blob Storage**

Configure the image storage references required by the application.

**6. Run the application**

```bash
flutter run
```

*Note: Replace the repository URL and project folder name with your actual details. Firebase and Azure configuration must be completed before running the application.*

## 🔒 Security

- Firebase Authentication is used for user authentication.
- Database access should be controlled using appropriate Firestore security rules.
- Privileged Azure storage keys and credentials should never be included in the mobile application or public repository.
- Public image access should be limited to non-sensitive image files.

## 🚧 Current Project Scope

The current version focuses on browsing and searching information about PG accommodations, Mess facilities, and Coaching Classes.

The following features are not currently included:

- Online booking and payment
- GPS-based navigation
- User ratings and reviews
- Advanced recommendation system

## 🚀 Future Enhancements

- Map-based location discovery
- Price and location filters
- User ratings and reviews
- Verified service-provider profiles
- Push notifications
- Online enquiry and booking
- Secure online payment
- Personalized recommendations
- Improved administrative reporting
- Performance and accessibility improvements

## 🎓 Project Information

**Project Name:** Findr 360

**Project Type:** Final-Year Academic Project

**Platform:** Android Mobile Application

**Frontend:** Flutter and Dart

**Backend Services:** Firebase and Azure Blob Storage

**Project Domain:** Mobile Application Development

## 👨‍💻 Developed By

**Team Members:**
- Ijhar Patel
- 

---

### Findr 360 – Discover Everything in One Place!


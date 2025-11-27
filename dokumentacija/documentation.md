# Slovingo – Project Documentation

## Table of Contents
1. [Introduction](#1-introduction)  
2. [Main Functionalities](#2-main-functionalities)  
3. [Screen Prototypes](#3-screen-prototypes)  
   - 3.1 [Home Screen 1](#31-home-screen-1)  
   - 3.2 [Home Screen 2](#32-home-screen-2)  
   - 3.3 [Translate Screen](#33-translate-screen)  
   - 3.4 [Chat Screen](#34-chat-screen)  
   - 3.5 [Profile Screen](#35-profile-screen)  
4. [Use Case Diagram](#4-use-case-diagram)  
5. [ER Diagram](#5-er-diagram)  



---

## 1. Introduction
<p style="text-align: justify;">
&nbsp;&nbsp;&nbsp;&nbsp;Slovingo is a mobile application built to support users in learning the Slovenian language through structured lessons, interactive quizzes, AI-powered tutoring, and translation capabilities. The system is designed to be intuitive, visually clean, and accessible to learners of all levels. This documentation contains the key visual and conceptual components of the application, including prototype screens, a use case diagram, and the ER (Entity–Relationship) model that represents the application’s underlying data structure.
</p>

---

## 2. Main Functionalities

<p style="text-align: justify;">
&nbsp;&nbsp;&nbsp;&nbsp;Presented below are the core functionalities that structure the learning experience in Slovingo. Each part of the system is designed to guide the learner, track progress, and support the learning process through AI-driven tools.
</p>

### 🔹 Learning Levels
<p style="text-align: justify;">
&nbsp;&nbsp;&nbsp;&nbsp;The app offers multiple learning levels that gradually introduce new vocabulary and grammar. Users progress by completing lessons and unlocking new categories.
</p>

### 🔹 Translator
<p style="text-align: justify;">
&nbsp;&nbsp;&nbsp;&nbsp;A bilingual translator (English ↔ Slovenian) powered by OpenAI. Translations are stored into a local SQLite history for later review.
</p>

### 🔹 AI Chat Tutor
<p style="text-align: justify;">
&nbsp;&nbsp;&nbsp;&nbsp;An integrated virtual tutor that allows users to practice Slovenian through natural conversation. The AI provides explanations, corrections, and vocabulary suggestions.
</p>

### 🔹 Word of the Day
<p style="text-align: justify;">
&nbsp;&nbsp;&nbsp;&nbsp;Displays a daily randomly selected Slovenian word with English translation and an example sentence. This encourages daily engagement and expands vocabulary.
</p>

### 🔹 Quizzes & Testing
<p style="text-align: justify;">
&nbsp;&nbsp;&nbsp;&nbsp;Each level includes interactive quizzes that test understanding. Question types include multiple-choice, fill-in-the-blank, and translation tasks.
</p>

### 🔹 User Profile & Statistics
<p style="text-align: justify;">
&nbsp;&nbsp;&nbsp;&nbsp;The profile screen shows progress, streak, points, levels completed, and overall performance metrics, providing a comprehensive learning overview.
</p>

---

## 3. Screen Prototypes

### 3.1 Home Screen 1  
<p style="text-align: justify;">
&nbsp;&nbsp;&nbsp;&nbsp;This screen serves as the main dashboard showing the greeting, word of the day, and the first available learning levels.
</p>

<p align="center">
  <img src="https://github.com/AnjaTodorov/slovingo/blob/main/dokumentacija/screens/home_screen_1.png" alt="Home Screen 1" width="25%">
</p>

---

### 3.2 Home Screen 2  
<p style="text-align: justify;">
&nbsp;&nbsp;&nbsp;&nbsp;Shows additional locked categories and allows the user to view all levels and their availability.
</p>

<p align="center">
  <img src="https://github.com/AnjaTodorov/slovingo/blob/main/dokumentacija/screens/home_screen_2.png" alt="Home Screen 2" width="25%">
</p>

---

### 3.3 Translate Screen  
<p style="text-align: justify;">
&nbsp;&nbsp;&nbsp;&nbsp;A clean interface allowing users to enter text and receive AI-generated translations, with built-in translation history.
</p>

<p align="center">
  <img src="https://github.com/AnjaTodorov/slovingo/blob/main/dokumentacija/screens/translate_screen.png" alt="Translate Screen" width="25%">
</p>

---

### 3.4 Chat Screen  
<p style="text-align: justify;">
&nbsp;&nbsp;&nbsp;&nbsp;Displays the conversational interface where users interact with the AI tutor for grammar help, practice, and explanations.
</p>

<p align="center">
  <img src="https://github.com/AnjaTodorov/slovingo/blob/main/dokumentacija/screens/chat_screen.png" alt="Chat Screen" width="25%">
</p>

---

### 3.5 Profile Screen  
<p style="text-align: justify;">
&nbsp;&nbsp;&nbsp;&nbsp;Presents the user’s statistics including points, streak, levels completed, accuracy, and available profile options.
</p>

<p align="center">
  <img src="https://github.com/AnjaTodorov/slovingo/blob/main/dokumentacija/screens/profile_screen.png" alt="Profile Screen" width="25%">
</p>

---

## 4. Use Case Diagram

<p style="text-align: justify;">
&nbsp;&nbsp;&nbsp;&nbsp;The use case diagram illustrates how the user interacts with various components of the Slovingo system. It includes core actions such as account creation, progress tracking, completing lessons, solving quizzes, translating text, chatting with the AI tutor, and viewing the word of the day. The AI system is represented as an external actor that supports translation and conversational tutoring.  
<br>&nbsp;&nbsp;&nbsp;&nbsp;This diagram clarifies the functional scope and helps understand how system features interconnect from the user’s perspective.
</p>

<p align="center">
<img src="https://github.com/AnjaTodorov/slovingo/blob/main/dokumentacija/assets/slovingo-use-case.png" width="60%">
</p>

---

## 5. ER Diagram

<p style="text-align: justify;">
&nbsp;&nbsp;&nbsp;&nbsp;The ER (Entity–Relationship) diagram displays the logical database structure used by the Slovingo application. It consists of multiple tables representing users, lessons, tasks, quiz progress, translations, chat messages, and the word of the day.  
</p>

&nbsp;&nbsp;&nbsp;&nbsp;Key design insights:
- The **Users** table stores authentication and learning statistics.  
- The **Levels** table defines progressively unlocked learning stages.  
- **Lesson tasks** represent quizzes and vocabulary questions.  
- The **User progress** table tracks attempts, completion, and performance.  
- **Translations** store AI-generated translation entries.  
- **AI chat messages** store recorded conversations with the virtual tutor.  
- **Word of the day** provides a daily vocabulary entry.  


<p align="center">
<img src="https://github.com/AnjaTodorov/slovingo/blob/main/dokumentacija/assets/slovingo_erd.png" alt="ER Diagram" height="700px" width="600px">
</p>

---


<p style="text-align: justify;"><i>
&nbsp;&nbsp;&nbsp;&nbsp;This prototype documentation provides a structured and professional overview of Slovingo’s core components, including visual prototypes, system functionalities, data architecture, and interactive flows. The materials included here serve as a foundation for understanding both the technical structure and user-facing design of the application.
</i></p>

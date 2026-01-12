plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.slovingo"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.slovingo"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
          signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:34.4.0"))

    // Optional: Firebase Analytics
    implementation("com.google.firebase:firebase-analytics")

    // Firebase Authentication SDK
    implementation("com.google.firebase:firebase-auth")

    // Material components (provides Theme.MaterialComponents.*)
    implementation("com.google.android.material:material:1.12.0")
}

// Copy APK to Flutter's expected location so flutter run can find it
afterEvaluate {
    tasks.named("assembleDebug").configure {
        doLast {
            val apkFile = file("${layout.buildDirectory.get()}/outputs/apk/debug/app-debug.apk")
            // project.rootDir is android/, so go up one level to get Flutter project root
            val flutterProjectRoot = project.rootDir.parentFile
            val flutterApkDir = File(flutterProjectRoot, "build/app/outputs/flutter-apk")
            val flutterApkFile = File(flutterApkDir, "app-debug.apk")
            
            if (apkFile.exists()) {
                flutterApkDir.mkdirs()
                apkFile.copyTo(flutterApkFile, overwrite = true)
                println("Copied APK to Flutter expected location: ${flutterApkFile.absolutePath}")
            } else {
                println("WARNING: APK file not found at ${apkFile.absolutePath}")
            }
        }
    }
}
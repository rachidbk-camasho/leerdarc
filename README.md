# Leer Darija 🇲🇦

Een moderne Flutter-app om Marokkaans Darija te leren, speciaal gemaakt voor
Nederlandstalige gebruikers. De app bevat drie niveaus — **Basis**, **A1** en
**A2** — met flashcards en korte quizzen per les.

- Flitskaarten die draaien tussen Darija (Latijns schrift + Arabisch) en
  Nederlands.
- Voortgang die lokaal op het toestel wordt bijgehouden.
- Modern, warm ontwerp geïnspireerd op Marokkaanse zellige-tegels.
- Kant-en-klare `codemagic.yaml` om automatisch een iOS-build naar App Store
  Connect / TestFlight te sturen.

This repo intentionally ships **only the Dart/Flutter source** (`lib/`,
`pubspec.yaml`, tests). The native `ios/` and `android/` folders are
generated fresh by Codemagic on every build (see `codemagic.yaml`), so
there's nothing platform-specific to keep in sync or accidentally break by
hand-editing Xcode project files.

## Project structure

```
lib/
  main.dart              # App entry point
  theme/app_theme.dart   # Colors, typography, Material theme
  models/models.dart     # DarijaCard, Lesson, DarijaLevel
  data/content.dart      # All lesson content (Basis / A1 / A2)
  services/progress_service.dart  # Local progress tracking
  screens/               # Home, Level, Lesson (flashcards), Quiz
  widgets/                # Flashcard, LevelCard
codemagic.yaml           # CI/CD: build + publish to App Store Connect
```

## 1. Run it locally (optional, needs Flutter installed)

```bash
flutter pub get
flutter run
```

If you don't have `ios/`/`android/` folders yet (they're gitignored), run
once:

```bash
flutter create --platforms=ios,android --org com.leerdarija --project-name app .
```

## 2. Push to GitHub

```bash
git init
git add .
git commit -m "Initial commit: Leer Darija"
git branch -M main
git remote add origin https://github.com/<your-username>/leer-darija.git
git push -u origin main
```

## 3. Connect the repo to Codemagic

1. Go to [codemagic.io](https://codemagic.io) and sign in with GitHub.
2. **Add application** → pick your `leer-darija` repository.
3. Codemagic will detect the `codemagic.yaml` at the repo root and use it
   automatically (workflow-based configuration).

## 4. Set up the App Store Connect integration (needed to publish)

1. In App Store Connect, create the app record:
   - **Bundle ID**: `com.leerdarija.app` (register it first under
     [Certificates, Identifiers & Profiles](https://developer.apple.com/account/resources/identifiers/list)
     if it doesn't exist yet).
   - **App name**: Leer Darija.
   - **Primary language**: Dutch.
2. Create an **App Store Connect API key**:
   Users and Access → Integrations → App Store Connect API → generate a key
   with the **App Manager** role. Download the `.p8` file, and note the
   **Key ID** and **Issuer ID**.
3. In Codemagic: **Teams → Integrations → App Store Connect** → add the API
   key (upload the `.p8`, Key ID, Issuer ID). Name the integration
   `codemagic_asc_api_key` — or update the name in `codemagic.yaml` under
   `integrations.app_store_connect` if you name it differently.
4. Codemagic will handle iOS code signing automatically (automatic
   provisioning) using this same integration — no manual certificates or
   provisioning profiles needed.

## 5. Trigger a build

Push to `main` (or use "Start new build" in the Codemagic dashboard, picking
the `ios-app-store` workflow). Codemagic will:

1. Generate the native iOS project (`flutter create ...`).
2. Fetch packages and CocoaPods.
3. Build a release `.ipa`.
4. Upload it to **TestFlight** automatically (`submit_to_testflight: true`).

Once you've tested a build in TestFlight and you're ready to submit it for
App Review, set `submit_to_app_store: true` in `codemagic.yaml`, or submit
that build manually from App Store Connect.

Update the notification email in `codemagic.yaml`
(`publishing.email.recipients`) to your own address so you get notified.

## 6. Editing the lesson content

All vocabulary lives in `lib/data/content.dart`, grouped by level and lesson.
Each card looks like this:

```dart
DarijaCard(
  darijaLatin: 'Salam',
  darijaArabic: 'سلام',
  dutch: 'Hallo',
  note: 'Optionele gebruikstip',
),
```

Add a new `Lesson(...)` to a level's `lessons` list, or a new `DarijaLevel`
to `DarijaContent.levels`, to expand the app — the UI (home screen, level
screen, flashcards, quiz) automatically picks up any content you add.

## Notes on the Darija transliteration

Darija is normally written in Latin letters using numbers to represent
Arabic sounds that don't exist in Dutch/English (e.g. `3` for ع, `7` for ح,
`9` for ق). This app uses that convention alongside Arabic script, since
that's how Darija is actually typed and read day-to-day.

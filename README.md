# Study Load

A responsive Flutter app to track assignments with start date and deadline. Uses the current calendar week and highlights today. Rows show D-day countdown from start date to deadline. Completed assignments appear in greyscale.

## Application idea and purpose

- **Purpose:** Help students see their assignment load for the current week and how close each assignment is to its deadline.
- **Features:**
  - Add assignments with name, start date, and deadline.
  - Current Week table: fixed columns (Assignment name, Monday–Sunday); today’s column is highlighted.
  - Each cell on the table shows D-day countdown.
  - Mark assignments as done; done rows switch to greyscale.
  - Assignment detail screen (path `/assignment/:id`), statistics screen.

## How to use

1. **Run the app** (with Flutter in PATH):
   ```bash
   cd study_load_app
   flutter pub get
   flutter run -d chrome
   ```
   Or run on another device: `flutter run`.

2. **Add assignment:** Tap "Add" or "Add assignment". Enter name, start date, and deadline, then "Add assignment".

3. **Week view:** The home screen shows the current week (Mon–Sun). Today's column is highlighted. Each row is one assignment; D-day countdown is shown in each cell. Tap the circle to mark done/not done; tap the name to open the detail screen.

4. **Screens:**
   - **Home:** Week table and "Add" FAB.
   - **Add assignment:** Form (name, start date, deadline).
   - **Assignment detail:** `/assignment/<id>` – view and toggle done.
   - **Statistics:** Total, done, pending, overdue, completion %.

## Deployed URL

To deploy this application online:

1. Build the web version (already done): `flutter build web --release`
2. The production build is in `build/web/`
3. Deploy using one of the options below

### Deployment Options

**Option 1: Firebase Hosting** (Recommended)
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Log in to Firebase
firebase login

# Initialize Firebase (first time only)
firebase init hosting

# Deploy
firebase deploy
```

**Option 2: GitHub Pages**
1. Commit and push `build/web/` to your GitHub repository
2. Enable GitHub Pages in repository settings
3. The app will be available at `https://<username>.github.io/<repo-name>/`

**Option 3: Other Hosting Services**
Deploy the contents of `build/web/` to Vercel, Netlify, AWS S3, or any static hosting service.

For detailed instructions, see: [Flutter Web Deployment Documentation](https://docs.flutter.dev/deployment/web)

## Requirements (course project)

- Clear purpose; easy to use.
- Responsive: at least two breakpoints (e.g. mobile & tablet) and max content width.
- Form for entering data; data persisted (Hive) between restarts.
- Interact with data (mark done, tap to detail); statistics screen.
- Main screen + at least three distinct screens; at least one uses path variables (`/assignment/:id`); intuitive navigation.
- Deployable to web (Flutter web).


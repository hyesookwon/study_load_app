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

1. **Add assignment:** Tap "Add" or "Add assignment". Enter name, start date, and deadline, then "Add assignment".

2. **Week view:** The home screen shows the current week (Mon–Sun). Today's column is highlighted. Each row is one assignment; D-day countdown is shown in each cell. Tap the circle to mark done/not done; tap the name to open the detail screen.

3. **Screens:**
   - **Home:** Week table and "Add" FAB.
   - **Add assignment:** Form (name, start date, deadline).
   - **Assignment detail:** `/assignment/<id>` – view and toggle done.
   - **Statistics:** Total, done, pending, overdue, completion %.


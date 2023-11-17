# TaskWit

## Introduction
You will create a to-do list application by using your preferred mobile application development framework. People are finding it harder and harder to remember and manage daily tasks in this fast-paced world. By creating a to-do list app, users can create and manage their daily tasks more easily.

## Requirements
- [x] The application should open with a splash screen
- [x] There should be **three categories** at the top of the screen:
    * Pending
    * Completed
    * Overdue
- [x] If the to-do list is empty, show an empty state message: “No items to display. Please press “Add” to add new items.”
- [x] Show a fixed navigation bar at the bottom of the screen with an “Add” button, which allows the user to create a new task
- [x] Clicking the “Add” button will show a screen with the following elements:
    * Title (text input field)
    * Description (text input field)
    * Deadline (iOS or Android default date and time selector)
    * Confirm button
    * Cancel button
- [] Each new task should have a deadline later than the current time. Adding a task will save it to the file storage in the text file.
- [] Users can perform different actions by selecting single or multiple items:
    * “Pending” category
        * One item selected: the user can press “Delete,” “Edit,” or “Complete”
        * Multiple items selected: the user can press “Delete” or “Complete”
    * “Overdue” category
        * One item selected: the user can press “Delete,” “Edit” or “Complete”
        * Multiple items selected: the user can press “Delete” or “Complete”
    * “Completed” category
        * One item selected: the user can press “Delete” or “Edit”
        * Multiple items selected: the user can press “Delete” or “Edit”
- [] When the user presses on the “Edit” button, a screen should pop up with:
    * Title (text input field with pre-filled data)
    * Description (text input field with pre-filled data)
    * Deadline (iOS or Android default date and time selector with pre-filled data)
    * Confirm button
    * Cancel button
    * Complete button
    * 10 minutes before the deadline of a task, users will receive a push notification to remind them of the task# TaskWit

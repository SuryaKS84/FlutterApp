Assignment => Flutter App with Back4App Integration:

Name: SURYANARAYANAN KS => BITS ID: 2022mt93251

**Task Manager**
Welcome to the Task Manager, a handy tool for organizing your tasks and their descriptions efficiently.

**Key Features**:

**Add New Tasks**: Easily create new tasks with their descriptions and set them as open.

**Delete Tasks**: Quickly remove any tasks that were created by mistake.

**Update Information**: Edit and correct any information in your tasks.

**Task Completion**: Mark tasks as done when they are completed.

**Filter Open Tasks**: View only the tasks that are currently open.

**Getting Started**

**Setup Back4App**

Sign up for back4App => https://www.back4app.com/
Create a New Back4App App: a) Create a new app in the Back4App dashboard (for example: Assignment) b) Create a class named "Task" with columns "title" (String) and "description" (String).

**Install Pre-reqs**

Install Flutter on Windows: => Download the Flutter SDK. => Extract the downloaded ZIP file to a location on your computer. => Add the Flutter bin directory to your system PATH.
Install Android Studio and Visual Studio Code
Setup an Emulator a) Open Android Studio => Virtual Device Manager b) Create new device and download c) run the Emulator and check

**Verify installation**

run "Flutter doctor' on terminal and look for errors
ensure there are no errors (common error for example: download and install x64 latest android setup via android studio)

**Flutter Setup**

Create a New Flutter Project: => "flutter create firstApp" under CAPD-Assignment-Flutter-task-App
Drag and Drop "firstApp" folder into VSCode

**Update Dependencies in pubspec.yaml**

=> parse_server_sdk, package_info_plus, parse_server_sdk_flutter

** Build Flutter TaskApp:**

1. Edit Flutter_App/lib/main.dart
2. Import required dart packages
3. Declare Task Class
4. In Main method, update Application ID, client key and parseapi url a) copy App ID, client key from back4App.

Implement TaskListScreen extended from Main App (MyApp) with the methods used in the code for the features mentioned

** Run the application**

Select the device in VS Code => installed emulator or Chrome
execute flutter run from terminal or Menu > run > start without debugging and from terminal => flutter run --release for release build

**Test the Application against back4App Task Class**

**Home Screen** => Fetch tasks with create task icon 

**Create task** => with task name and description fields to create

**Bonus Features (Update and Delete tasks)**

**Update task **=> Select existing task and update the name or decription

**Delete task **=> Select existing task and click delete icon







**Install Flutter**
If you haven't installed Flutter yet, follow the official documentation: https://docs.flutter.dev/get-started/install

**Local Development**
Clone the project to your local system.

Open the command prompt at the project location.

Run the following command:

**flutter pub get**

Check available emulators/devices:
**flutter devices**

Start an Android emulator:

**flutter emulators --launch <emulator_name>**
Run the application on a specific device:

**flutter run -d <DEVICE_ID_OR_DEVICE_NAME>**

Once the emulator is ready, you will see a list of connected devices.

Found 2 connected devices:
For detailed instructions on setting up the environment for Windows, refer to Figure 3.

**App Screenshots**
**Android Main Screen **
Android Main Screen

**Windows Main Screen **
Windows Main Screen

**Add Task Screen **
Add Task Screen

It allows you to enter task details, validating that they are not empty.
**View Task Details Screen **
View Task Screen

**Update Task Details Screen )**
Update Task Screen

**Delete Task Screen **
Delete Task Screen

**To-Do Task Screen )**
To-Do Task Screen

**Not Done Filter Task Screen **
Not Done Filter Task Screen

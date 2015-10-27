# Rubymotion Android Memory Leak Test
## Setup
- connect your device to your mac
- make sure to use the right api version for your target device (see rakefile, currently API Version 19)
- Install Android Studio (http://developer.android.com/sdk/index.html)
- Install Eclipse Memory Analyzer (https://eclipse.org/mat/)
- Open Android Studio
- Create a new project (sorry, haven't yet found out how to start Android Device Manager without a project)
- Click on the second to last item (little Android Symbol) with the tooltip "Android Device Monitor"
- you can close Android Studio now
- On the left side of the ADM you see a list of running processes on your connected device
- run the app with `rake device`, it will appear in the process list on the left
- select the com.yourcompany.leaktest process and start the heap update with the second icon above the process list.
  On the right side, some stats about the current heap state will appear everytime a garbage collection is caused.
- let the app run for a while and then click on the third icon above the process list, to export the current heap into a file.
- convert the exported heap file to a format the Eclipse Memory Analyzer can use:
  ```
  ~/.rubymotion-android/sdk/platform-tools/hprof-conv /PATH_TO_DUMP/com.yourcompany.leaktest.hprof /PATH_TO_DUMP/com.yourcompany.leaktest-converted.hprof
  ```
- open the converted file in Eclipse Memory Analyzer and discard the wizard window.
  Go to the histogram (second item in the menubar at the center) and enter "leak" in the first line of the list.
  This will filter to show only objects from the leaktest process
  If everything goes as it does on my machine, there should be a lot of Item objects, despite having only 2 items in the database.

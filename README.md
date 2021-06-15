# albert_t

First checkout the project and start the **Albert_t.xcodeproj** file, there are no third party dependencies, so it’s pretty simple. In case you want to build on a real device, add your bundle ID project settings. 

# User Interface:
* Just build the app and you will see the loading screen while the art list data is being fetched from the API. 
* You can scroll down to the bottom of the list to fetch more.
* After the successful data retrieval, art list is shown in a classical table view list (although it’s done via collection view)
* In case of any error an alert is presented (turn the internet off and restart the app or try to tap a destination to try it out). Of course, this can be done in much more detail if Reachability class is used, but it would go outside of scope of this test project and it was mentioned to avoid 3rd party libs or other solutions. 
* Everything you see in this project is custom made, so nothing has been copied or used from some other source. 
* To see the art details tap on the cell and Art Details Screen will appear. Tap again on the image and you will be able to explore it by zooming and panning 
* Turn the internet off, the app will still function.

# Architecture:
* MMVM -C (with coordinator) is used as an app design pattern since it complements Apple's native, out of the box, MVC for UIKit and it's new MVVM in SwiftUI.
* Networking module is independent and can be implemented anywhere. It is based on Apple's “URLSession” and generics so no third party libs have been used.
* There is a custom loading screen and alert for the user feedback. 
* Unit tests are made for view models and moc JSON of art products list and details, they are just examples and many more tests can be done
* Reusable components have been made (like ArtImageView) for illustration purposes. 
* File organisation: 
    * App - App related data 
     *Models
    * Views
    * ViewControllers
    * ViewModels
    * Lib - all custom made libraries with the main one being the networking module under “Networking” 
    * No XIB files or storyboards have been used as it was requested.  
    * Resources - Images only

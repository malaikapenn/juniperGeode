# Juniper Geode
This project is a Unity plugin written in Swift and used to connect to a Juniper Geode for higher GPS accuracy.

#Helpful Resources
- External accessory code for Swift, this was the base of the project (https://github.com/rvndios/EADemo)
- Connection documentation for Juniper Geode (https://www.junipersys.com/data/support/documentation/Geode/Connecting-iOS-apps-to-Geode.pdf)
- Tutorial on implementing Swift in Unity (https://medium.com/@kevinhuyskens/implementing-swift-in-unity-53e0b668f895)
- Unity iOS Plugin documentation (https://docs.unity3d.com/2018.4/Documentation/Manual/PluginsForIOS.html)

#Method
1. The external accessory example project was used as the base. You have to add 'com.junipersys.geode' to the Info.plist under UISupportedExternalAccessoryProtocols to allow the application to look for the Geode specifically. After that, the Swift code was able to connect and read the strings being sent from the Geode. 
    - NOTE: The Geode has to be connected to the device via Bluetooth before it can be discovered as an external accessory.
2. The Swift project needed to be turned into an iOS plugin in order for Unity to call the methods and receive data. You do this by creating an Objective-C header file in Swift (see tutorial on Swift in Unity above).
3. Once the plugin is in Unity, you can call the Swift methods using the iOS plugin documentation above. The Swift project can call "UnitySendMessage" to send the updated GPS strings to Unity, which captures that call as an event.

#Adding the Plugin to a Unity Project
1. Add the JuniperPlugin folder to Plugins->iOS in your Unity project.
2. Call the functions from anywhere in your project:
   - SwiftForUnity.setupAccessoryList(); - starts scan for Juniper devices
   - SwiftForUnity.IsAccessory(); - returns true/false if it found a Geode
   - SwiftForUnity.connect(); - connects to the available Geode
   - SwiftForUnity.disconnect(); - disconnects from the available Geode
3. To receive the updated NMEA strings, you must have an object called [GPS Manager] with a method:
   - public void ReceiveMessage(string nmeaMessage) { parse/use the string here }

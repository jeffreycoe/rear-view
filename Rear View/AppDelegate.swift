//
//  AppDelegate.swift
//  Rear View
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let config = ConfigManager.init()
    @IBOutlet weak var mnuAlwaysOnTop: NSMenuItem!
    var mainWindow: NSWindow?
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        if(config.getDefaultCameraDeviceID().isEmpty) {
            let videoManager = VideoManager.init()
            let devices = videoManager.getVideoDevices()
            
            config.setDefaultCameraDeviceID(devices![0].uniqueID)
        }
        
        // Really shouldn't do this ever
        mainWindow = NSApplication.sharedApplication().windows[0]
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        
    }

    @IBAction func alwaysOnTopChanged(sender: AnyObject) {
        if(mnuAlwaysOnTop.state == NSOnState) {
            mnuAlwaysOnTop.state = NSOffState
            mainWindow?.level = Int(CGWindowLevelForKey(CGWindowLevelKey.NormalWindowLevelKey))
        } else {
            mnuAlwaysOnTop.state = NSOnState
            mainWindow?.level = Int(CGWindowLevelForKey(CGWindowLevelKey.MaximumWindowLevelKey))
        }
    }
}


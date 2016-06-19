//
//  MainWindowController.swift
//  Rear View
//

import Cocoa

class MainWindowController: NSWindowController {
    @IBOutlet weak var mainWindow: NSWindow!

    override func windowDidLoad() {
        super.windowDidLoad()
    
        mainWindow.movableByWindowBackground = true
        mainWindow.makeKeyAndOrderFront(nil)
        mainWindow.level = Int(CGWindowLevelForKey(CGWindowLevelKey.MaximumWindowLevelKey))
        
    }
    
}

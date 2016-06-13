//
//  ConfigManager.swift
//  Rear View
//

import Foundation

class ConfigManager {
    private let defaultCameraIDKey: String = "defaultCameraDeviceID"
    private let plistPath = NSBundle.mainBundle().pathForResource("config", ofType: "plist")
    private let config: NSMutableDictionary
    
    init() {
        config = NSMutableDictionary(contentsOfFile: plistPath!)!
    
    }
    
    func getDefaultCameraDeviceID() -> String {
        let id: String = config.objectForKey(defaultCameraIDKey) as! String
        
        return id
    }
    
    func setDefaultCameraDeviceID(id: String) {
        config.setObject(id, forKey: defaultCameraIDKey)
        config.writeToFile(plistPath!, atomically: true)
    }
}
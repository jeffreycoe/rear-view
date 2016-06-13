//
//  PreferencesViewController.swift
//  Rear View
//

import Cocoa
import AVFoundation

class PreferencesViewController: NSViewController {
    @IBOutlet weak var mnuCameraDevices: NSPopUpButton!
    
    private let config = ConfigManager.init()
    let deviceNames = NSMutableArray()
    let deviceIDs = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateCameraDeviceData()
    }
    
    func populateCameraDeviceData() {
        let videoManager = VideoManager.init()
        let devices = videoManager.getVideoDevices()
        
        for device in devices! {
            if let device = device as? AVCaptureDevice {
                deviceNames.addObject(device.localizedName)
                deviceIDs.addObject(device.uniqueID)
            }
        }
        
        if let data = deviceNames as NSArray as? [String] {
            mnuCameraDevices.addItemsWithTitles(data)
        }
    }
    
    @IBAction func selectedMenuItemChanged(sender: AnyObject) {
        let id = deviceIDs[mnuCameraDevices.indexOfSelectedItem] as! String
        
        config.setDefaultCameraDeviceID(id)
    }
}

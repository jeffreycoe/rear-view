//
//  MainViewController.swift
//  Rear View
//

import Cocoa
import AVFoundation

class MainViewController: NSViewController {
    var session: AVCaptureSession?
    var preview: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let videoManager = VideoManager.init()
        let config = ConfigManager.init()
        let defaultDeviceID = config.getDefaultCameraDeviceID()
        let defaultDevice = videoManager.getDeviceByDeviceID(defaultDeviceID)
        
        if(defaultDevice.uniqueID == defaultDeviceID) {
            session = videoManager.startVideoCapture(defaultDevice)
            initVideoPreviewLayer(session!)
        } else {
            if let devices = videoManager.getVideoDevices() {
                session = videoManager.startVideoCapture(devices[0] as! AVCaptureDevice)
                initVideoPreviewLayer(session!)
            } else {
                let alert = NSAlert()
                
                alert.messageText = "Unable to Find Video Device"
                alert.informativeText = "No available video devices were found.  Please ensure a camera is connected before continuing."
                alert.addButtonWithTitle("OK")
                alert.runModal()
            }
        }
    }
    
    private func initVideoPreviewLayer(session: AVCaptureSession) {
        if(session.running) {
            preview = AVCaptureVideoPreviewLayer.init(session: session)
            preview!.videoGravity = AVLayerVideoGravityResizeAspectFill
            preview!.needsDisplayOnBoundsChange = true
            preview!.bounds = self.view.bounds
            preview!.position = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))
            preview!.cornerRadius = 5
            preview!.borderWidth = 2
            preview!.borderColor = NSColor.redColor().CGColor
            self.view.layer?.autoresizingMask = [CAAutoresizingMask.LayerHeightSizable, CAAutoresizingMask.LayerWidthSizable]
            self.view.layer?.frame = self.view.layer!.bounds
            self.view.layer?.addSublayer(preview!)
        }
    }
    
   override func viewWillLayout() {
        super.viewWillLayout()
        
        if(preview?.superlayer != nil) {
            preview!.position = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))
            preview!.bounds = self.view.bounds
        }
    }
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}


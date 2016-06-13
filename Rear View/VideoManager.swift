//
//  VideoManager.swift
//  Rear View
//

import Foundation
import AVFoundation

class VideoManager {
    let session: AVCaptureSession
    
    init() {
        session = AVCaptureSession()
    }
    
    func startVideoCapture(device: AVCaptureDevice) -> AVCaptureSession {
        do {
            let input = try AVCaptureDeviceInput(device: device) as AVCaptureDeviceInput
            
            if(session.canAddInput(input)) {
                session.addInput(input)
            }
            
            session.startRunning()
        } catch let error as NSError {
            print(error)
        }
        
        return session
    }
    
    func getDeviceByDeviceID(id: String) -> AVCaptureDevice {
        let devices = self.getVideoDevices()
        
        for device in devices! {
            if(device.uniqueID == id) {                
                return device as! AVCaptureDevice
            }
        }
        
        return AVCaptureDevice()
    }
    
    func stopVideoCapture(session: AVCaptureSession) {
        session.stopRunning()
    }
    
    func getVideoOutput(session: AVCaptureSession) -> AVCaptureVideoDataOutput {
        let output = AVCaptureVideoDataOutput()
        
        if(session.canAddOutput(output)) {
            session.addOutput(output)
        } else {
            NSLog("Unable to add output to current video capture session.")
        }
        
        return output
    }
    
    func getVideoDevices() -> [AnyObject]? {
        let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
                
        return devices
    }
}
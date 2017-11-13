//
//  ViewController.swift
//  OpenCV3Sample
//
//  Created by  yeongeon on 11/11/2017.
//  Copyright © 2017  yeongeon. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    var session : AVCaptureSession!
    var device : AVCaptureDevice!
    var output : AVCaptureVideoDataOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if initCamera() {
            session.startRunning()
        }
        
        let t = OpenCVWrapper()
        let v:String = t.openCVVersionString()
        log.debug("+++++ v: \(v)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initCamera() -> Bool {
        session = AVCaptureSession()
        session.sessionPreset = AVCaptureSession.Preset.medium
        
        let device = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                                             for: AVMediaType.video,
                                             position: AVCaptureDevice.Position.back)
        if device == nil {
            return false
        }
        
        do {
            let myInput: AVCaptureDeviceInput?
            try myInput = AVCaptureDeviceInput(device: device!)
            
            if session.canAddInput(myInput!) {
                session.addInput(myInput!)
            } else {
                return false
            }
            
            output = AVCaptureVideoDataOutput()
            output.videoSettings = [ kCVPixelBufferPixelFormatTypeKey as AnyHashable as! String: Int(kCVPixelFormatType_32BGRA) ]
            
            try device?.lockForConfiguration()
            device?.activeVideoMinFrameDuration = CMTimeMake(1, 15)
            device?.unlockForConfiguration()
            
            let queue: DispatchQueue = DispatchQueue(label: "myqueue", attributes: [])
            output.setSampleBufferDelegate(self, queue: queue)
            
            output.alwaysDiscardsLateVideoFrames = true
        } catch let error as NSError {
            print(error)
            return false
        }
        
        if session.canAddOutput(output) {
            session.addOutput(output)
        } else {
            return false
        }
        
        for connection in output.connections {
            if connection.isVideoOrientationSupported {
                connection.videoOrientation = AVCaptureVideoOrientation.portrait
            }
        }
        
        return true
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection){
        DispatchQueue.main.async(execute: {
            let image: UIImage = CameraUtil.imageFromSampleBuffer(buffer: sampleBuffer)
            self.imageView.image = image;
        })
    }
    

}


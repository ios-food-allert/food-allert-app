//
//  ScannerViewController.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 16/01/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import AVFoundation
import UIKit

protocol ScannerViewControllerDelegate:AnyObject {
    func captureCode(code:String)
}

enum cornerPosition {
    case upperLeft
    case inferiorLeft
    case upperRight
    case inferiorRight
}

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var scannerFocus: UIView!
    var codeFrameView : UIView?
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    weak var delegate:ScannerViewControllerDelegate?
    
    private let strokeWidth: CGFloat = 12
    private let halfStroke: CGFloat = 6
    private let drawConstant: CGFloat = 56
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initScan()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.createBrackets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func initScan(){
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417, .upce]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        
        view.bringSubviewToFront(topBar)
        
        if let codeFrameView = codeFrameView {
            codeFrameView.layer.borderColor = UIColor.green.cgColor
            codeFrameView.layer.borderWidth = 2
            view.addSubview(codeFrameView)
            view.bringSubviewToFront(codeFrameView)
        }
        
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            let barCodeObject = previewLayer?.transformedMetadataObject(for: metadataObject)
            codeFrameView?.frame = barCodeObject!.bounds
            
            found(code: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        print(code)
        delegate?.captureCode(code: code)
        self.navigationController?.popViewController(animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    private func createBrackets() {
        
        previewLayer.frame = view.layer.bounds
        scannerFocus.backgroundColor = .clear
        
        let upperLeftLayer = drawScannerFocus(xPosition: halfStroke, yPosition: halfStroke, andCornerPosition: .upperLeft)
        scannerFocus.layer.addSublayer(upperLeftLayer)
        
        let inferiorLeftLayer = drawScannerFocus(xPosition: 0, yPosition: scannerFocus.frame.height, andCornerPosition: .inferiorLeft)
        scannerFocus.layer.addSublayer(inferiorLeftLayer)
        
        let inferiorRightLayer = drawScannerFocus(xPosition: scannerFocus.frame.width, yPosition: scannerFocus.frame.height, andCornerPosition: .inferiorRight)
        scannerFocus.layer.addSublayer(inferiorRightLayer)
        
        let upperRightLayer = drawScannerFocus(xPosition: scannerFocus.frame.width, yPosition: 0, andCornerPosition: .upperRight)
        scannerFocus.layer.addSublayer(upperRightLayer)
        
        self.scannerFocus.layer.zPosition = 10
    }
    
    private func drawScannerFocus(xPosition: CGFloat?, yPosition: CGFloat?, andCornerPosition cornerPostion: cornerPosition) -> CAShapeLayer {
        
        let shapeLayer = CAShapeLayer()
        let bezierPath = UIBezierPath()
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.greenDark.cgColor
        shapeLayer.lineWidth = strokeWidth
        
        guard let horizontalPosition = xPosition else { return shapeLayer }
        guard let verticalPosition = yPosition else { return shapeLayer }
        
        switch cornerPostion {
        case .upperLeft:
            bezierPath.move(to: CGPoint(x: drawConstant, y: verticalPosition))
            bezierPath.addLine(to: CGPoint(x: horizontalPosition, y: verticalPosition))
            bezierPath.addLine(to: CGPoint(x: horizontalPosition, y: drawConstant))
            shapeLayer.path = bezierPath.cgPath
            return shapeLayer
            
        case .inferiorLeft:
            bezierPath.move(to: CGPoint(x: halfStroke, y: verticalPosition - drawConstant))
            bezierPath.addLine(to: CGPoint(x: halfStroke, y: verticalPosition - halfStroke))
            bezierPath.addLine(to: CGPoint(x: drawConstant, y: verticalPosition - halfStroke))
            shapeLayer.path = bezierPath.cgPath
            return shapeLayer
            
        case .inferiorRight:
            bezierPath.move(to: CGPoint(x: horizontalPosition - drawConstant, y: verticalPosition - halfStroke))
            bezierPath.addLine(to: CGPoint(x: horizontalPosition - halfStroke, y: verticalPosition - halfStroke))
            bezierPath.addLine(to: CGPoint(x: horizontalPosition - halfStroke, y: verticalPosition - drawConstant))
            shapeLayer.path = bezierPath.cgPath
            return shapeLayer
            
        case .upperRight:
            bezierPath.move(to: CGPoint(x: horizontalPosition - halfStroke, y: drawConstant))
            bezierPath.addLine(to: CGPoint(x: horizontalPosition - halfStroke, y: halfStroke))
            bezierPath.addLine(to: CGPoint(x: horizontalPosition - drawConstant, y: halfStroke))
            shapeLayer.path = bezierPath.cgPath
            return shapeLayer
        }
    }
    
    @IBAction func cancelScan(){
        self.dismiss(animated: true, completion: nil)
    }
}

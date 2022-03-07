//
//  CameraViewController.swift
//  DataCapture
//
//  Created by Yermis Beltran on 5/03/22.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    let cameraService = CameraService()
    
    @IBOutlet weak var backButton: UIButton!
    
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.layer.addSublayer(cameraService.previewLayer)
        view.addSubview(shutterButton)
        
        cameraService.checkPermissions()

        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cameraService.previewLayer.frame = view.bounds
        
        shutterButton.center = CGPoint(x: view.frame.size.width/2,
                                       y: view.frame.size.height - 100)
    }
    
    @objc private func didTapTakePhoto() {
        cameraService.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else { return }
        let image = UIImage(data: data)
        
        cameraService.session?.stopRunning()
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        imageView.frame = view.bounds
        view.addSubview(imageView)
    }
}

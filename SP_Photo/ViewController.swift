//
//  ViewController.swift
//  SP_Photo
//
//  Created by Siphamandla Simelane on 10/29/15.
//  Copyright © 2015 Siphamandla Simelane. All rights reserved.
//

import UIKit
import MobileCoreServices
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView.frame = view.frame
        view.addSubview(imageView)
        
        let openCamera = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 30))
            openCamera.backgroundColor = UIColor.greenColor();
            openCamera.setTitle("Picture", forState: .Normal)
            openCamera.addTarget(self, action: "openCameraView", forControlEvents: .TouchDown)
        view.addSubview(openCamera)
        
    }
    
    func openCameraView() {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Photo
        imagePicker.showsCameraControls = true
        //imagepicker.cameraOverlayView = whateverViewIMakethat is cool
        imagePicker.allowsEditing = false
        imagePicker.mediaTypes = [kUTTypeImage as String!]
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = image
        //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        let imageData = NSData(data: UIImagePNGRepresentation(normalizeImage(image))!)
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let fullPath = paths[0].stringByAppendingString("/CoolPicBro.png")
        imageData.writeToFile(fullPath, atomically: true)
        loadImage()
    }
    
    func loadImage(){
        let nsDocumentDirectory = NSSearchPathDirectory.DocumentationDirectory
        let nsUserDomainMask = NSSearchPathDomainMask.UserDomainMask
        if let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true) as Array? {
            if paths.count > 0{
                if let dirPath = paths[0] as String? {
                    let readPath = dirPath.stringByAppendingString("/CoolPicBro.png")
                    print(readPath)
                    imageView.image = UIImage(contentsOfFile: readPath)
                }
            }
        }
    }
    
    func normalizeImage(image: UIImage) ->UIImage {
        if (image.imageOrientation == UIImageOrientation.Up) {
            return image
        } else {
            UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
            image.drawInRect(CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
            let normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return normalizedImage;
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


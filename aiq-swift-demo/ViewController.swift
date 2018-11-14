//
//  ViewController.swift
//  aiq-swift-demo
//
//  Created by Khang Toh on 7/11/18.
//  Copyright © 2018 AIQ. All rights reserved.
//

import UIKit
import MobileCoreServices
import SVProgressHUD
import SVWebViewController

class ViewController:
    UIViewController,
    iQScannerViewControllerDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    UITextFieldDelegate
{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let padding = CGFloat( 20.0 );
        
        let scannerButton = UIButton(type: .custom);
        scannerButton.frame = CGRect(x:20.0, y:(20.0 + 20.0), width:(self.view.frame.size.width - 2*20.0), height:44.0);
        scannerButton.backgroundColor = UIColor.lightGray;
        scannerButton.layer.cornerRadius = 4.0;
        scannerButton.setTitle("Open Scanner", for: .normal);
        scannerButton.addTarget(self, action:#selector(self.scannerButtonTapped), for:.touchUpInside);
        self.view.addSubview(scannerButton);
        
        let galleryButton = UIButton(type: .custom);
        galleryButton.frame = CGRect(x:padding, y:scannerButton.bottom + padding, width:scannerButton.width, height:scannerButton.height);
        galleryButton.backgroundColor = UIColor.lightGray;
        galleryButton.layer.cornerRadius = 4.0;
        galleryButton.setTitle("Open Picker", for: .normal);
        galleryButton .addTarget(self, action:#selector(self.galleryButtonTapped), for:.touchUpInside);
        self.view.addSubview(galleryButton);
        
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black);
    }

    func scannerViewController(_ scannerViewController: iQScannerViewController!, didSearchWithKeyword keyword: String!) {
        
    }
    
    func scannerViewController(_ scannerViewController: iQScannerViewController!, didLoad searchResponse: iQAPISearchResponse!) {
        scannerViewController.dismiss(animated: true, completion:{() -> Void in
            self.processSearchResponse(searchResponse: searchResponse);
        });
    }
    
    func processSearchResponse( searchResponse: iQAPISearchResponse )
    {
        if (searchResponse.payload != nil)
        {
            let webViewController = SVModalWebViewController(url:searchResponse.payload);
            
            //webViewController.initWithURL(searchResponse.payload);
            self.present(webViewController!, animated:true, completion:nil);
        }
        else
        {
            SVProgressHUD.showError(withStatus: "No result found.");
        }
    }
    
    @IBAction func scannerButtonTapped(sender: UIButton)
    {
        let scannerViewController = iQScannerViewController();
        scannerViewController.delegate = self as! iQScannerViewControllerDelegate;
        
        self.present(scannerViewController, animated:true, completion:nil);
    }
    
    @IBAction  func galleryButtonTapped(sender: UIButton)
    {
        let imagePickerController = UIImagePickerController();
        imagePickerController.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum;
        imagePickerController.mediaTypes = [kUTTypeImage as String];
        imagePickerController.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate;
        imagePickerController.allowsEditing = false;
        self.present(imagePickerController, animated:true, completion:nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController,
                                        didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            iQAPISearchRequest.init(image: originalImage).run(completionHandler: {( response ) in
                print( response! )
            })
        }
    }
    
    
}


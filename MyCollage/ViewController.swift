//
//  ViewController.swift
//  MyCollage
//
//  Created by Arslan Saleem on 01/04/2023.
//

import UIKit

class ViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var firstCollage : CollageView?
    var selectedImageView : UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollage()
        setHeadingLabel()
    }
    
    //Add heading label to view to guide user about usage
    func setHeadingLabel(){
    
        let headinglabel = UILabel(frame: CGRectMake(0, (firstCollage?.frame.origin.y ?? 100) - 80,300, 60))
        headinglabel.center = CGPoint(x: view.center.x, y: headinglabel.center.y)
        headinglabel.numberOfLines = 0
        headinglabel.text = "Please tap any image below to change it"
        view.addSubview(headinglabel)
    }
    
    //Add collage view and adding gesture recogiser to it
    func setUpCollage(){
                
        firstCollage = CollageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        
        if let collageView = firstCollage {
            
            collageView.center = view.center
            view.addSubview(collageView)
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            tapGestureRecognizer.numberOfTapsRequired = 1
            tapGestureRecognizer.numberOfTouchesRequired = 1

            collageView.addGestureRecognizer(tapGestureRecognizer);
            collageView.isUserInteractionEnabled = true

        }
    }

    //Handle tap in collage view
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        
        //Get location point of tap
        let tapLocation:CGPoint = gestureRecognizer.location(in: firstCollage)
        
        //Detect section in which user tapped
        if tapTestForPath(tapLocation: tapLocation, path: firstCollage?.path1){
            //User has tapped in section 1
            selectedImageView = firstCollage?.imageView1
        }else if tapTestForPath(tapLocation: tapLocation, path: firstCollage?.path2){
            //User has tapped in section 2
            selectedImageView = firstCollage?.imageView2
        }
        
        //Open gallery for user to choose images for collage
        openGallery()
    }
    
    func tapTestForPath(tapLocation:CGPoint, path:UIBezierPath?) -> Bool{
        
        if let shapePath = path {
            if shapePath.contains(tapLocation){
                //tap detected do what ever you want .
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
    
    func openGallery(){
            let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                present(imagePicker, animated: true, completion: nil)
    }
    
    // Delegate method called when user selects an image from gallery, assign chosen image to image view selected by user
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          let image = info[.originalImage] as! UIImage
          selectedImageView?.image = image
          dismiss(animated: true, completion: nil)
      }

}


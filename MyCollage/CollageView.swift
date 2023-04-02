//
//  CollageView.swift
//  MyCollage
//
//  Created by Arslan Saleem on 01/04/2023.
//

import UIKit

class CollageView: UIView {

    /**
        This is handle of first image view which can be used to assign images to  first section of collage
     */
    var imageView1  = UIImageView()

    /**
     This is handle of second image view which can be used to assign images to  second section of collage
     */
    var imageView2  = UIImageView()
    
    /**
        This is handle of path for first section of collage, it can be used to detect gestures within first section
     */
    let path1       = UIBezierPath()

    /**
        This is handle of path for second section of collage, it can be used to detect gestures within second section
     */
    let path2       = UIBezierPath()

    
    override func draw(_ rect: CGRect) {
            super.draw(rect)
            
            //Add sections of collage
            addFirstSectionForRect(rect)
            addSecondSectionForRect(rect)
    }
    
    /**
        This function will draw path for first section of collage.
     */
    func addFirstSectionForRect(_ rect: CGRect){
        
        //Define significant points
        let topOfDividerLine = (70.0/100) * rect.width
        let bottomOfDividerLine = (30.0/100) * rect.width

        
        //Draw path for first section
        path1.move(to: CGPoint(x: 0, y: 0))
        path1.addLine(to: CGPoint(x: topOfDividerLine, y: 0))
        path1.addLine(to: CGPoint(x: bottomOfDividerLine, y: rect.height))
        path1.addLine(to: CGPoint(x: 0, y: rect.height))
        path1.addLine(to: CGPoint(x: 0, y: 0))
        path1.close()
        
        //Add image view with path
        addImageViewToPath(imageView: imageView1, path: path1, imageName: "image1")

    }
    
    
    /**
        This function will draw path for second section of collage
     */

    func addSecondSectionForRect(_ rect: CGRect){
        
        //Define significant points
        let topOfDividerLine = (70.0/100) * rect.width
        let bottomOfDividerLine = (30.0/100) * rect.width

        //Draw path for first section
        path2.move(to: CGPoint(x: topOfDividerLine, y: 0))
        path2.addLine(to: CGPoint(x: rect.width, y: 0))
        path2.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path2.addLine(to: CGPoint(x: bottomOfDividerLine, y: rect.height))
        path2.addLine(to: CGPoint(x: topOfDividerLine, y: 0))
        path2.close()

        //Add image view with path
        addImageViewToPath(imageView: imageView2, path: path2, imageName: "image2")
    }

    
    /**
        This is utility function of class to add masks to image views and assign default images to them
     */
    func  addImageViewToPath(imageView: UIImageView, path: UIBezierPath, imageName:String){
                
        // Initialise image view with frame
        imageView.frame =  CGRect(x: 0, y: 0, width: 300, height: 300)
        
        //Create a shape layer with path
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
                        
        //Add mask to image view
        imageView.layer.mask = shapeLayer
        imageView.contentMode = .scaleAspectFill
  
        //Add Image view as subview
        self.addSubview(imageView)
        
        //Add defualt image to image view
        imageView.image = UIImage(named: imageName)
        
    }

}

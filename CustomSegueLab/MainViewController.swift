//
//  MainViewController.swift
//  CMJCustomSegueLab
//
//  Created by Claes Jacobsson on 2015-04-21.
//  Copyright (c) 2015 Claes Jacobsson. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    let animator = TransitionManager()    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let destinationViewController = segue.destinationViewController as! DetailViewController
        destinationViewController.image = imageView.image
        
         if (segue.identifier == "modal") {
            // The standard segues can also be customized programmatically
//            destinationViewController.transitioningDelegate = self.animator
//            destinationViewController.modalPresentationStyle = .Custom
        }
    }
    
    
    @IBAction func unwindToMainViewController (segue: UIStoryboardSegue) {
        
        var sourceVC = segue.sourceViewController as! UIViewController
        sourceVC.dismissViewControllerAnimated(true, completion: nil)        
    }

}


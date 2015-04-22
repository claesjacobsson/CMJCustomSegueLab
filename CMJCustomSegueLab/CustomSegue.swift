//
//  CustomSegue.swift
//  CMJCustomSegueLab
//
//  Created by Claes Jacobsson on 2015-04-21.
//  Copyright (c) 2015 Claes Jacobsson. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {

    override func perform() {
    
        let source = self.sourceViewController as! MainViewController
        let destination = self.destinationViewController as! DetailViewController
        
        destination.modalPresentationStyle = .Custom
        destination.transitioningDelegate = source.animator
        
        source.presentViewController(destination, animated: true, completion: nil)
    }
    
}
//
//  DetailViewController.swift
//  CMJCustomSegueLab
//
//  Created by Claes Jacobsson on 2015-04-21.
//  Copyright (c) 2015 Claes Jacobsson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var image: UIImage?
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = image {
            imageView.image = image
        }
    }
    
}


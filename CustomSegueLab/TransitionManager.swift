//
//  TransitionManager.swift
//  CustomSegueLab
//
//  Created by Claes Jacobsson on 2015-04-21.
//  Copyright (c) 2015 Claes Jacobsson. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private var presenting = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
      
        let container = transitionContext.containerView()
        
        var fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        var toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        // Check if VCs are NavigationControllers. If so, replace with its topViewController
        if let from = fromVC as? UINavigationController {
            fromVC = from.topViewController
        }
        if let to = toVC as? UINavigationController {
            toVC = to.topViewController
        }
 
        // Assign references to 'main' and 'detail' view controllers
        let mainViewController = self.presenting ? fromVC as! MainViewController : toVC as! MainViewController
        let detailViewController = self.presenting ? toVC as! DetailViewController : fromVC as! DetailViewController
        
        // We want to animate the watch image separately, so let's create a copy of it
        let animationImageView = UIImageView(frame: self.presenting ? mainViewController.imageView.frame : detailViewController.imageView.frame)
        animationImageView.image = self.presenting ? mainViewController.imageView.image : detailViewController.imageView.image
        animationImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        // Create snapshots of both views, but without the watch
        mainViewController.imageView.hidden = true
        detailViewController.imageView.hidden = true
        let snapshotFrom = fromVC!.view.resizableSnapshotViewFromRect(fromVC!.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
        let snapshotTo = toVC!.view.resizableSnapshotViewFromRect(toVC!.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
        mainViewController.imageView.hidden = false
        detailViewController.imageView.hidden = false
       
        // Add animation elements to containerView
        container.addSubview(snapshotTo)
        container.addSubview(snapshotFrom)
        container.addSubview(animationImageView)
        
        // Hide toVC view until its snapshot has been animated
        toVC!.view.alpha = 0.0
       
        if self.presenting {
            container.addSubview(toVC!.view)
        }
        
        let animationDuration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil,
            animations: { () -> Void in
                
                animationImageView.frame = self.presenting ? detailViewController.imageView.frame : mainViewController.imageView.frame
                snapshotFrom.alpha = 0.0
                snapshotTo.alpha = 1.0
            
            }, completion: { (finished) -> Void in
                
                toVC?.view.alpha = 1.0
                animationImageView.removeFromSuperview()
                snapshotFrom.removeFromSuperview()
                snapshotTo.removeFromSuperview()
                
                if !self.presenting {
                    fromVC?.view.removeFromSuperview()
                }
                
                transitionContext.completeTransition(finished)
        })
    }
 
    
    // MARK: UIViewControllerTransitioningDelegate
    
    // Animator used when presenting a viewcontroller
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    // Animator used when dismissing from a viewcontroller
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }

}
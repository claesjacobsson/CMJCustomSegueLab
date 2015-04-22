//
//  TransitionPresentationAnimator.swift
//  CustomSegueLab
//
//  Created by Claes Jacobsson on 2015-04-21.
//  Copyright (c) 2015 Claes Jacobsson. All rights reserved.
//

import UIKit

class TransitionPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.4
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! WhiteViewController
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! BlueViewController
        let containerView = transitionContext.containerView()

        let animationDuration = self .transitionDuration(transitionContext)
   
   
        // We want to animate the watch separately
        var animatedImageView = UIImageView(frame: fromViewController.imageView.frame);
        animatedImageView.contentMode = UIViewContentMode.ScaleAspectFit
        animatedImageView.image = fromViewController.imageView.image;
        
        
        // Create snapshots of fromVC and toVC, but without the watch
        fromViewController.imageView.hidden = true
        toViewController.imageView.hidden = true
        let snapshotFromView = fromViewController.view.resizableSnapshotViewFromRect(fromViewController.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
        let snapshotToView = toViewController.view.resizableSnapshotViewFromRect(toViewController.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
        fromViewController.imageView.hidden = false
        toViewController.imageView.hidden = false

        // Add our animation elements to containerView
        containerView.addSubview(snapshotToView)
        containerView.addSubview(snapshotFromView)
        containerView.addSubview(animatedImageView)

        
        // hide the real toVC view until the snapshot has been animated
        toViewController.view.alpha = 0.0
        containerView.addSubview(toViewController.view)
       
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil,
            animations: { () -> Void in
                animatedImageView.frame = toViewController.imageView.frame;
                snapshotFromView.alpha = 0.0
                snapshotToView.alpha = 1.0
            }, completion: { (finished) -> Void in
                toViewController.view.alpha = 1.0
                animatedImageView.removeFromSuperview()
                snapshotFromView.removeFromSuperview()
                snapshotToView.removeFromSuperview()
                transitionContext.completeTransition(finished)
        })
        
//        UIView.animateWithDuration(animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 20.0, options: nil,
//            animations: { () -> Void in
//                animatedImageView.frame = toViewController.imageView.frame;
//                snapshotView.alpha = 1.0
//            }, completion: { (finished) -> Void in
//                toViewController.view.alpha = 1.0
//                animatedImageView.removeFromSuperview()
//                snapshotView.removeFromSuperview()
//                transitionContext.completeTransition(finished)
//        })
        
        
        
//        
//        // take a snapshot of the detail ViewController so we can do whatever with it (cause it's only a view), and don't have to care about breaking constraints
//        let snapshotView = toViewController.view.resizableSnapshotViewFromRect(toViewController.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
//        snapshotView.transform = CGAffineTransformMakeScale(0.1, 0.1)
//        snapshotView.center = fromViewController.view.center
//        containerView.addSubview(snapshotView)
//
//        // hide the detail view until the snapshot is being animated
//        toViewController.view.alpha = 0.0
//        containerView.addSubview(toViewController.view)
//
//        UIView.animateWithDuration(animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 20.0, options: nil,
//            animations: { () -> Void in
//                snapshotView.transform = CGAffineTransformIdentity
//            }, completion: { (finished) -> Void in
//                snapshotView.removeFromSuperview()
//                toViewController.view.alpha = 1.0
//                transitionContext.completeTransition(finished)
//        })
    }

    
//    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
//        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
//        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
//        let containerView = transitionContext.containerView()
//        
//        let animationDuration = self .transitionDuration(transitionContext)
//        
//        // take a snapshot of the detail ViewController so we can do whatever with it (cause it's only a view), and don't have to care about breaking constraints
//        let snapshotView = toViewController.view.resizableSnapshotViewFromRect(toViewController.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
//        snapshotView.transform = CGAffineTransformMakeScale(0.1, 0.1)
//        snapshotView.center = fromViewController.view.center
//        containerView.addSubview(snapshotView)
//        
//        // hide the detail view until the snapshot is being animated
//        toViewController.view.alpha = 0.0
//        containerView.addSubview(toViewController.view)
//        
//        UIView.animateWithDuration(animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 20.0, options: nil,
//            animations: { () -> Void in
//                snapshotView.transform = CGAffineTransformIdentity
//            }, completion: { (finished) -> Void in
//                snapshotView.removeFromSuperview()
//                toViewController.view.alpha = 1.0
//                transitionContext.completeTransition(finished)
//        })
//    }

}

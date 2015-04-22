//
//  Animator.swift
//  CustomSegueLab
//
//  Created by Claes Jacobsson on 2015-04-21.
//  Copyright (c) 2015 Claes Jacobsson. All rights reserved.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
//    var transitioningContext : UIViewControllerContextTransitioning
////    var duration : NSTimeInterval = 0.0
//    
//    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
//        return 0.3
//    }
//    
//    
//    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
//        
//        self.transitioningContext = transitioningContext
//        
//        let containerView = transitioningContext.containerView()
//        fromVC = transitioningContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
//        toVC = transitioningContext.viewControllerForKey(UITransitionContextToViewControllerKey)
//        
//    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // return the duration of the animation, usually 0.3 or 0.5, but depends on your animation
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let fromView: UIView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let toView: UIView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let containerView = transitionContext.containerView()
        
        transitionContext.containerView().addSubview(fromView)
        transitionContext.containerView().addSubview(toView)
        
        let animationDuration = self .transitionDuration(transitionContext)
        
        let fromViewControllerIndex = find(fromViewController.navigationController!.viewControllers! as! [UIViewController], fromViewController)
        let toViewControllerIndex = find(toViewController.navigationController!.viewControllers!as! [UIViewController], toViewController)
        
        // 1 will slide left, -1 will slide right
        var directionInteger: CGFloat!
        if fromViewControllerIndex < toViewControllerIndex {
            directionInteger = 1
            println("Push")
        } else {
            directionInteger = -1
            println("Back")
        }
        
        //The "to" view with start "off screen" and slide left pushing the "from" view "off screen"
        toView.frame = CGRectMake(directionInteger * toView.frame.width, 0, toView.frame.width, toView.frame.height)
        let fromNewFrame = CGRectMake(-1 * directionInteger * fromView.frame.width, 0, fromView.frame.width, fromView.frame.height)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            toView.frame = fromView.frame
            fromView.frame = fromNewFrame
            }) { (Bool) -> Void in
                // update internal view - must always be called
                transitionContext.completeTransition(true)
        }
    }
}

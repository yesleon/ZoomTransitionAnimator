//
//  ParentViewController.swift
//  ZoomTransitionAnimator
//
//  Created by yesleon on 12/12/2017.
//  Copyright (c) 2017 yesleon. All rights reserved.
//

import UIKit
import ZoomTransitionAnimator

class ParentViewController: UIViewController {

    @IBOutlet weak var imageButton: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        segue.destination.transitioningDelegate = self
    }
    
}

extension ParentViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let destination = presented as? ZoomTransitionDestination {
            return ZoomTransitionAnimator(source: self, destination: destination, operation: .zoomIn)
        } else {
            return nil
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let source = dismissed as? ZoomTransitionSource {
            return ZoomTransitionAnimator(source: source, destination: self, operation: .zoomOut)
        } else {
            return nil
        }
    }
    
}

extension ParentViewController: ZoomTransitionSource, ZoomTransitionDestination {
    
    func zoomTransitionAnimator(_ animator: ZoomTransitionAnimator, targetViewBeginningFrameFor operation: ZoomTransitionOperation) -> CGRect {
        return imageButton.frame
    }
    func zoomTransitionAnimator(_ animator: ZoomTransitionAnimator, targetViewFinalFrameFor operation: ZoomTransitionOperation) -> CGRect {
        return imageButton.frame
    }
    
}

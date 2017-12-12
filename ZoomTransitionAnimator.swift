//
//  ZoomTransitionAnimator.swift
//  ScrapBeta
//
//  Created by Li-Heng Hsu on 06/12/2017.
//  Copyright © 2017 Li-Heng Hsu. All rights reserved.
//

import UIKit

public class ZoomTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration: TimeInterval
    let damping: CGFloat
    
    let operation: ZoomTransitionOperation
    let source: ZoomTransitionSource
    let destination: ZoomTransitionDestination
    
    public init(duration: TimeInterval = 0.4, damping: CGFloat = 0.8, source: ZoomTransitionSource, destination: ZoomTransitionDestination, operation: ZoomTransitionOperation) {
        self.duration = duration
        self.damping = damping
        self.source = source
        self.destination = destination
        self.operation = operation
        super.init()
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        // Preparing
        
        guard let fromView = transitionContext.view(forKey: .from) else { fatalError() }
        guard let toView = transitionContext.view(forKey: .to) else { fatalError() }
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toView)
        toView.layoutIfNeeded()
        
        let targetViewBeginningFrame = source.zoomTransitionAnimator(self, targetViewBeginningFrameFor: operation)
        let targetViewFinalFrame = destination.zoomTransitionAnimator(self, targetViewFinalFrameFor: operation)
        
        
         // Adding views to view hierarchy
        
        let backgroundView = UIView(frame: containerView.bounds)
        containerView.addSubview(backgroundView)
        
        guard let fromViewSnapshotView = fromView.snapshotView(afterScreenUpdates: false) else { fatalError() }
        containerView.addSubview(fromViewSnapshotView)
        
        let targetViewSnapshotView: UIView = {
            UIGraphicsBeginImageContextWithOptions(targetViewBeginningFrame.size, false, 0)
            let newFrame = CGRect(x: -targetViewBeginningFrame.origin.x, y: -targetViewBeginningFrame.origin.y, width: containerView.frame.width, height: containerView.frame.height)
            containerView.drawHierarchy(in: newFrame, afterScreenUpdates: false)
            guard let targetViewSnapshotImage = UIGraphicsGetImageFromCurrentImageContext() else { fatalError() }
            UIGraphicsEndImageContext()
            return UIImageView(image: targetViewSnapshotImage)
        }()
        containerView.addSubview(targetViewSnapshotView)
        
        guard let toViewSnapshotView = toView.snapshotView(afterScreenUpdates: true) else { fatalError() }
        containerView.addSubview(toViewSnapshotView)
        
        
        // Calculating frames
        
        let zoomInRatio = targetViewFinalFrame.width / targetViewBeginningFrame.width
        
        let toViewFirstFrame: CGRect = {
            let firstX = targetViewBeginningFrame.origin.x - (targetViewFinalFrame.origin.x / zoomInRatio)
            let firstY = targetViewBeginningFrame.origin.y - (targetViewFinalFrame.origin.y / zoomInRatio)
            let width = toView.frame.width / zoomInRatio
            let height = toView.frame.height / zoomInRatio
            return CGRect(x: firstX, y: firstY, width: width, height: height)
        }()
        
        let fromViewFinalFrame: CGRect = {
            let finalX = (fromView.frame.origin.x - targetViewBeginningFrame.origin.x) * zoomInRatio + targetViewFinalFrame.origin.x
            let finalY = (fromView.frame.origin.y - targetViewBeginningFrame.origin.y) * zoomInRatio + targetViewFinalFrame.origin.y
            let width = fromView.frame.width * zoomInRatio
            let height = fromView.frame.height * zoomInRatio
            return CGRect(x: finalX, y: finalY, width: width, height: height)
        }()
        
        
        // Setting up beginning states
        
        targetViewSnapshotView.frame = targetViewBeginningFrame
        toViewSnapshotView.frame = toViewFirstFrame
        toViewSnapshotView.alpha = 0
        switch operation {
        case .zoomIn:
            backgroundView.backgroundColor = toView.backgroundColor
        case .zoomOut:
            backgroundView.backgroundColor = fromView.backgroundColor
        }
        
        
        // Animating
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: 0, options: .curveLinear, animations: {
            
            targetViewSnapshotView.frame = targetViewFinalFrame
            fromViewSnapshotView.frame = fromViewFinalFrame
            fromViewSnapshotView.alpha = 0
            toViewSnapshotView.frame = toView.frame
            toViewSnapshotView.alpha = 1
            
        }, completion: { _ in
            
            // Cleaning up
            
            targetViewSnapshotView.removeFromSuperview()
            fromViewSnapshotView.removeFromSuperview()
            toViewSnapshotView.removeFromSuperview()
            backgroundView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
}


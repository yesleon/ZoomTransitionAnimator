//
//  ChildViewController.swift
//  ZoomTransitionAnimator_Example
//
//  Created by Li-Heng Hsu on 12/12/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import ZoomTransitionAnimator

class ChildViewController: UIViewController {
    
    struct InteractiveTransitionContext {
        let startingFrame: CGRect
    }
    
    var interactiveTransitionContext: InteractiveTransitionContext?

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func didPressBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPanImageView(_ sender: UIPanGestureRecognizer) {
        guard let view = self.view else { return }
        let translation = sender.translation(in: view)
        switch sender.state {
        case .began:
            interactiveTransitionContext = InteractiveTransitionContext(startingFrame: view.frame)
        case .changed:
            guard let context = self.interactiveTransitionContext else { return }
            view.frame.origin = CGPoint(x: context.startingFrame.origin.x + translation.x, y: context.startingFrame.origin.y + translation.y)
        case .ended:
            dismiss(animated: true, completion: nil)
            self.interactiveTransitionContext = nil
        default:
            break
        }
    }
    
}

extension ChildViewController: ZoomTransitionDestination {
    
    private var imageViewFrame: CGRect {
        return view.convert(imageView.frame, to: UIScreen.main.coordinateSpace)
    }
    
    func zoomTransitionAnimator(_ animator: ZoomTransitionAnimator, targetViewFinalFrameFor operation: ZoomTransitionOperation) -> CGRect {
        return imageViewFrame
    }
    
}

extension ChildViewController: ZoomTransitionSource {
    
    func zoomTransitionAnimator(_ animator: ZoomTransitionAnimator, targetViewBeginningFrameFor operation: ZoomTransitionOperation) -> CGRect {
        return imageViewFrame
    }
    
}

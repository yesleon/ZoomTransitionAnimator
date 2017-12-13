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

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func didPressBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ChildViewController: ZoomTransitionParticipant {
    
    func zoomTransitionAnimator(_ animator: ZoomTransitionAnimator, targetViewFinalFrameFor operation: ZoomTransitionOperation) -> CGRect {
        return imageView.frame
    }
    
}

extension ChildViewController: ZoomTransitionSource {
    
    func zoomTransitionAnimator(_ animator: ZoomTransitionAnimator, targetViewBeginningFrameFor operation: ZoomTransitionOperation) -> CGRect {
        return imageView.frame
    }
    
}

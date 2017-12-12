//
//  ZoomTransitionProtocols.swift
//  ZoomTransitionAnimator
//
//  Created by Li-Heng Hsu on 12/12/2017.
//  Copyright © 2017 narrativesaw. All rights reserved.
//

import CoreGraphics

public enum ZoomTransitionOperation: Int {
    case zoomIn = 1, zoomOut = 2
}

public protocol ZoomTransitionSource {
    
    func zoomTransitionAnimator(_ animator: ZoomTransitionAnimator, targetViewBeginningFrameFor operation: ZoomTransitionOperation) -> CGRect
    
}

public protocol ZoomTransitionDestination {
    
    func zoomTransitionAnimator(_ animator: ZoomTransitionAnimator, targetViewFinalFrameFor operation: ZoomTransitionOperation) -> CGRect
}

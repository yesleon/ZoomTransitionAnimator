//
//  GrandchildViewController.swift
//  ZoomTransitionAnimator_Example
//
//  Created by Li-Heng Hsu on 13/12/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import ZoomTransitionAnimator

class GrandchildViewController: UIViewController {

    @IBOutlet weak var zoomOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func didTapZoomOutButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension GrandchildViewController: ZoomTransitionDestination {
    
    func zoomTransitionAnimator(_ animator: ZoomTransitionAnimator, targetViewFinalFrameFor operation: ZoomTransitionOperation) -> CGRect {
        return zoomOutButton.frame
    }
    
}

extension GrandchildViewController: ZoomTransitionSource {
    
    func zoomTransitionAnimator(_ animator: ZoomTransitionAnimator, targetViewBeginningFrameFor operation: ZoomTransitionOperation) -> CGRect {
        return zoomOutButton.frame
    }
    
}

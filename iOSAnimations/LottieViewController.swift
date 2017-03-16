//
//  LottieViewController.swift
//  iOSAnimations
//
//  Created by Varun Ballari on 3/9/17.
//  Copyright © 2017 Varun Ballari. All rights reserved.
//

import UIKit
import Lottie


class LottieViewController: UIViewController {

    let lottieView = LOTAnimationView.animationNamed("animation")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lottieView?.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.height)
        lottieView?.contentMode = .scaleAspectFit
        
        lottieView?.loopAnimation = true
        
        self.view.addSubview(lottieView!)
        
        lottieView?.play()
    
//        let gr = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(recognizer:)))
//        self.view.addGestureRecognizer(gr)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handlePan (recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)        
        lottieView?.animationProgress = translation.x / self.view.bounds.size.width
    }
}

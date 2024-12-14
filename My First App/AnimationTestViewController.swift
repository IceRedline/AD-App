//
//  AnimationTestViewController.swift
//  My First App
//
//  Created by Артем Табенский on 09.12.2024.
//

import UIKit


class AnimationTestViewController: UIViewController {
    
    let animationsEngine = Animations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func testButtonTouchedDown(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            animationsEngine.animateDownSpring(sender)
        case 2:
            animationsEngine.animateDownFloat(sender)
        case 3:
            animationsEngine.animateDownRadius(sender)
        default: return
        }
    }
    
    @IBAction func testButtonReleased(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            animationsEngine.animateUpSpring(sender)
        case 2:
            animationsEngine.animateUpFloat(sender)
        case 4:
            animationsEngine.animateUpTintColor(sender)
        case 5:
            animationsEngine.animateUpBackgroundColor(sender)
        default: return
        }
    }
    
}

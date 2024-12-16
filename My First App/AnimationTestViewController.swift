//
//  AnimationTestViewController.swift
//  My First App
//
//  Created by Артем Табенский on 09.12.2024.
//

import UIKit


class AnimationTestViewController: UIViewController {
    
    let defaultColor: CGColor = UIColor.secondary.cgColor
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
            switch sender.tintColor {
            case .primary:
                animationsEngine.animateTintColor(sender)
            default:
                animationsEngine.animateTintColor(sender, color: .primary)
            }
        case 5:
            switch sender.layer.backgroundColor {
            case defaultColor:
                animationsEngine.animateBackgroundColor(sender, color: CGColor(red: 199/255, green: 198/255, blue: 240/255, alpha: 1))
            default:
                animationsEngine.animateBackgroundColor(sender, color: defaultColor)
            }
            
        default: return
        }
    }
    
}

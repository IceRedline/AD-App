//
//  AnimationTestViewController.swift
//  My First App
//
//  Created by Артем Табенский on 09.12.2024.
//

import UIKit


class AnimationTestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func animateDownSpring(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })
    }
    
    private func animateUpSpring(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    private func animateDownFloat(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.2, options: .curveLinear, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })
    }
    
    private func animateUpFloat(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    private func animateDownRadius(_ viewToAnimate: UIView) {
        if viewToAnimate.layer.cornerRadius == 0 {
            UIView.animate(withDuration: 1) {
                viewToAnimate.layer.cornerRadius = 15
            }
        } else {
            UIView.animate(withDuration: 1) {
                viewToAnimate.layer.cornerRadius = 0
            }
        }
    }
    
    private func animateUpColor(_ viewToAnimate: UIView) {
        if viewToAnimate.tintColor == UIColor.systemBlue {
            UIView.transition(with: viewToAnimate, duration: 1, options: .transitionCrossDissolve, animations: {
                viewToAnimate.tintColor = UIColor.systemGray
            })
        } else {
            UIView.transition(with: viewToAnimate, duration: 1, options: .transitionCrossDissolve, animations: {
                viewToAnimate.tintColor = UIColor.systemBlue
            })
        }
    }
    
    @IBAction func testButtonTouchedDown(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            animateDownSpring(sender)
        case 2:
            animateDownFloat(sender)
        case 3:
            animateDownRadius(sender)
        default: return
        }
    }
    
    @IBAction func testButtonReleased(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            animateUpSpring(sender)
        case 2:
            animateUpFloat(sender)
        case 4:
            animateUpColor(sender)
        default: return
        }
    }
    
}

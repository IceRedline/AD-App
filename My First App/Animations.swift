//
//  Animations.swift
//  My First App
//
//  Created by Артем Табенский on 14.12.2024.
//

import UIKit

class Animations {
    
    func animateDownSpring(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })
    }
    
    func animateUpSpring(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    func animateDownFloat(_ viewToAnimate: UIView, duration: Double = 0.2) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.2, options: .curveLinear, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })
    }
    
    func animateUpFloat(_ viewToAnimate: UIView, duration: Double = 0.15) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    func animateDownRadius(_ viewToAnimate: UIView) {
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
    
    func animateUpTintColor(_ viewToAnimate: UIView) {
        if viewToAnimate.tintColor == UIColor.white {
            UIView.transition(with: viewToAnimate, duration: 1, options: .transitionCrossDissolve, animations: {
                viewToAnimate.tintColor = UIColor.black
            })
        } else {
            UIView.transition(with: viewToAnimate, duration: 1, options: .transitionCrossDissolve, animations: {
                viewToAnimate.tintColor = UIColor.white
            })
        }
    }
    
    func animateUpBackgroundColor(_ viewToAnimate: UIView) {
        if viewToAnimate.layer.backgroundColor != CGColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1) {
            UIView.transition(with: viewToAnimate, duration: 0.2, options: .transitionCrossDissolve, animations: {
                viewToAnimate.layer.backgroundColor = CGColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            })
        } else {
            UIView.transition(with: viewToAnimate, duration: 0.2, options: .transitionCrossDissolve, animations: {
                viewToAnimate.layer.backgroundColor = CGColor(red: 199/255, green: 198/255, blue: 205/255, alpha: 1)
            })
        }
    }
}

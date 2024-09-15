//
//  FourthViewController.swift
//  My First App
//
//  Created by Артем Табенский on 08.03.2024.
//

import UIKit

class FourthViewController: UIViewController {

    @IBOutlet weak var colorSegment: UISegmentedControl!
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var alphaLabel: UILabel!
    @IBOutlet weak var blurSlider: UISlider!
    @IBOutlet weak var blurLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var blurEffectView: UIVisualEffectView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = imageView.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let blurValue = CGFloat(blurSlider.value)
            blurEffectView?.alpha = blurValue // Контролируем степень размытия через альфу
            imageView.addSubview(blurEffectView!)
    }

    @IBAction func alphaSliderChanged(_ sender: UISlider) {
        imageView.alpha = CGFloat(alphaSlider.value)
        alphaLabel.text = "\(round(alphaSlider.value * 10) / 10)"
        colorSegment.isEnabled = alphaSlider.value == 1
    }

    @IBAction func blurSliderChanged(_ sender: UISlider) {
        blurLabel.text = "\(Int(blurSlider.value * 10000) / 100)%"
        let blurValue = CGFloat(blurSlider.value)
        
        // Если уже есть существующий blurEffectView, уберите его
        blurEffectView?.removeFromSuperview()
        
        // Создайте и добавьте новый blurEffectView с учетом текущего значения ползунка
        let blurEffect = UIBlurEffect(style: .light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = imageView.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Примените размытие только если ползунок установлен на ненулевое значение
        if blurValue > 0 {
            blurEffectView?.alpha = blurValue // Контролируем степень размытия через альфу
            imageView.addSubview(blurEffectView!)
        }
    }

    @IBAction func colorSegmentChanged(_ sender: UISegmentedControl) {
        switch colorSegment.selectedSegmentIndex {
        case 0:
            view.backgroundColor = UIColor.systemGray6
        case 1:
            view.backgroundColor = UIColor.systemGray3
        case 2:
            view.backgroundColor = UIColor.systemGray
        default:
            view.backgroundColor = UIColor.systemGray6
        }
    }
}

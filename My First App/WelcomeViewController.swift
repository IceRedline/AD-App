//
//  ViewController.swift
//  My First App
//
//  Created by Артем Табенский on 03.03.2024.
//

import UIKit
import AVKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var logo1: UIImageView!
    @IBOutlet weak var logo2: UIImageView!
    @IBOutlet weak var welcomeButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var musicButton: UIButton!
    
    var musicplayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        UserDefaults.standard.set(true, forKey: "viewDidLoad")
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "ambient", withExtension: "mp3")
        musicplayer = try! AVAudioPlayer(contentsOf: url!)
        // player.numberOfLoops = -1
    }
    
    @IBAction func welcomeButtonTapped() {
        welcomeLabel.text = "Welcome"
        welcomeButton.isEnabled = false
        musicplayer.play()
        musicButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        musicButton.isEnabled = true
        logo1.isHidden = true
        logo2.isHidden = false
    }
    
    @IBAction func musicButtonTapped() {
        if musicplayer.isPlaying {
            musicplayer.stop()
            musicButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            logo1.isHidden = false
            logo2.isHidden = true
        } else {
            musicplayer.play()
            musicButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            logo1.isHidden = true
            logo2.isHidden = false
        }
    }
    
    
    @IBAction func quizBuutonTapped() {
        if musicplayer.isPlaying {
            musicplayer.stop()
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QuizID")
        self.present(vc, animated: true)
    }
    
    
    
    private func animateDown(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })
    }
    
    private func animateUp(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    @IBAction func animationsButtonTapped(_ sender: UIButton) {
        animateDown(sender)
    }
    
    @IBAction func animationsButtonReleased(_ sender: UIButton) {
        animateUp(sender)
    }
    
    @IBAction func galleryButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RandomGallery")
        self.present(vc, animated: true)
    }
    
}

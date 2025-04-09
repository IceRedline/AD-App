//
//  NinthViewController.swift
//  My First App
//
//  Created by Артем Табенский on 14.03.2024.
//

import UIKit
import AVKit

class MusicPlayerViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet private weak var musicCollectionView: UICollectionView!
    
    private var albums: [Album]?
    private let musicLoader = MusicLoader()
    private var player: AVAudioPlayer?
    private var currentlyPlayingCell: MusicCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicCollectionView.dataSource = self
        musicCollectionView.delegate = self
        
        musicLoader.loadMusic(arrayToFill: &albums)
        //FirstViewController.musicplayer.stop()
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? UIImageView,
           let cell = imageView.superview?.superview as? MusicCell,
           let indexPath = musicCollectionView.indexPath(for: cell) {
            let album = albums?[indexPath.row]
            if let songURL = album?.song {
                if let player = player, player.isPlaying {
                    player.stop()
                    currentlyPlayingCell?.nowplayingIcon.isHidden = true
                    if currentlyPlayingCell == cell {
                        self.player = nil
                        self.currentlyPlayingCell = nil
                        return
                    }
                }
                do {
                    player = try AVAudioPlayer(contentsOf: songURL)
                    player?.play()
                    cell.nowplayingIcon.isHidden = false
                    currentlyPlayingCell = cell
                } catch {
                    print("Error playing song: \(error)")
                }
                print("Song started!")
            }
        }
    }
}

// MARK: - Extensions

extension MusicPlayerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicCell", for: indexPath) as! MusicCell
        cell.albumPreview.image = albums?[indexPath.row].image
        cell.albumPreview.contentMode = .scaleAspectFit

        // Add shadow to nowplayingIcon
        cell.nowplayingIcon.layer.masksToBounds = false
        cell.nowplayingIcon.layer.shadowColor = UIColor.black.cgColor
        cell.nowplayingIcon.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.nowplayingIcon.layer.shadowOpacity = 100
        cell.nowplayingIcon.layer.shadowRadius = 10

        // Enable user interaction and add gesture recognizer
        cell.albumPreview.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        cell.albumPreview.addGestureRecognizer(tapGestureRecognizer)
        
        return cell
    }
    
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        player?.stop()
        currentlyPlayingCell?.nowplayingIcon.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vcp = storyboard.instantiateViewController(withIdentifier: StoryboardIDs.pagesVC) as! PageViewController
        self.navigationController?.pushViewController(vcp, animated: true)
    }
}

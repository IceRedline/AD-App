//
//  WebViewController.swift
//  My First App
//
//  Created by Артем Табенский on 29.01.2025.
//

import UIKit
import SafariServices

class BrowserViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func makeURL() -> URL {
        guard let text = textField.text, !text.isEmpty else {
            print("TextField пуст, используем URL по умолчанию")
            return URL(string: "https://www.apple.com")!
        }

        let stringURL = "https://www." + text
        if let url = URL(string: stringURL) {
            return url
        } else {
            print("Не удалось создать URL, используем URL по умолчанию")
            return URL(string: "https://www.apple.com")!
        }
    }
    
    @IBAction func loadButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let websiteVC = storyboard.instantiateViewController(withIdentifier: StoryboardIDs.wkwebview) as! WKWebViewViewController
        websiteVC.url = makeURL()
        
        navigationController?.pushViewController(websiteVC, animated: true)
    }
    
    @IBAction func sfButtonTapped() {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        let safariVC = SFSafariViewController(url: makeURL(), configuration: config)
        present(safariVC, animated: true)
    }
    @IBAction func safariButtonTapped() {
        UIApplication.shared.open(makeURL())
    }
}

// http://google.com/search?q=usd&ie=UTF-8&oe=UTF-8&hl=ru-ru&client=safari

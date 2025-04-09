//
//  WebsiteViewController.swift
//  My First App
//
//  Created by Артем Табенский on 29.01.2025.
//

import UIKit
import WebKit

class WKWebViewViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingProgressBar: UIProgressView!
    
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchURLRequest()
    }
    
    // MARK: - ProgressBar Methods
    
    override func viewWillAppear(_ animated: Bool) {
        webView.addObserver(
            self,
            forKeyPath: #keyPath(WKWebView.estimatedProgress),
            options: .new,
            context: nil
        )
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            updateProgress()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    private func updateProgress() {
        loadingProgressBar.progress = Float(webView.estimatedProgress)
        loadingProgressBar.isHidden = fabs(webView.estimatedProgress - 1) <= 0.0001
    }
    
    // MARK: - URL Methods
    
    private func fetchURLRequest() {
        let request = URLRequest(url: url ?? URL(string:"https://www.apple.com")!)
        webView.load(request)
    }
}

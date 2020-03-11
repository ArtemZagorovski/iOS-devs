//
//  ViewController.swift
//  WebKit-UIKit
//
//  Created by Артем  on 2/13/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var textView: UITextField!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        webView.navigationDelegate = self
        
        let homePage = "https://www.apple.com"
        let url = URL(string: homePage)
        let request = URLRequest(url: url!)
        
        textView.text = homePage
        
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func forwardButtonAction(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
}

extension ViewController: UITextFieldDelegate, WKNavigationDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString = textField.text!
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        textField.resignFirstResponder()
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        textView.text = webView.url?.absoluteString
        
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}



//
//  ViewController.swift
//  selectsearch
//
//  Created by Daniel Pape on 15/07/2017.
//  Copyright © 2017 Daniel Pape. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var setSearchProviderButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    let defaults = UserDefaults(suiteName: "group.com.danielpape.selectsearch")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialSearchProvider = self.defaults?.value(forKey: "searchProvider") as? String
        
        if(initialSearchProvider == "google"){
            self.setSearchProviderButton.image = #imageLiteral(resourceName: "GoogleLogo_30.png")
        }else if(initialSearchProvider == "bing"){
            self.setSearchProviderButton.image = #imageLiteral(resourceName: "BingLogo_30.png")
        }else if(initialSearchProvider == "yahoo"){
            self.setSearchProviderButton.image = #imageLiteral(resourceName: "YahooLogo_30.png")
        }else if(initialSearchProvider == "duckduckgo"){
            self.setSearchProviderButton.image = #imageLiteral(resourceName: "DuckDuckGoLogo_30.png")
        }
        
        print(defaults?.object(forKey: "testKey") ?? "testDefault")
        defaults?.dictionary(forKey: "searchHistory")
    }
    
    @IBAction func tapSelectSearchProvider(_ sender: Any) {
        let alertController = UIAlertController(title: "Set search provider", message: "Which service would you like to use for text and image searches?", preferredStyle: .actionSheet)
        
        let googleButton = UIAlertAction(title: "Google", style: .default, handler: { (action) -> Void in
            print("Google button tapped")
            self.setSearchProviderButton.image = #imageLiteral(resourceName: "GoogleLogo_30.png")
            self.defaults?.set("google", forKey: "searchProvider")
            self.defaults?.synchronize()
        })
        
        let bingButton = UIAlertAction(title: "Bing", style: .default, handler: { (action) -> Void in
            print("Bing button tapped")
            self.setSearchProviderButton.image = #imageLiteral(resourceName: "BingLogo_30.png")
            self.defaults?.set("bing", forKey: "searchProvider")
            self.defaults?.synchronize()
        })
        
        let yahooButton = UIAlertAction(title: "Yahoo", style: .default, handler: { (action) -> Void in
            print("Yahoo button tapped")
            self.setSearchProviderButton.image = #imageLiteral(resourceName: "YahooLogo_30.png")
            self.defaults?.set("yahoo", forKey: "searchProvider")
            self.defaults?.synchronize()
        })
        
        let ddgButton = UIAlertAction(title: "Duck Duck Go", style: .default, handler: { (action) -> Void in
            print("DDG button tapped")
            self.setSearchProviderButton.image = #imageLiteral(resourceName: "DuckDuckGoLogo_30.png")
            self.defaults?.set("duckduckgo", forKey: "searchProvider")
            self.defaults?.synchronize()
        })
        
        let cancelButton = UIAlertAction(title: "Back", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        
        alertController.addAction(googleButton)
        alertController.addAction(bingButton)
        alertController.addAction(yahooButton)
        alertController.addAction(ddgButton)
        alertController.addAction(cancelButton)
        
        alertController.popoverPresentationController?.sourceView = self.toolbar
        alertController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down        
        
        self.present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


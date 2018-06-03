//
//  ActionViewController.swift
//  selectsearchextension
//
//  Created by Daniel Pape on 15/07/2017.
//  Copyright © 2017 Daniel Pape. All rights reserved.
//

import UIKit
import MobileCoreServices
import SafariServices

class ActionViewController: UIViewController, SFSafariViewControllerDelegate {

    var convertedString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredContentSize = CGSize(width: 540, height: 620)
                
        let defaults = UserDefaults(suiteName: "group.com.danielpape.selectsearch")
        let searchProvider = String(describing: defaults?.object(forKey: "searchProvider"))
        
        var searchProviderString = ""
        
        switch searchProvider {
        case "Optional(google)":
            searchProviderString = "https://www.google.co.uk/#q="
        case "Optional(bing)":
            searchProviderString = "https://www.bing.com/search?q="
        case "Optional(yahoo)":
            searchProviderString = "https://search.yahoo.com/search?p="
        case "Optional(duckduckgo)":
            searchProviderString = "https://duckduckgo.com/?q="
        default:
            searchProviderString = "https://www.google.co.uk/#q="
        }
    
        let textItem = self.extensionContext!.inputItems[0]
            as! NSExtensionItem
    
        let textItemProvider = textItem.attachments![0]
            as! NSItemProvider
        
        if textItemProvider.hasItemConformingToTypeIdentifier(
            kUTTypeText as String) {
            textItemProvider.loadItem(forTypeIdentifier:
                kUTTypeText as String,
                                      options: nil,
                                      completionHandler: { (result, error) in
                                        
                                        self.convertedString = result as? String
                                        
                                        if self.convertedString != nil {
                                            self.convertedString = self.convertedString!.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
                                            
                                        

                                            DispatchQueue.main.async {
                                                let svc = SFSafariViewController(url: URL(string:searchProviderString+self.convertedString!)!)
                                                svc.delegate = self
                                                svc.modalPresentationCapturesStatusBarAppearance = true
                                                svc.preferredContentSize = super.view.bounds.size;
                                                self.present(svc, animated: true, completion: nil)
                                                }
                                            
                                            let defaults = UserDefaults(suiteName: "group.com.danielpape.selectsearch")
                                            defaults?.set("test", forKey: "testKey")
                                            defaults?.synchronize()
                                        }
            })
        }
        
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        done()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        let returnProvider =
            NSItemProvider(item: convertedString as NSSecureCoding?,
                           typeIdentifier: kUTTypeText as String)
        
        let returnItem = NSExtensionItem()
        
        returnItem.attachments = [returnProvider]
        self.extensionContext!.completeRequest(
            returningItems: [returnItem], completionHandler: nil)
    }
}

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
                                                let svc = SFSafariViewController(url: URL(string:"https://stackoverflow.com/search?q="+self.convertedString!)!)
                                                svc.delegate = self
                                                svc.modalPresentationCapturesStatusBarAppearance = true
                                                self.present(svc, animated: true, completion: nil)
                                            }
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

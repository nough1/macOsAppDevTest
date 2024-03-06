//
//  ViewController.swift
//  timeguardianMac1
//
//  Created by guoan hu on 3/6/24.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onClick(_ sender: Any) {
        
        guard let chromeBundleIdentifier = NSWorkspace.shared.urlForApplication(withBundleIdentifier: "com.google.Chrome") else {
                   print("Chrome is not installed.")
                   return
               }
               
               let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
               let accessibilityEnabled = AXIsProcessTrustedWithOptions(options)
               
               if accessibilityEnabled {
                   print("Accessibility permission is already granted.")
               } else {
                   let alert = NSAlert()
                   alert.messageText = "Permission Required"
                   alert.informativeText = "This app needs permission to control Google Chrome. Please grant the permission in the System Preferences."
                   alert.alertStyle = .warning
                   alert.addButton(withTitle: "Open System Preferences")
                   alert.addButton(withTitle: "Cancel")
                   
                   let response = alert.runModal()
                   
                   if response == .alertFirstButtonReturn {
                       NSWorkspace.shared.open(chromeBundleIdentifier)
                   }
               }
        
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


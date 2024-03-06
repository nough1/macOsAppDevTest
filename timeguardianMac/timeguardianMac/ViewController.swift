import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var button: NSPopUpButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    @IBAction func requestChromePermission(_ sender: Any) {
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
}

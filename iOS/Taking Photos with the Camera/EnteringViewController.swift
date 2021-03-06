import UIKit
import Alamofire

var urlString : String = String()

class EnteringViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!

    @IBAction func viewSnapButtonClicked(sender: AnyObject) {
        print("clicked")
        // if returns image, segue
        // if not, alert modal
        
        let parameters = [
            "username": usernameField.text!,
            "client": "mobile"
        ]
        
        Alamofire.request(.POST, "http://159.203.98.104:3000/get", parameters: parameters)
            .responseJSON{
                response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    if JSON["error"] as! String? == "No snaps found." {
                        var alert = UIAlertController(title: "Alert", message: "Unfortunately, this user has no snaps. rip", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Fine", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    else {
                        urlString = JSON["link"] as! String
                        self.performSegueWithIdentifier("showImage", sender: nil)
                    }
                }
        }
    }
    
    @IBAction func takeSnapButtonClicked(sender: AnyObject) {
        self.performSegueWithIdentifier("takeSnap", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

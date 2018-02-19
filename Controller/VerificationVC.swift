
import UIKit

class VerificationVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var verifyView: UIView!
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var txt4: UITextField!
    @IBOutlet weak var txt5: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       UpdateUI()
    }
 
    func UpdateUI() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        verifyView.layer.cornerRadius = 10
        btnSubmit.layer.cornerRadius = 7
        btnSubmit.layer.borderWidth = 3
        btnSubmit.layer.borderColor = UIColor.white.cgColor
        txt1.delegate = self
        txt2.delegate = self
        txt3.delegate = self
        txt4.delegate = self
        txt5.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == txt1 {
            textField.resignFirstResponder()
            txt2.becomeFirstResponder()
        } else if textField == txt2 {
            textField.resignFirstResponder()
            txt3.becomeFirstResponder()
        } else if textField == txt3 {
            textField.resignFirstResponder()
            txt4.becomeFirstResponder()
        } else if textField == txt4 {
            textField.resignFirstResponder()
            txt5.becomeFirstResponder()
        } else if textField == txt5 {
            textField.resignFirstResponder()
            self.view.endEditing(true)
        }
        return true
    }
    
    //MARK: WebService:-
    
    func Verify() {
        
        if !CommonModule.isNetworkReachable() {
            
            CommonModule.ErrorMsg(Msg.APP_NAME, message: Msg.NO_CONNECTION)
            return
        }
        indicator.startAnimating()
        
        
        WebServiceWrapper().verifyUser(confirmation_code: txt1.text! + txt2.text!
            + txt3.text! + txt4.text! + txt5.text!, completionBlock: { (dict, error) in
            
            if error != nil {
                
                print("error")
            }
            else {
                
                let success = dict?.object(forKey: "success") as! String
                
                if success == "UserConfirm" {
                    
                    self.view.endEditing(true)
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let VC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                    self.navigationController?.pushViewController(VC, animated: true)
                }
                else {
                    
                    let msg = dict?.object(forKey: "message") as! String
                    CommonModule.ErrorMsg(Msg.APP_NAME, message: msg)
                }
            }
            self.indicator.stopAnimating()
        })
    }
    
    func poptoSpecificVC(viewController : Swift.AnyClass){
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController.isKind(of: viewController) {
                self.navigationController!.popToViewController(aViewController, animated: true)
                break;
            }
        }
    }

    
    @IBAction func btnSubmitClick(_ sender: Any) {
        
        Verify()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

}

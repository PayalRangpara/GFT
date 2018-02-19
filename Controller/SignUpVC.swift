

import UIKit

class SignUpVC: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtCPass: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       UpdateUI()
    }
    
    //MARK: WebService:-
    
    func SignUP() {
        
        if !CommonModule.isNetworkReachable() {
            
            CommonModule.ErrorMsg(Msg.APP_NAME, message: Msg.NO_CONNECTION)
            return
        }
        if textValidation() {
            
            indicator.startAnimating()
            
            WebServiceWrapper().userRegistration(name: txtUserName.text!, email: txtEmail.text!, mobile_number: "", password: txtPass.text!, c_password: txtCPass.text! , completionBlock: { (dict, error) in
                
                if error != nil {
                    
                    print("error")
                }
                else {
                    
                    let dict1 = dict?.object(forKey: "success") as! NSDictionary
                    
                    let msg = dict1.object(forKey: "message") as! String
                    
                    CommonModule.actionAlert(Msg.APP_NAME, message: msg, action: {action1 in
                        
                        self.view.endEditing(true)
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let VC = storyBoard.instantiateViewController(withIdentifier: "VerificationVC") as! VerificationVC
                        self.navigationController?.pushViewController(VC, animated: true)
                        
                    }, vc: self)
                    
                }
                self.indicator.stopAnimating()
            })
        }
    }


    //MARK: Button Action:-
    
    @IBAction func btnSignUpClick(_ sender: Any) {
        
        SignUP()
    }
    
    //MARK: UDF:-
    
    func UpdateUI() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        signUpView.layer.cornerRadius = 10
        btnSignUp.layer.cornerRadius = 7
        btnSignUp.layer.borderWidth = 3
        btnSignUp.layer.borderColor = UIColor.white.cgColor
        txtUserName.delegate = self
        txtEmail.delegate = self
        txtPass.delegate = self
        txtCPass.delegate = self
    }
    
    func textValidation() -> Bool {
        
        if txtUserName.text!.count > 0 {
            if txtEmail.text!.count > 0 {
                if CommonModule.isValidEmail(testStr: txtEmail.text!) {
                    if txtPass.text!.count > 0 {
                        if txtCPass.text!.count > 0 {
                            if (txtPass.text == txtCPass.text) {
                                return true
                            }
                            else {
                                CommonModule.WarningMsg(Msg.APP_NAME, message: Msg.NOT_MATCH_PASS)
                                return false
                            }
                        }
                        else {
                            CommonModule.WarningMsg(Msg.APP_NAME, message: Msg.RE_ENTER_PASS)
                            return false
                        }
                    }
                    else {
                        CommonModule.WarningMsg(Msg.APP_NAME, message: Msg.PASSWORD)
                        return false
                    }
                }
                else {
                    CommonModule.WarningMsg(Msg.APP_NAME, message: Msg.VALID_EMAIL)
                    return false
                }
            }
            else {
                CommonModule.WarningMsg(Msg.APP_NAME, message: Msg.EMAIL)
                return false
            }
        }
        else {
            CommonModule.WarningMsg(Msg.APP_NAME, message: Msg.USER_NAME)
            return false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
  
}

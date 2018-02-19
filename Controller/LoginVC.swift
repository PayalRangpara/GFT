
import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var LoginView: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnForgotPass: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       UpdateUI()
    }
    
    //MARK: UDF:-
    
    func UpdateUI() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        LoginView.layer.cornerRadius = 10
        btnSignUp.layer.cornerRadius = 7
        btnSignUp.layer.borderWidth = 3
        btnSignUp.layer.borderColor = UIColor.white.cgColor
    }
    
    //MARK: WebService:-
    
    func Login() {
        
        if !CommonModule.isNetworkReachable() {
            
            CommonModule.ErrorMsg(Msg.APP_NAME, message: Msg.NO_CONNECTION)
            return
        }
        if textValidation() {
            
            indicator.startAnimating()
            WebServiceWrapper().userLogin(email: txtName.text!, Password: txtPass.text!, completionBlock: { (dict, error) in
                
                if error != nil {
                    
                    print("error")
                }
                else {
                    
                    let dict1 = dict?.object(forKey: "success") as! NSDictionary
                    let msg = dict1.object(forKey: "token") as! String
                    
                    UserDefaults.standard.set(msg, forKey: "TOKEN")
                    
                    self.view.endEditing(true)
                    
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let vc: UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                    vc.selectedIndex = 0
                    self.present(vc, animated: true, completion: nil)
                    
                }
                self.indicator.stopAnimating()
            })
        }
    }

    func textValidation() -> Bool {
        
        if txtName.text!.count > 0 {
            if txtPass.text!.count > 0 {
                return true
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

    //MARK: Button Action:-
    
    @IBAction func btnSignUpClick(_ sender: Any) {
        
       Login()
    }
    
    @IBAction func btnForgotPass(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

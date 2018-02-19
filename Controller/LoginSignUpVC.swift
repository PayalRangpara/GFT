
import UIKit

class LoginSignUpVC: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
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
        btnLogin.layer.cornerRadius = 7
        btnSignUp.layer.cornerRadius = 7
    }

    //MARK: Button Action:-
    
    @IBAction func btnLoginClick(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(VC, animated: true)
    }

    @IBAction func btnSignUpClick(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnFacebookClick(_ sender: Any) {
    }
    
    @IBAction func btnTwitterClick(_ sender: Any) {
    }
    
    @IBAction func btnGoogleClick(_ sender: Any) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

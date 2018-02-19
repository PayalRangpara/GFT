
import Foundation
import UIKit

struct Color {
    
    static let WHITE = UIColor.white
    static let BLACK = UIColor.black
    static let CLEAR = UIColor.clear
    static let RED = UIColor.red
  
}

struct API {
    
    static let GFT_API = "http://apigft.sulphurtechnologies.com/public/api/"
    static let LOGIN_URL = GFT_API + ("login")
    static let SIGNUP_URL = GFT_API + ("register")
    static let VERIFY = GFT_API + ("register/verify")
    static let DETAILS = GFT_API + ("details")
}


struct Msg {
    
    static let APP_NAME = "GFT"
    static let INVALID = "Invalid credetials! Please try again"
    static let ADD_TAGS = "You can add only five tags"
    static let PASSWORD = "Please enter your password"
    static let NOT_MATCH_PASS = "Password and confirm password does not match"
    static let RE_ENTER_PASS = "Please enter your confirm password"
    static let USER_NAME = "Please enter your username"
    static let EMAIL = "Please enter your email address"
    static let NO_CONNECTION = "It seems that you are offline. Please check internet connectivity"
    static let NOT_REGISTER = "Not Registered"
    static let FB_LOGIN_FAILED = "Facebook Login failed. Please login in your device settings."
    static let VALID_EMAIL = "Your email id is not valid, please enter valid email id."
    static let MANDATORY = "Fields with red color are mandatory"
    
}

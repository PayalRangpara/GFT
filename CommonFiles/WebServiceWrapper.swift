
import UIKit
import Foundation
import AFNetworking

var True = "True"
var False = "False"

var baseUrl = API.GFT_API

func GetBool(boolVar : Bool) -> String{
    if (boolVar == true){
        return True
    }
    return False
}

public enum ServiceType{
    case Get
    case Post
}


public typealias CompletionBlock = (AnyObject?, AnyObject?) -> Void

class WebServiceWrapper: NSObject {
    
    var logging : Bool!
    
    internal var completionBlock : CompletionBlock!
    internal var manager = AFHTTPSessionManager()
    
    //  MARK: - Methods Declarations
    
    static func newObject() -> WebServiceWrapper!{
        let service = WebServiceWrapper()
        service.logging = true
        return service
    }
    
    override init() {
        super.init()
        self.logging = false
    }
    
    //  MARK: - Services
    func callServiceWithUrl(url : String, serviceType: ServiceType, parameters : NSDictionary!, requestSerializer : AFHTTPRequestSerializer!, responseSerializer : AFJSONResponseSerializer!, successBlock:@escaping CompletionBlock) -> URLSessionDataTask!{
        
        let manager = AFHTTPSessionManager(baseURL: NSURL(string: baseUrl) as URL?)
        if let _ = requestSerializer{
            manager.requestSerializer = requestSerializer
            manager.requestSerializer.timeoutInterval = 7
        }
        
        if let _ = responseSerializer{
            manager.responseSerializer = responseSerializer
        }
        
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/json","application/json","text/javascript", "text/html") as? Set<String>
        
//        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/json") as? Set<String>
        
        var task : URLSessionDataTask!
 
        if serviceType == ServiceType.Post {
            
            task = manager.post(url, parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any) in
                successBlock(responseObject as AnyObject?,nil)
                
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                self.handleFailureOfService(operation: task!, error: error as NSError)
            })
        }
        else
        {
            task = manager.get(url, parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any) in
                successBlock(responseObject as AnyObject?,nil)
                
            }, failure: { (task: URLSessionDataTask?, error: Error  ) in
                self.handleFailureOfService(operation: task!, error: error as NSError)
            })
        }
        
        return task
    }
    
    func handleFailureOfService(operation : URLSessionDataTask, error : NSError){
        //  Failure
        print("\(error)")
        let urlResponse = operation.response as? HTTPURLResponse
        
        if (urlResponse?.statusCode == 400 || urlResponse?.statusCode == 404 || urlResponse?.statusCode == 403 || urlResponse?.statusCode == 500){//   bad request.
            
            print(operation.description)
            let data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as! NSData
            let dict = try?JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
            print(dict!)
            
        }
    
        if (urlResponse?.statusCode == 401){//   bad request.
            let data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as! NSData
            _ = try?JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
            
        }
        self.completionBlock(nil, error)
    }
    
    //MARK: Service 1 Login
    
    @discardableResult
    func userLogin(email : String, Password : String, completionBlock:@escaping CompletionBlock) -> URLSessionDataTask!{
        
        self.completionBlock = completionBlock
        var params: NSDictionary
        params = ["email": email,"password": Password]
        let operation = self.callServiceWithUrl(url: API.LOGIN_URL, serviceType:.Post, parameters: params, requestSerializer: nil, responseSerializer: AFJSONResponseSerializer()) { (responseObject, error) -> Void in
            if (error != nil){
                //  we got some error!
                completionBlock(nil, error)
            }
            else{
                
                let dict = responseObject as! NSDictionary
                completionBlock(dict, nil)
            }
        }
        return operation
    }
    
    
    //MARK: Service 2 Verify
    
    @discardableResult
    func verifyUser(confirmation_code : String, completionBlock:@escaping CompletionBlock) -> URLSessionDataTask!{
        
        self.completionBlock = completionBlock
        var params: NSDictionary
        params = ["confirmation_code" : confirmation_code]
        let operation = self.callServiceWithUrl(url: API.VERIFY, serviceType:.Post, parameters: params, requestSerializer: nil, responseSerializer: AFJSONResponseSerializer()) { (responseObject, error) -> Void in
            if (error != nil){
                //  we got some error!
                completionBlock(nil, error)
            }
            else{
                
                let dict = responseObject as! NSDictionary
                completionBlock(dict, nil)
            }
        }
        return operation
    }

    //MARK: Service 4 Registration

    @discardableResult
    func userRegistration(name : String, email : String, mobile_number : String, password : String, c_password : String, completionBlock:@escaping CompletionBlock) -> URLSessionDataTask!{
        
        self.completionBlock = completionBlock
        var params: NSDictionary
        params = ["name": name,"email": email,"mobile_number":"9876543210", "password":password,"c_password":c_password]
        
        let operation = self.callServiceWithUrl(url: API.SIGNUP_URL, serviceType:.Post, parameters: params, requestSerializer: nil, responseSerializer: AFJSONResponseSerializer()) { (responseObject, error) -> Void in
            if (error != nil){
                //  we got some error!
                completionBlock(nil, error)
            }
            else{
                
                let dict = responseObject as! NSDictionary
                completionBlock(dict, nil)
            }
        }
        return operation
    }
    
}

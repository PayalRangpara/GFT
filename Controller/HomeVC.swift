
import UIKit
import AACarousel
import Alamofire

class HomeVC: UIViewController, AACarouselDelegate {
    
    @IBOutlet weak var AnimationView: AACarousel!
    var titleArray = [String]()
    let token = UserDefaults.standard.object(forKey: "TOKEN") as! String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDetails()
        
        let pathArray = ["Layer1","Layer2","Layer3","Layer4","Layer5"]
        titleArray = ["LOGAN PYE","OSCAR IVORY","TIM HARRISON","MAX RAMSDEN","JEMS"]
        AnimationView.delegate = self
        AnimationView.setCarouselData(paths: pathArray,  describedTitle: [""], isAutoScroll: false, timer: 0.0, defaultImage: "")
        //optional methods
        AnimationView.setCarouselOpaque(layer: true, describedTitle: false, pageIndicator: true)
        AnimationView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 0, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: Color.CLEAR)
        
    }
    
    func downloadImages(_ url: String, _ index: Int) {
        
    }

    func didSelectCarouselView(_ view: AACarousel, _ index: Int) {
        
        startAutoScroll()
        stopAutoScroll()
    }
    
    func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
        
    }
    
    func startAutoScroll() {
        //optional method
        AnimationView.startScrollImageView()
        
    }
    
    func stopAutoScroll() {
        //optional method
        AnimationView.stopScrollImageView()
    }
    
    //MARK: WebService:-
    func getDetails() {
        
        var baseURL = API.DETAILS
        baseURL = baseURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print(baseURL)
        
        let headerString = "Bearer" + " " + token!
        let headers: HTTPHeaders = [
            "Authoriation": headerString,"Accept": "application/json"]
        Alamofire.request(baseURL, method: .get, parameters: nil , encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success:
                
                let json = response.result.value as! NSDictionary
                print(json)
               
                break
                
            case .failure(let error):
    
                break
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

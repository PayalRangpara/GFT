
import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.sharedManager().enable = true
        
        // Override point for customization after application launch.
        return true
    }
    
    
    func loadTabbarController() {
        
        let nav1 = UINavigationController()
        var home = UIViewController()
        home =   HomeVC(nibName: nil, bundle: nil)
        nav1.viewControllers = [home]
        nav1.navigationBar.isTranslucent = false
        
        let map = TrainingChartVC(nibName: nil, bundle: nil)
        let nav2 = UINavigationController()
        nav2.viewControllers = [map]
        nav2.navigationBar.isTranslucent = false
        
        let chat = ClientVC(nibName: nil, bundle: nil)
        let nav3 = UINavigationController()
        nav3.viewControllers = [chat]
        nav3.navigationBar.isTranslucent = false
        
        let noti = TrainerVC(nibName: nil, bundle: nil)
        let nav4 = UINavigationController()
        nav4.viewControllers = [noti]
        nav4.navigationBar.isTranslucent = false
        
        let setting = ChartVC(nibName: nil, bundle: nil)
        let nav5 = UINavigationController()
        nav5.viewControllers = [setting]
        nav5.navigationBar.isTranslucent = false
        
        home.tabBarItem.image=#imageLiteral(resourceName: "home").withRenderingMode(.automatic)
        home.tabBarItem.selectedImage = #imageLiteral(resourceName: "home copy").withRenderingMode(.automatic)
        home.tabBarItem.title = nil
        home.tabBarItem.imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        map.tabBarItem.image=#imageLiteral(resourceName: "training chart").withRenderingMode(.automatic)
        map.tabBarItem.selectedImage = #imageLiteral(resourceName: "training chart copy").withRenderingMode(.automatic)
        map.tabBarItem.title = nil
        map.tabBarItem.imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        chat.tabBarItem.image=#imageLiteral(resourceName: "client").withRenderingMode(.automatic)
        chat.tabBarItem.selectedImage = #imageLiteral(resourceName: "client copy").withRenderingMode(.automatic)
        chat.tabBarItem.title = nil
        chat.tabBarItem.imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        noti.tabBarItem.image=#imageLiteral(resourceName: "trainer").withRenderingMode(.automatic)
        noti.tabBarItem.selectedImage = #imageLiteral(resourceName: "trainer copy").withRenderingMode(.automatic)
        noti.tabBarItem.title = nil
        noti.tabBarItem.imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        setting.tabBarItem.image=#imageLiteral(resourceName: "chart").withRenderingMode(.automatic)
        setting.tabBarItem.selectedImage = #imageLiteral(resourceName: "chart-copy").withRenderingMode(.automatic)
        setting.tabBarItem.title = nil
        setting.tabBarItem.imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        
        let tabs = UITabBarController()
        tabs.viewControllers = [nav1, nav2, nav3, nav4, nav5]
        tabs.tabBar.isTranslucent = false
        tabs.tabBar.backgroundColor = Color.WHITE
//        self.window!.rootViewController = tabs
       
        self.window?.rootViewController?.present(tabs, animated: true, completion: nil)
        self.window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


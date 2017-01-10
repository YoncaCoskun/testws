//
//  AppDelegate.swift
//  testws
//
//  Created by Yonca Coskun on 7.01.2017.
//  Copyright © 2017 PoncikApps. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]? = [:]) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
        
        FIRApp.configure()
        return true
    }
    
}

//
//  AppDelegate.swift
//  Background
//
//  Created by Lucas Longo on 8/21/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        return true
    }
    
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        // Chamando a função que esta no ViewController
        if let viewController = window?.rootViewController as? ViewController {
            
            viewController.fetchDateBy("Background Mode", completion: { () -> Void in
                
                println("Done in Background Mode")
                completionHandler(UIBackgroundFetchResult.NewData)
                
                }, downloadFailed: { () -> Void in
                    
                    println("ERRO in Background Mode")
                    completionHandler(UIBackgroundFetchResult.Failed)
            })
        }
        
        // Chamando a função que esta nesta classe
        fetchDateBy("Background MOde", completion: { () -> Void in
            println("Executei fetch do AppDelegate")
        }) { () -> Void in
            println("ERRO no fetch do AppDelegate")
        }
    }
    
    func fetchDateBy(name: String, completion: () -> Void, downloadFailed: () -> Void) {
        if let url = NSURL(string: "http://iai.art.br/escola/backgroundFetch.php") {
            if let dateString = NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding, error: nil) {
                println("\(name) \(dateString)")
                completion()
            }
            else {
                downloadFailed()
            }
        }
        else {
            downloadFailed()
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        //        for i in 0...1000 {
        //            println(i)
        //            NSThread.sleepForTimeInterval(1)
        //        }
        
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}


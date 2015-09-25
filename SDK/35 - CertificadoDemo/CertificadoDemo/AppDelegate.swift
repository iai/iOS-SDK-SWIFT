//
//  AppDelegate.swift
//  CertificadoDemo
//
//  Created by Lucas Longo on 31/08/15.
//  Copyright (c) 2015 Lucas Longo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let settings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound, categories: nil)
        application.registerUserNotificationSettings(settings)
        
        application.registerForRemoteNotifications()
        
        // SE APP ESTAVA COMPLETAMENTE FECHADO (NAO EM BACKGROUND) E FOI ABERTO POR CAUSA DE UM PUSH, NO LAUNCHOPTIONS, TEREMOS O UIApplicationLaunchOptionsRemoteNotificationKey
        if let pushDict = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? NSDictionary {
            println("OPENED APP BECAUSE OF PUSH NOTIFICATION: \(pushDict)")
            
            if let vc = window?.rootViewController as? ViewController {
                vc.view.backgroundColor = UIColor.redColor()
            }
        }

        
        return true
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        
        println("Failed to register for remote notifications \(error.description)")

    }
    

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        println("TOKEN: \(deviceToken.description)")
        
        // ENVIAR TOKEN PARA SEU SERVIDOR PARA PODER ENVIAR PUSH NOTIFICATIONS PARA ESTE APP, NESTE DEVICE - LEMBRE SEMPRE DE PASSAR UM USUARIO OU ALGUM OUTRO IDENTIFICADOR PARA SABER QUEM É ESSE USUÁRUIO
        if let token = deviceToken.description.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            let urlString = "https://iai.art.br/escola/pushNotification/receiveToken.php?token=\(token)&user=lucas"
            let responseString = NSURL(string: urlString)
            println(responseString)
        }

    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
        println("DID RECEIVE NOTIFICATION: \(userInfo.description)")
        
        if let vc = window?.rootViewController as? ViewController {
            
            if let apsDict = userInfo["aps"] as? NSDictionary {
                if let badgeCount = apsDict["badge"] as? Int {
                    if badgeCount == 2 {
                        vc.view.backgroundColor = UIColor.greenColor()
                    }
                    else {
                        vc.view.backgroundColor = UIColor.blueColor()
                    }
                }

            }
        }
    }
    
    
    // USADO QUANDO UM PUSH É ENVIADO INFORMANDO AO APP QUE DEVE BAIXAR CONTEUDO EM BACKGROUND
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        // QUANDO O FETCH TERMINA, CAIMOS AQUI NESTA FUNCÃO
        
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        application.applicationIconBadgeNumber = 0
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


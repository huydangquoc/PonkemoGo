//
//  AppDelegate.swift
//  PonkemoGo
//
//  Created by Dang Quoc Huy on 8/12/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        if let options = launchOptions {
            // check for local notification
            if let notification = options[UIApplicationLaunchOptionsLocalNotificationKey] as? UILocalNotification {
                // check user info
                if let userInfo = notification.userInfo {
                    let selectedPokemon = userInfo["SelectedPokemon"] as! String
                    // launch detail page with selected pokemon
                    openPokemonCatchView(selectedPokemon)
                }
            }
        }
        
        return true
    }

    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        // check user info
        if let userInfo = notification.userInfo {
            let selectedPokemon = userInfo["SelectedPokemon"] as! String
            // launch detail page with selected pokemon
            openPokemonCatchView(selectedPokemon)
        }
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
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func openPokemonCatchView(pokemonName: String) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let pokemonCatchVC = storyboard.instantiateViewControllerWithIdentifier("PokemonCatchViewController") as! PokemonCatchViewController
        pokemonCatchVC.pokemonName = pokemonName
        window?.rootViewController = pokemonCatchVC
        window?.makeKeyAndVisible()
    }
}

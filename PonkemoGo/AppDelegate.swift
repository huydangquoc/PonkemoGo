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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let notificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        
        registerNotification()
        
        if let options = launchOptions {
            // check for local notification
            if let notification = options[UIApplicationLaunchOptionsKey.localNotification] as? UILocalNotification {
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

    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        // check user info
        if let userInfo = notification.userInfo {
            let selectedPokemon = userInfo["SelectedPokemon"] as! String
            // launch detail page with selected pokemon
            openPokemonCatchView(selectedPokemon)
        }
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        
        // Handle notification action *****************************************
        if notification.category == "CatchPokemonCategory" {
            if let action = identifier {
                if action == "CatchPokemonAction" {
                    if let userInfo = notification.userInfo {
                        let selectedPokemon = userInfo["SelectedPokemon"] as! String
                        openPokemonCatchView(selectedPokemon)
                    }
                } else if action == "IgnoreAction" {
                    // do nothing
                    // alert will automatically dismissed???
                }
            }
        }
        
        completionHandler()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func openPokemonCatchView(_ pokemonName: String) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let pokemonCatchVC = storyboard.instantiateViewController(withIdentifier: "PokemonCatchViewController") as! PokemonCatchViewController
        pokemonCatchVC.pokemonName = pokemonName
        window?.rootViewController = pokemonCatchVC
        window?.makeKeyAndVisible()
    }
    
    // Register notification settings
    func registerNotification() {
        
        // 1. Create the actions **************************************************
        // catch action
        let catchAction = UIMutableUserNotificationAction()
        catchAction.identifier = "CatchPokemonAction"
        catchAction.title = "Catch Pokemon"
        catchAction.activationMode = UIUserNotificationActivationMode.foreground
        catchAction.isDestructive = false
        // ignore Action
        let ignoreAction = UIMutableUserNotificationAction()
        ignoreAction.identifier = "IgnoreAction"
        ignoreAction.title = "IGNORE"
        ignoreAction.activationMode = UIUserNotificationActivationMode.background
        ignoreAction.isAuthenticationRequired = true
        ignoreAction.isDestructive = true
        
        // 2. Create the category ***********************************************
        // Category
        let catchPokemonCategory = UIMutableUserNotificationCategory()
        catchPokemonCategory.identifier = "CatchPokemonCategory"
        // A. Set actions for the default context
        catchPokemonCategory.setActions([ignoreAction, catchAction], for: UIUserNotificationActionContext.default)
        // B. Set actions for the minimal context
        catchPokemonCategory.setActions([ignoreAction, catchAction], for: UIUserNotificationActionContext.minimal)
        
        // 3. Notification Registration *****************************************
        let settings = UIUserNotificationSettings(types: [.alert, .sound], categories: Set(arrayLiteral: catchPokemonCategory))
        UIApplication.shared.registerUserNotificationSettings(settings)
    }
}

//
//  AppDelegate.swift
//  HelloSwift
//
//  Created by Masahiro Suzuka on 2014/09/15.
//  Copyright (c) 2014年 Masahiro Suzuka. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var viewController:CDVViewController?;
  
  override init() {
    var cookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage();
    
    //cookieStorage.setCookieAcceptPolicy(NSHTTPCookieAcceptPolicy.Always);
    
    var cacheMemorySize = 8 * 1024 * 1024;
    var cacheDiskSize = 32 * 1024 * 1024;
    
    var sharedCache = NSURLCache(memoryCapacity: cacheMemorySize, diskCapacity: cacheDiskSize, diskPath: "nsurlcache");
    
    NSURLCache.setSharedURLCache(sharedCache);
    
    super.init();
  }

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    var screenBounds = UIScreen.mainScreen().bounds;
    
    self.window = UIWindow(frame: screenBounds);
    self.viewController = CDVViewController();
    
    self.window?.rootViewController = viewController;
    
    self.window?.makeKeyAndVisible();
    
    return true
  }
  
  func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
    var jsString = "handleOpenURL(\"\(url)\");";
    self.viewController?.webView.stringByEvaluatingJavaScriptFromString(jsString);
    
    var notification = NSNotification(name: CDVPluginHandleOpenURLNotification, object: url);
    NSNotificationCenter.defaultCenter().postNotification(notification);
    
    return true;
  }
  
  func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
    NSNotificationCenter.defaultCenter().postNotificationName(CDVLocalNotification, object: notification);
  }
  
//  func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow) -> Int {
//    var supportInterfaceOrientations:Int = (1 << UIInterfaceOrientation.Portrait) | (1 << UIInterfaceOrientation.LandscapeLeft) | (1 << UIInterfaceOrientation.LandscapeRight) | (1 << UIInterfaceOrientation.PortraitUpsideDown);
//    return supportInterfaceOrientations;
//  }
  
  func applicationDidReceiveMemoryWarning(application: UIApplication) {
    NSURLCache.sharedURLCache().removeAllCachedResponses();
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
}

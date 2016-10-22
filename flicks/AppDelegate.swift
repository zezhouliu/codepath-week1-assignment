//
//  AppDelegate.swift
//  flicks
//
//  Created by alex_liu on 10/17/16.
//  Copyright © 2016 alex_liu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.

    let nowPlayingMovieListViewController = MovieListViewController(sortingType: MovieListSortingType.NowPlaying)
    let topRatedMovieListViewController = MovieListViewController(sortingType: MovieListSortingType.TopRated)

    let frameImage = UIImage(named: "frame")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    let popcornImage = UIImage(named: "popcorn")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

    let nowPlayingMovieTabBarItem = UITabBarItem.init(title: "Now Playing", image: frameImage, tag: 0)
    let topRatedMovieTabBarItem = UITabBarItem.init(title: "Top Rated", image: popcornImage, tag: 1)

    nowPlayingMovieListViewController.tabBarItem = nowPlayingMovieTabBarItem
    topRatedMovieListViewController.tabBarItem = topRatedMovieTabBarItem

    let navigationController1 = UINavigationController(rootViewController: nowPlayingMovieListViewController)
    navigationController1.hidesBottomBarWhenPushed = true
    let navigationController2 = UINavigationController(rootViewController: topRatedMovieListViewController)
    navigationController2.hidesBottomBarWhenPushed = true

    let tabBarController = UITabBarController()
    tabBarController.setViewControllers(
      [navigationController1, navigationController2],
      animated: true)


    window?.rootViewController = tabBarController
    return true
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


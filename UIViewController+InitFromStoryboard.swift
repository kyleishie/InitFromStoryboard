//
//  UIViewController+InitFromStoryboard.swift
//
//  Created by Kyle Ishie on 1/10/17.
//  Copyright © 2017 Kyle Ishie. All rights reserved.
//

import UIKit

extension UIStoryboard {
    @objc public static let main = "Main"
}


fileprivate let navigationControllerSuffix = "NavigationController"

extension UIViewController {
    
    /**
     Creates and return a UIViewController subclass of the calling Type from the given storyboard and bundle.
     
     @param storyboardIdentifier The Identifier of the view controller in the specified storyboard. Defaults to the calling class's name using String(describing: self).
     @param name The name of the storyboard containing the view controller scene. Defaults to "Main".
     @param bundle The bundle containing the storyboard.  Defaults to nil .i.e the main bundle.
     */
    /// This version is simply to help the compliler infer type
    public static func initFromStoryboard(storyboardIdentifier: String? = nil, storyboardName: String = UIStoryboard.main, bundle: Bundle? = nil) -> Self   {
        let identifier = storyboardIdentifier ?? String(describing: self)
        return instantiateFromStoryboard(storyboardIdentifier: identifier, storyboardName: storyboardName, bundle: bundle)
    }
    
    /**
     Creates and returns a UINavigationViewController from the given storyboard.
     
     @param storyboardIdentifier The Identifier of the navigation controller in the specified storyboard. Defaults to the calling class's name using String(describing: self) + "NavigationController".
     @param name The name of the storyboard containing the view controller scene. Defaults to "Main" for the typical xcode created Main.storyboard.
     @param bundle The bundle containing the storyboard.  Defaults to the main bundle.
     */
    public static func initNavigationControllerFromStoryboard(storyboardIdentifier: String? = nil, storyboardName: String = UIStoryboard.main, bundle: Bundle? = nil) -> UINavigationController {
        let identifier = storyboardIdentifier ?? String(describing: self) + navigationControllerSuffix
        return instantiateFromStoryboard(storyboardIdentifier: identifier, storyboardName: storyboardName, bundle: bundle)
    }
    
    /// Generic version to all this to work on all subclass type.
    private static func instantiateFromStoryboard<T>(storyboardIdentifier: String, storyboardName: String, bundle: Bundle?) -> T   {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! T
        return viewController
    }
}

/// Obj-C Support
extension UIViewController {
    
    @objc public static func initFromStoryboard() -> Self {
        return initFromStoryboard(storyboardName: UIStoryboard.main)
    }
    
    @objc public static func initFromStoryboardWith(storyboardName: String) -> Self {
        return initFromStoryboard(storyboardName: storyboardName)
    }
    
    @objc public static func initNavigationControllerFromStoryboard() -> UINavigationController {
        return initNavigationControllerFromStoryboard(storyboardName: UIStoryboard.main)
    }
    
    @objc public static func initNavigationControllerFromStoryboardWith(storyboardName: String) -> UINavigationController {
        return initNavigationControllerFromStoryboard(storyboardName: storyboardName)
    }
}




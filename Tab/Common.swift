//
//  Common.swift
//  Tab
//
//  Created by Rafi on 11/27/17.
//  Copyright © 2017 Radio Treetal Bangla. All rights reserved.
//
import UIKit
import Foundation
import SystemConfiguration

// Checking for Internet connectivity
func isInternetAvailable() -> Bool
{
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress)
    {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1)
        {
            zeroSockAddress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags)
    {
        return false
    }
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    return (isReachable && !needsConnection)
}

// Displaying Alert
func showALert(viewController : UIViewController, title : String, message : String)
{
    let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
    viewController.present(alertController, animated: true, completion: nil)
}

//
//  SwiftForUnity.swift
//  JuniperPlugin
//
//  Created by Malaika Penn on 3/13/20.
//  Copyright © 2020 Malaika Penn. All rights reserved.
//

import Foundation
import UIKit
import ExternalAccessory

@objc public class SwiftForUnity: UIViewController {
    @objc static let shared = SwiftForUnity()
    var sessionController:              SessionController!
    var accessoryList:                  [EAAccessory]?
    var selectedAccessory:              EAAccessory?
    
    @objc func setupAccessoryList () -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(accessoryDidConnect), name: NSNotification.Name.EAAccessoryDidConnect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(accessoryDidDisconnect), name: NSNotification.Name.EAAccessoryDidDisconnect, object: nil)
        EAAccessoryManager.shared().registerForLocalNotifications()
        
        sessionController = SessionController.sharedController
        accessoryList = EAAccessoryManager.shared().connectedAccessories
    }
    
    //check if there is an available geode to connect to
    @objc func isAccessory () -> Bool {
        if (accessoryList?.count ?? 0 > 0 && accessoryList?[0].name == "Geode") {
            return true;
        } else {
            return false;
        }
    }
    
    @objc func connect () -> Void {
        selectedAccessory = accessoryList?[0]
        sessionController.setupController(forAccessory: selectedAccessory!, withProtocolString: (selectedAccessory?.protocolStrings[0])!)
    }
    
    @objc func disconnect () -> Void {
        selectedAccessory = nil
        sessionController.closeSession()
    }
    
    @objc func accessoryDidConnect(notificaton: NSNotification) {
          let connectedAccessory =        notificaton.userInfo![EAAccessoryKey]
          accessoryList?.append(connectedAccessory as! EAAccessory)
      }
      
      
      @objc func accessoryDidDisconnect(notification: NSNotification) {
          let disconnectedAccessory =             notification.userInfo![EAAccessoryKey]
          var disconnectedAccessoryIndex =        0
          for accessory in accessoryList! {
              if (disconnectedAccessory as! EAAccessory).connectionID == accessory.connectionID {
                  break
              }
              disconnectedAccessoryIndex += 1
          }
          
          if disconnectedAccessoryIndex < (accessoryList?.count)! {
              accessoryList?.remove(at: disconnectedAccessoryIndex)
          } else {
              print("Could not find disconnected accessories in list")
          }
      }
}

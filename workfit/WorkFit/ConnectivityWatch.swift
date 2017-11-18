//
//  ConnectivityWatch.swift
//  WorkFit
//
//  Created by IFCE on 21/02/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import WatchKit
import WatchConnectivity

protocol ConnectivityDelegate: class {
    func receiveMessage(dic: NSDictionary)
}

class ConnectivityWatch: NSObject, WCSessionDelegate {
    
    var session: WCSession?
    weak var delegate: ConnectivityDelegate!
    
    func connect() {
        if (WCSession.isSupported()) {
            session = WCSession.default()
            session?.delegate = self
            session?.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?){
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession){
        
    }
    
    func sessionDidDeactivate(_ session: WCSession){
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        replyHandler(["received" : true])
        delegate.receiveMessage(dic: message as NSDictionary)
    }
    
    
    func sendMessage(export: Dictionary<String, Any>){
        let applicationData = export
        if (WCSession.isSupported()) {
            print("SESSION AVAIBLE")
            OperationQueue.main.addOperation { () -> Void in
                self.session?.transferUserInfo(applicationData)
                //                self.session?.sendMessage(applicationData as! [String : Any], replyHandler: nil, errorHandler: nil)
            }
            if WCSession.default().isReachable{
                print("SESSION REACHABLE")
            }
        }else{
            print("SESSION FAILED")
        }
    }
}

//
//  WatchConnectivityProvider.swift
//  WaterMyPlants
//
//  Created by Toomas Vahter on 08.02.2020.
//  Copyright © 2020 Augmented Code. All rights reserved.
//

import CoreData
import Foundation
import os
import WatchConnectivity

final class WatchConnectivityProvider: NSObject, WCSessionDelegate {
    
    // MARK: Creating the Provider
    

    private let session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
    }
    
    // MARK: Managing Connection
    
    func connect() {
        guard WCSession.isSupported() else {
            print("session not supported")
            return
        }
        print("supported...")
        session.activate()
    }
    
    // MARK: Sending Data to Watch
    
    func notePlantsDidChange() {
        guard session.activationState == .activated else {
            print("session not active")
            return
        }
        
        do {
            let context: [String: Any] = [:]
            try session.updateApplicationContext(context)
        }
        catch let nsError as NSError {
            print("failed updating application context", nsError)
            
        }
    }
    
    // MARK: Watch Session Delegate
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("session inactive")
       
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("session deactivated")
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void) {
        print("message recieved")
//        guard let contentString = message[WatchCommunication.requestKey] as? String , let _ = WatchCommunication.Content(rawValue: contentString) else {
//            replyHandler([:])
//            return
//        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("did finish activating session")
    }
}

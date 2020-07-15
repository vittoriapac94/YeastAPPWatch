
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
    
    func sendTime(time : Any){
        let message = ["tempo" : time]
        session.sendMessage(message, replyHandler: {
            (payload) in
            print(payload)
        }, errorHandler: {
            (error) in
            print(error)
        })
        print("messaggio inviato")
    }

    
    // MARK: Watch Session Delegate
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("session inactive")
       
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("session deactivated")
        
    }
    

    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("did finish activating session")
    }
}

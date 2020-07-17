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
    

    
    // MARK: Watch Session Delegate
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("phone session inactive")
        connect()
       
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("phone session deactivated")
        connect()
        
    }
    
    func sendTime(image : String, timeS : Any, timeM : Any, timeH: Any, percentage : Any) {
        guard session.activationState == .activated else {
            print("phone session is not active")
            
            return
        }
        let message = ["tempoS" : timeS, "tempoM" : timeM, "tempoH" : timeH, "image" : image, "percentage" : percentage]
        session.sendMessage(message, replyHandler: { (payload) in
           print(payload)
        }, errorHandler: { error in
            print("sending message failed")
        })
        print("messaggio inviato")
    }
    

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("did finish activating phone session")
    }
}

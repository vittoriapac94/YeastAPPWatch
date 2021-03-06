//
//  PhoneConnectivityProvider.swift
//  WaterMyPlantsWatch Extension
//
//  Created by Toomas Vahter on 08.02.2020.
//  Copyright © 2020 Augmented Code. All rights reserved.
//

import Foundation
import os
import WatchConnectivity


final class PhoneConnectivityProvider: NSObject, WCSessionDelegate {
    
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
            print("session is not supported")
            return
        }
        print("activating session")
        session.activate()
    }
    


    // MARK: Watch Session Delegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("did finish activating session")
       
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void) {
        DispatchQueue.main.async {
            let handler = Handler.sharedHandler
            handler.tempoS = message["tempoS"] as! String
            handler.tempoM = message["tempoM"] as! String
            handler.tempoH = message["tempoH"] as! String
            handler.nomeImmagine = message["image"] as! String
            handler.percentuale = message["percentage"] as! String
            handler.flag = message["flag"] as! String
            print(handler.tempoS, handler.flag)
            
        }
       
       
    }

   
}

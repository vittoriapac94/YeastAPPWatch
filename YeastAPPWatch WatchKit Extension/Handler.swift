//
//  Handler.swift
//  provaSession WatchKit Extension
//
//  Created by utente on 17/07/2020.
//  Copyright © 2020 utente. All rights reserved.
//

import Foundation

class Handler : ObservableObject{
    
    static let sharedHandler = Handler()
    @Published var tempoM : String = "0"
    @Published var tempoS : String = "0"
    @Published var tempoH : String = "0"
    @Published var percentuale : String = ""
    @Published var nomeImmagine : String = "femaleAvatar0"
    @Published var flag : String = "false"
    private init(){}

}

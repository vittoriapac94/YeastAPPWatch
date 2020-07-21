//
//  ContentView.swift
//  YeastAPPWatch WatchKit Extension
//
//  Created by Lorenzo Magnano on 10/07/2020.
//  Copyright © 2020 Lorenzo Magnano. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var provider = PhoneConnectivityProvider()
    @ObservedObject var localHandler = Handler.sharedHandler
    var body: some View {
        ProgressBar()
            .frame(width: 143, height: 143)
            .onAppear(perform: {
                self.provider.connect()
                
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ProgressBar: View {
    @ObservedObject var localHandler = Handler.sharedHandler
    @State var isAlert = false
    var body: some View {
        VStack{
            ZStack {
                Circle()
                    .stroke(lineWidth: 15.0)
                    .opacity(0.3)
                    .foregroundColor(Color.red)
                Circle()
                    .trim(from: 0.0, to: CGFloat(min((localHandler.percentuale as NSString).doubleValue, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.red)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear)
                Image(localHandler.nomeImmagine)
                    .resizable()
                    .scaledToFit()
            }
            Spacer().frame(height: 13.0)
            
            HStack{
                Text("\(localHandler.tempoH) h")
                    .font(.system(size: 14, weight: .light))
                Text(":")
                Text("\(localHandler.tempoM) m")
                    .font(.system(size: 14, weight: .light))
                Text(":")

                Text("\(Int(localHandler.tempoS) ?? 0 % 60) s")
                    .font(.system(size: 14, weight: .light))
                    

            }
            .onReceive(localHandler.$flag){ _ in
                    
                self.isAlert = Bool(self.localHandler.flag) ?? false
                
            }
            .alert(isPresented: $isAlert) {
                Alert(title: Text("Important message"), message: Text("It's time to refresh!"), dismissButton: .default(Text("Got it!")))
            }
          
            
        }.edgesIgnoringSafeArea(.bottom)

        
        
            

    }
}

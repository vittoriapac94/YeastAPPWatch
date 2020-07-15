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
    let hourInSecond = 172800
    @State var progressValuePercentage: Double = 0.00
    @State var timeRemaining = 15.00
    @State var angle = 0
    @State var hoursD = 0.00
    @State var hoursI = 0
    @State var min = 0.00
    @State var minI = 0
    @State var alert = false
    
    var body: some View {
 
 
       
        ProgressBar(progress: self.$progressValuePercentage, hours: self.$hoursI, minutes : self.$minI, seconds: self.$timeRemaining)
                        .frame(width: 143, height: 143)
            .onAppear(perform: {
                self.provider.connect()
                self.provider.readMessage()
            })

    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
     
        ContentView()
    }
}
 
struct ProgressBar: View {
    @Binding var progress: Double
    @Binding var hours : Int
    @Binding var minutes : Int
    @Binding var seconds : Double
   
    var body: some View {
        VStack{
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
           
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
              Image("maleAvatar1")
              .resizable()
              .scaledToFit()
 
           
        }
            Spacer().frame(height: 13.0)
             
        HStack{
                            Text("48 h")
                                .font(.system(size: 14, weight: .light))
                            Text(":")
                            Text("59 m")
                                .font(.system(size: 14, weight: .light))
                            Text(":")
                            Text("59 s")
                                .font(.system(size: 14, weight: .light))
                        }
       
                       
 
        }.edgesIgnoringSafeArea([.bottom])
    }
}

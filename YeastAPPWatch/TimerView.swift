//
//  TimerView.swift
//  YeastIT
//
//  Created by utente on 07/07/2020.
//  Copyright © 2020 vittoria. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    let hourInSecond = 172800
    var localQuantity : String
    var localName : String
    @State var imageName : String
    @State var progressValuePercentage: Double = 0.00
    @State var tempo = 172800.00
    @State var hoursD = 0.00
    @State var hoursI = 0
    @State var min = 0.00
    @State var minI = 0
    @State var angle = 0
    @State var alert = false
    @State var isVisible = false
    @State var nRefresh = 1
    @State var imageCounter = 0
    let imageDimension : CGFloat = 228
    let avatarImageDimension : CGFloat = 500
    
    @Environment(\.presentationMode) var presentationMode
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        ZStack{
            
            Image("bcq")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            
            
            VStack{
                Button(action : {
                    self.timer.upstream.connect().cancel()
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    HStack{
                        
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.white)
                        Text("Back")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.white)
                        
                        
                        Rectangle()
                            .opacity(0)
                        
                    }.frame(width: 350, height: 25)
                }
                
                
                
                ZStack{
                    
                    Image("RettangoloAvatar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageDimension  , height: imageDimension)
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: avatarImageDimension / 2, height: avatarImageDimension / 2)
                        .onReceive(timer){_ in
                            if self.tempo > 0{
                                if (Int(self.tempo) == self.hourInSecond / 2){
                                    self.imageCounter += 1
                                }
                                if (Int(self.tempo) == self.hourInSecond / 3){
                                    self.imageCounter += 1
                                }
                                
                                var temp = self.imageName.dropLast()
                                temp = temp + String(self.imageCounter)
                                self.imageName = String(temp)
                                self.tempo -= 3600
                                self.progressValuePercentage = ((self.tempo * 100) / Double(self.hourInSecond)) / 100
                                
                                self.hoursD = self.tempo / 3600.00
                                self.hoursI = Int(self.hoursD)
                                self.min = self.hoursD - Double(self.hoursI)
                                
                                self.minI = Int(self.min * 60)
                                print(self.tempo)
                                
                                
                            }else{
                                
                                //notifica watch
                                if (self.imageCounter == 2){
                                   self.imageCounter += 1
                                }
                                
                                var temp = self.imageName.dropLast()
                                temp = temp + String(self.imageCounter)
                                self.imageName = String(temp)
                                
                                self.isVisible = true
                                
                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (status, _) in
                                    
                                    
                                    if status{
                                        
                                        let content = UNMutableNotificationContent()
                                        content.title = "Notification from Yeast It"
                                        content.body = "Finito!!"
                                        
                                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                                        
                                        let request = UNNotificationRequest(identifier: "noti", content: content, trigger: trigger)
                                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                                        
                                        return
                                    }
                                    
                                    self.alert.toggle()
                                }
                                
                            }
                            
                            
                            
                    }
                    .alert(isPresented: $alert){
                        return Alert(title: Text("Please Enable Notification Access In Settings Pannel !!!"))
                    }
                    
                }
                
                
                
                
                Text("\(localName.uppercased())")
                    .font(.largeTitle)
                    .foregroundColor(Color.black)
                    .frame(width : 500)
                
                Spacer()
                    .frame(width:1)
                ZStack{
                    Rectangle().foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.0))
                        .overlay(
                            
                            HStack{
                                
                                ProgressBar(progress: self.$progressValuePercentage, hours: self.$hoursI, minutes : self.$minI, seconds : tempo)
                                    .frame(width: 150, height: 150.0)
                                    .padding(.trailing)
                                Spacer()
                                    .frame(width: 50.0)
                                NavigationLink(destination: CheckView()){
                                    ZStack{
                                        Rectangle()
                                            .frame(width:111, height: 90, alignment: .center)
                                            .foregroundColor(Color(red: 252 / 255, green: 139 / 255, blue: 86 / 255))
                                            .cornerRadius(15)
                                            .overlay(
                                                VStack{
                                                    Image(systemName: "camera")
                                                        .foregroundColor(Color.white)
                                                    Text("CHECK")
                                                        .bold()
                                                        .foregroundColor(Color.white)
                                                }
                                                
                                        )
                                            .padding(.bottom, 30)
                                        
                                    }
                                    
                                }
                                
                            }
                    )
                    
                }
  
            }
            .frame(width: 13.0)
            
            //            v stack 3 livello
            VStack{
                
                Rectangle()
                    .frame(width: 300, height: 150)
                    .opacity(0)
                Rectangle()
                    .frame(width: 300, height: 150)
                    .foregroundColor(Color(red: 1.0, green: 0, blue: 1.0, opacity: 0))
                    .overlay(
                        
                        ZStack{
                            Image("Casella")
                                .resizable()
                                .frame(width: 300, height: 150)
                            VStack{
                                
                                Text("Effettua il tuo \(self.nRefresh) rinfresco")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(Color(red: 247 / 255, green: 124 / 255, blue: 66 / 255))
                                Text("Aggiungi altri \((Int(localQuantity) ?? 0) / 2) gr di acqua")
                                    .font(.system(size: 15, weight: .light))
                                Text("Aggiungi altri \(localQuantity) gr di farina")
                                    .font(.system(size: 15, weight: .light))
                                
                                Button(action : resetParameters){
                                    ZStack{
                                        Rectangle()
                                            .frame(width: 200, height: 30, alignment: .center)
                                            .foregroundColor(Color(red: 252 / 255, green: 139 / 255, blue: 86 / 255))
                                            .cornerRadius(25)
                                        
                                        Text("Restart timer")
                                            .foregroundColor(Color.white)
                                        
                                        
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            
                        }
                        
                        
                )
                    .opacity(isVisible ? 1 : 0)
                
            }
            
            
        }.navigationBarTitle("")
            .navigationBarHidden(true)
        
    }
    func resetParameters(){
        self.isVisible = false
        self.tempo = 172800.00
        self.imageCounter = 0
        self.nRefresh += 1
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(localQuantity: "0", localName: "nome", imageName: "maleAvatar0")
    }
}


struct ProgressBar: View {
    @Binding var progress: Double
    @Binding var hours : Int
    @Binding var minutes : Int
    var seconds : Double
    @State var angle = 0
    public let timerCL = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack{
            ZStack {
                Circle()
                    .stroke(lineWidth: 15.0)
                    .opacity(0.3)
                    .foregroundColor(Color.red)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.red)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear)
                
                
                Image("hourglass")
                    .resizable()
                    .frame(width:53, height: 77)
                    .rotationEffect(.degrees(Double(self.angle)))
                    .animation(.spring())
                    .onReceive(timerCL){_ in
                        if (Int(self.seconds) > 0 ){
                            self.angle += 10
                        }
                        else{
                            self.angle = 0
                        }
                        
                        
                }
                
            }
            Spacer()
                .frame(height: 13.0)
            HStack{
                
                Text("\(hours) H")
                    .font(.system(size: 15, weight: .bold))
                Text(":")
                Text("\(minutes) M")
                    .font(.system(size: 15, weight: .bold))
                Text(":")
                Text("\(Int(seconds) % 60) S")
                    .font(.system(size: 15, weight: .bold))
                
            }
        }
        
        
    }
}



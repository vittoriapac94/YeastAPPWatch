//
//  ContentView.swift
//  YeastIt
//
//  Created by utente on 06/07/2020.
//  Copyright © 2020 utente. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var provider = WatchConnectivityProvider()
    let textDimension : CGFloat = 40
    let imageDimension : CGFloat = 228
    let avatarImageDimension : CGFloat = 499
    @State var avatarImage : String = "maleAvatar0"
    @State var isMale : Bool = true
    @State var avatarName: String = ""
    @State var quantity: String = "0"
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .top){
                Image("Background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center){
                    Spacer()
                        .frame(width: 0.0, height: 50.0)
                    HStack(alignment: .center) {
                        Text("YEAST")
                            .font(.system(size: textDimension, weight: .bold))
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                        
                        Text("IT")
                            .font(.system(size: textDimension, weight: .light))
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 10)
                    
                    Text("Tap to change your avatar")
                        .font(.system(size: 18, weight: .light))
                    ZStack(alignment: .center){
                        Image("RettangoloAvatar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: imageDimension * 1.2 , height: imageDimension * 1.2 )
                       
                            
                        
                        
                        Image(avatarImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: avatarImageDimension / 2, height: avatarImageDimension / 2)
                            .onTapGesture {
                                if (self.isMale){
                                    self.isMale = false
                                    self.avatarImage = "femaleAvatar0"
                                }else{
                                    self.isMale = true
                                    self.avatarImage = "maleAvatar0"
                                }
                               
                        }
                            
                    }.aspectRatio(contentMode: .fit)
                        .padding()
                    
                    VStack(alignment: .center){
                        VStack{
                            Text("Scegli un nome per il tuo avatar")
                            TextField("Nome Avatar...",text: $avatarName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: textDimension / 2, weight: .light))
                            .frame(width: avatarImageDimension / 2)
                        }.padding()
                        
                        
                        VStack{
                            Text("Quantità di Lievito (gr)")
                            TextField("Quantità...",text: $quantity)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: avatarImageDimension / 2)
                                .font(.system(size: textDimension / 2, weight: .light))
                                .cornerRadius(10)
                                .keyboardType(.numberPad)
                                                  
                        }
                  
                        
                        
                        ZStack{
                            Image(uiImage: #imageLiteral(resourceName: "Casella Testo"))
                                .resizable()
                                .frame( height: 100)
                                .padding()
                            VStack(alignment: .center){
                                Text("Ti servono")
                                    .font(.system(size: 23, weight: .bold))
                                    .foregroundColor(Color(red: 247 / 255, green: 124 / 255, blue: 66 / 255))
                                Text("\(quantity) gr di farina")
                                    .font(.system(size: 15, weight: .light))
                                Text("\((Int(quantity) ?? 0) / 2) gr di acqua")
                                    .font(.system(size: 15, weight: .light))
                            }
                        }
                        
                        NavigationLink(destination: TimerView(localQuantity: quantity, localName: avatarName, imageName: avatarImage)){
                            ZStack{
                                Rectangle()
                                    .frame(width: 299, height: 60, alignment: .center)
                                    .foregroundColor(Color(red: 237 / 255, green: 145 / 255, blue: 97 / 255))
                                    .cornerRadius(25)
                                   
                                Text("INIZIA A LIEVITARE")
                                    .foregroundColor(Color.white)
                                .bold()
                                    
                            }
                            }.disabled(self.avatarName == ""
                                && Int(self.quantity) == 0
                                && self.quantity == "")
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    }
                    
                }
            }
        
        }.gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
            .onAppear(perform: {
            self.provider.connect()
                self.provider.sendTime(time: 23.00)
            
        })
 
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



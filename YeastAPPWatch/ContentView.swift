//
//  ContentView.swift
//  YeastIt
//
//  Created by utente on 06/07/2020.
//  Copyright © 2020 utente. All rights reserved.
//

import SwiftUI

struct ContentView: View {
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
                            Text("Choose a name for your avatar")
                            TextField("Avatar name",text: $avatarName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: textDimension / 2, weight: .light))
                            .frame(width: avatarImageDimension / 2)
                        }.padding()
                        
                        
                        VStack{
                            Text("Yeast quantity (gr)")
                            TextField("Quantity",text: $quantity)
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
                                Text("You need")
                                    .font(.system(size: 23, weight: .bold))
                                    .foregroundColor(Color(red: 247 / 255, green: 124 / 255, blue: 66 / 255))
                                Text("\(quantity) gr of flour")
                                    .font(.system(size: 15, weight: .light))
                                Text("\((Int(quantity) ?? 0) / 2) gr of water")
                                    .font(.system(size: 15, weight: .light))
                            }
                        }
                        
                        NavigationLink(destination: TimerView(localQuantity: quantity, localName: avatarName, imageName: avatarImage)){
                            ZStack{
                                Rectangle()
                                    .frame(width: 299, height: 60, alignment: .center)
                                    .foregroundColor(Color(red: 237 / 255, green: 145 / 255, blue: 97 / 255))
                                    .cornerRadius(25)
                                   
                                Text("START LEAVENING")
                                    .foregroundColor(Color.white)
                                .bold()
                                    
                            }
                            }.disabled(self.avatarName == ""
                                || Int(self.quantity) == 0
                                || self.quantity == "")
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    }
                    
                }
            }
        
        }.gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})

 
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



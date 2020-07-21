//
//  ContentView.swift
//  SimpleImageClassifier
//
//  Created by Michele Di Capua on 04/06/2020.
//  Copyright © 2020 iOS Foundation. All rights reserved.
//

import SwiftUI

struct CheckView: View {
    
    @State var image: Image? = Image(systemName: "camera.circle.fill")
    @State var showCaptureImageView: Bool = false
    @State var uiimage: UIImage? = nil
    @State var label: String = "......"
    
    //    prova
    @Environment(\.presentationMode) var presentationMode
    
    let model = LievitoMadreClassifier()
    
    var body: some View {
        ZStack
            {
                Image("Background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack
                    {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                            
                        }){
                            HStack{
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 20, weight: .light))
                                    .foregroundColor(Color.black)
                                Text("Back")
                                    .font(.system(size: 20, weight: .light))
                                    .foregroundColor(Color.black)
                                Rectangle()
                                    .opacity(0)
                                
                            }.frame(width: 350, height: 25)
                        }
                        Rectangle()
                            .frame(height: 95)
                            .opacity(0)
                        Rectangle()
                            .opacity(0)
                            .overlay(
                                VStack{
                                    Button(action:
                                        {
                                            self.label = ""//reset label
                                            self.showCaptureImageView.toggle()
                                    })
                                    {
                                        ZStack{
                                            Rectangle()
                                                .frame(width: 299, height: 60, alignment: .center)
                                                .foregroundColor(Color.white)
                                                .cornerRadius(25)
                                                .shadow(color: Color(red: 0.2,green: 0.2, blue: 0.2), radius: 8, x: 3, y: 5)
                                            
                                            
                                            Text("Take a photo")
                                                .foregroundColor(Color(red: 252 / 255, green: 139 / 255, blue: 86 / 255))
                                                .bold()
                                                .font(.title)
                                        }
                                    }
                                    Spacer()
                                        .frame(height: 100)
                                    image?.resizable()
                                        .frame(width: 250, height: 250)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                        .shadow(radius: 12)
                                    Button(action: { self.classify() }) {
                                        ZStack{
                                            Rectangle()
                                                .frame(width: 150, height: 40, alignment: .center)
                                                .foregroundColor(Color.white)
                                                .cornerRadius(25)
                                                .shadow(color: Color(red: 0.2,green: 0.2, blue: 0.2), radius: 8, x: 3, y: 5)
                                            Text("CHECK")
                                                .font(.system(size: 20, weight : .bold))
                                                .foregroundColor(Color(red: 252 / 255, green: 139 / 255, blue: 86 / 255))
                                        }
                                    }
                                    Spacer()
                                        .frame(height: 75)
                                    ZStack{
                                        Image("Casella")
                                            .resizable()
                                            .frame(width: 300, height: 130)
                                        VStack{
                                            Text("Your yeast is : ")
                                                .font(.system(size: 18, weight: .bold))
                                                .foregroundColor(Color(red: 247 / 255, green: 124 / 255, blue: 66 / 255))
                                            Text("\(label)")
                                                .padding()
                                                .font(.system(size : 34, weight : .light))
                                                .frame(alignment: .leading)
                                        }
                                    }
                                }
                        )
                }
                
                //toggle view Image Picker in the ZStack
                if (showCaptureImageView)
                {
                    CaptureImageView(isShown: $showCaptureImageView, image: $image, uiimage:$uiimage)
                }
                
        }.navigationBarTitle("")
            .navigationBarHidden(true)//ZStack
    }
    
    struct CheckView_Previews: PreviewProvider
    {
        static var previews: some View
        {
            CheckView()
        }
    }
    
    
    /**
     * Funzione di classificazione / inferenza
     */
    func classify()
    {
        if uiimage != nil
        {
            let pixelBuffer = convert(uiimage: uiimage!)
            
            // CORE ML code
            // try to predict the content of the image using the model
            guard let prediction = try? model.prediction(image: pixelBuffer!)
                else
            {
                return
            }
            label = "\(prediction.classLabel)"
            print(prediction.classLabel)
            
        }
        else
        {
            label = "Please take a photo..."
        }
    }
    
    /**
     * Convert a UIImage in 299 x 299 RGB
     */
    func convert(uiimage:UIImage) -> CVPixelBuffer?
    {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 299, height: 299), true, 2.0)
        
        uiimage.draw(in: CGRect(x: 0, y: 0, width: 299, height: 299))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        //Converting the image to a CVPixelBuffer, an image buffer which holds the pixels in the main memory
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        
        var pixelBuffer : CVPixelBuffer?
        
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        
        guard (status == kCVReturnSuccess) else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        
        //We then take all the pixels present in the image and convert them into a device-dependent RGB color space
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        
        let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) //3
        
        context?.translateBy(x: 0, y: newImage.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        //we make the graphics context into the current context, and render the image
        UIGraphicsPushContext(context!)
        
        newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
        
        UIGraphicsPopContext()
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
}

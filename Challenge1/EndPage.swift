//
//  EndPage.swift
//  Challenge1
//
//  Created by Ghada Alshabanat on 28/03/1446 AH.
//

import SwiftUI

struct EndPage: View {
    var body: some View {
        ZStack {
            Image("EndPage")
                .resizable()
                .aspectRatio(contentMode: .fill)
            Text ("انظر الى مأنجزته خلال فترة التركيز!")
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top,-250)
                .foregroundColor(Color("line1HomePage"))
                .font(Font.custom("SF Arabic Rounded", size: 36))
                .padding()

            Text ("استمتع بكل لحظة من إنجازاتك \nوتذكر دائماً أن كل خطوة تقربك من تحقيق أحلامك،\n استمر في العمل بجد وستصل إلى ماتريد")
                .fontWeight(.bold)
                //.bold()
               
                .multilineTextAlignment(.center)
                //.bold()
                .padding(.top,-100)
            .foregroundColor(Color("line1HomePage"))
            .font(Font.custom("SF Arabic Rounded", size: 24))
            .padding()
            
            //button
            Spacer()
            HStack{   Button(action: {
                // Handle previous action
            }) {
                Text("إعادة الجولة")
                    .font(.system(size: 18))
                    .foregroundColor(Color("backgroundLight"))
                    .padding()
                    .frame(width:120,height:50)
                    .background(Color("buttonsColor"))
                    .cornerRadius(25)
                    .shadow(radius: 5)
                    .offset(x: -60, y: 300)
            }
                
                Button(action: {
                    // Handle next action
                }) {
                    Text("إنهاء")
                        .font(.system(size: 18))
                        .foregroundColor(Color("backgroundLight"))
                        .padding()
                        .frame(width:120,height:50)
                        .background(Color("buttonsColor"))
                        .cornerRadius(25)
                        .shadow(radius: 5)
                        .offset(x: 60, y: 300)
                }
                
                
            }
             
            
            
            
            
            
        }.ignoresSafeArea()
        
            

}
}



#Preview {
EndPage()
}

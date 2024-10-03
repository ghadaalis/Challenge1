//
//  ContentView.swift
//  Challenge1
//
//  Created by Ghada Alshabanat on 28/03/1446 AH.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        ZStack {
            Image("HomePage")
                .resizable()
                .aspectRatio(contentMode: .fill)
            Text("أهلاً بك في")
                .bold()
                .padding(.top,-300)
                .foregroundColor(Color("line1HomePage"))
                .font(Font.custom("SF Arabic Rounded", size: 20))
            
            //
            Spacer()
            HStack{
                Text("مستعد\n لأول\nتمرة؟")
                    .bold()
                    .foregroundColor(Color("line2Homepage"))
                    .font(Font.custom("SF Arabic Rounded", size: 50))
                    .multilineTextAlignment(.center)
                    .offset(x:-100,y:100)
                
            }
            HStack{   Button(action: {
                // Handle previous action
            }) {
                Text("ابدأ")
                    .font(.system(size: 18))
                    .foregroundColor(Color("backgroundLight"))
                    .padding()
                    .frame(width:120,height:50)
                    .background((Color("buttonsColor")))
                    .cornerRadius(25)
                    .shadow(radius: 5)
            }}
            
            .offset(x: -100, y: 250)        } .ignoresSafeArea()
    
     //ghada
    }
}

#Preview {
    HomePage()
}

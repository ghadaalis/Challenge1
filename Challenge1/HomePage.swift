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
                .padding(.top,-300)
                .foregroundColor(Color("line1HomePage"))
                .font(Font.custom("SF Arabic Rounded", size: 20))
            //
           
            Button(action: {
                                // Handle previous action
                            }) {
                                Text("ابدا")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width:120,height:50)
                                    .background(Color.brown)
                                    .cornerRadius(25)
                                    .shadow(radius: 5)
                            }
        } .ignoresSafeArea()
        
     //ghada
    }
}

#Preview {
    HomePage()
}

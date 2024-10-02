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
                
        } .ignoresSafeArea()
     //ghada
    }
}

#Preview {
    HomePage()
}

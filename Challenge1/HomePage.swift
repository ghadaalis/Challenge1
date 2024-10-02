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
              //  .font(custom("YourCustomFontName", size: 18))
                
        } .ignoresSafeArea()
     //ghada
    }
}

#Preview {
    HomePage()
}

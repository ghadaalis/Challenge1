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
                .font(.system(size:25))
                .bold()
                .padding()
               

        }.ignoresSafeArea()
            
    }
}

#Preview {
    EndPage()
}

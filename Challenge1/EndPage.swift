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
                .multilineTextAlignment(.center)
                .padding(.top,-200)
                .foregroundColor(Color("line1HomePage"))
                .font(Font.custom("SF Arabic Rounded", size: 36))
                .padding()

            Text ("استمتع بكل لحظة من إنجازاتك \nوتذكر دائماً أن كل خطوة تقربك من تحقيق أحلامك،\n استمر في العمل بجد وستصل إلى ماتريد")
                .bold()
                .multilineTextAlignment(.center)
                .padding(.top,0)
            .foregroundColor(Color("line1HomePage"))
            .font(Font.custom("SF Arabic Rounded", size: 24))
            .padding()
            
        }.ignoresSafeArea()
            

}
}



#Preview {
EndPage()
}

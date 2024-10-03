//
//  BreakTime.swift
//  Challenge1
//
//  Created by Ghada Alshabanat on 28/03/1446 AH.
//

import SwiftUI

struct BreakSelectionView: View {
    @State private var selectedHour = 0
    @State private var selectedMinute = 0
    @State private var selectedSecond = 0

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    //  go back
                }) {
                   //HStack 2
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("الصفحة الرئيسية")
                    }
                    .foregroundColor(Color("buttonsColor"))
                    
                }
                Spacer()
            }

            .padding()

            Spacer()

            // Title for the time selection
            Text("حدد وقت استراحتك بين الجلسات")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color("line1HomePage"))
                .padding()

            // Custom Picker
            HStack(spacing: 20) {
                // Hours Picker
                Picker("Hours", selection: $selectedHour) {
                    ForEach(0..<24, id: \.self) { hour in
                        Text("\(hour) hours").tag(hour)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100, height: 100)

                // Minutes Picker
                Picker("Minutes", selection: $selectedMinute) {
                    ForEach(0..<60, id: \.self) { minute in
                        Text("\(minute) min").tag(minute)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100, height: 100)

                // Seconds Picker
                Picker("Seconds", selection: $selectedSecond) {
                    ForEach(0..<60, id: \.self) { second in
                        Text("\(second) sec").tag(second)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100, height: 100)
            }

            Spacer()

            HStack {
                Button(action: {
                    // Handle previous action
                }) {
                    Text("السابق")
                        .font(.system(size: 18))
                        .foregroundColor(Color("backgroundLight"))
                        .padding()
                        .frame(width:120,height:50)
                        .background(Color("buttonsColor"))
                        .cornerRadius(25)
                        .shadow(radius: 5)
                }
                Spacer()
                Button(action: {
                    // Handle next action
                }) {
                    Text("ابدأ")
                        .font(.system(size: 18))
                        .foregroundColor(Color("backgroundLight"))
                        .padding()
                        .frame(width:120,height:50)
                        .background(Color("buttonsColor"))
                        .cornerRadius(25)
                        .shadow(radius: 5)
                }
                }
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 40)
        .padding(.bottom, 60)
        .padding(.top, 60)
        
        //بحذفه لما غاده تعطيني اللون
        .background(Color("backgroundLight").edgesIgnoringSafeArea(.all))
        
        .navigationBarHidden(true) // Hide the navigation bar
    }
}

struct BreakSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        BreakSelectionView()
    }
}

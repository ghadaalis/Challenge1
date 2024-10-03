//
//  SettingFocusTime.swift
//  Challenge1
//
//  Created by Ghada Alshabanat on 28/03/1446 AH.
//

import SwiftUI

struct TimeSelectionView: View {
    @State private var selectedHour = 0
    @State private var selectedMinute = 0
    @State private var selectedSecond = 0

    var body: some View {
        VStack {
            // Back button and title at the top
            //HStack 1
            HStack {
                Button(action: {
                    //  go back
                }) {
                   //HStack 2
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("الصفحة الرئيسية")
                    }
                    .foregroundColor(Color(red: 163/255, green: 105/255, blue: 55/255)) // Brown text color
                }
                Spacer()
            }
            .padding()

            Spacer()

            // Title for the time selection
            Text("حدد وقت التركيز لإتمام مهمتك")
                .font(.title3)
                .foregroundColor(Color(red: 163/255, green: 105/255, blue: 55/255)) // Brown text color
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
                    Text("الغاء")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .padding()
                        .frame(width:120,height:50)
                        .background(Color.brown)
                        .cornerRadius(25)
                        .shadow(radius: 5)
                }
                Spacer()
                Button(action: {
                    // Handle next action
                }) {
                    Text("التالي")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .padding()
                        .frame(width:120,height:50)
                        .background(Color.brown)
                        .cornerRadius(25)
                        .shadow(radius: 5)
                }
                }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 30)
        
        //بحذفه لما غاده تعطيني اللون
        .background(Color(red: 255/255, green: 243/255, blue: 233/255).edgesIgnoringSafeArea(.all))
        
        .navigationBarHidden(true) // Hide the navigation bar
    }
}

struct TimeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSelectionView()
    }
}

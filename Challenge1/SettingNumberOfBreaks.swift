//
//  NumberOfBreaks.swift
//  Challenge1
//
//  Created by Ghada Alshabanat on 28/03/1446 AH.
//
import SwiftUI

struct ContentView: View {
   @State private var selectedNumber: Int = 1
    var body: some View {
        VStack {
            // Back button + title
            HStack {
                Button(action: {
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("الصفحة الرئيسية")
                    }
                    .foregroundColor(Color(red: 163/255, green: 105/255, blue: 55/255)) // text color
                }
                Spacer()
            }
            .padding()

            Spacer()
            Text("حدد عدد الإستراحات التي تحتاجها")
                .font(.system(size: 20))
                .foregroundColor(Color(red: 163/255, green: 105/255, blue: 55/255))
                .padding(.top,20)
            
            Spacer()
            
            Picker(selection: $selectedNumber, label: Text("")) {
                ForEach(0..<101) { number in
                    Text("\(number)")
                        .tag(number)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 150)
            
            Spacer()
            
            HStack {
                Button(action: {
                    // Handle previous action
                }) {
                    Text("السابق")
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
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
            
            
        }
        //بعدله لما غاده تعطينياسم اللون
        .background(Color(red: 255/255, green: 243/255, blue: 233/255).edgesIgnoringSafeArea(.all))
        
        .navigationBarHidden(true)    }
}
   
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

import SwiftUI

// TimeSelectionView
struct ContentView1: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedHour = 0
    @State private var selectedMinute = 0
    @State private var selectedSecond = 0
    
    var body: some View {
        NavigationView {
            VStack {
                // Back button and title at the top
                Spacer()
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                dismiss()  // Dismiss the view to go back
                            }, label: {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color("buttonsColor"))
                                Text("الصفحة الرئيسية")
                                    .foregroundColor(Color("buttonsColor"))
                            })
                        }
                    }
                
                // Title for the time selection
                Text("حدد وقت التركيز لإتمام مهمتك")
                    .font(.title3)
                    .foregroundColor(Color("line1HomePage")) // Brown text color
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
                .navigationBarBackButtonHidden(true)
                
                Spacer()
                
                // Buttons with Navigation Links
                HStack {
                    // Cancel button with NavigationLink to HomePage
                    Button(action: {
                        // Handle cancel action if needed
                    }) {
                        NavigationLink(destination: HomePage()) {
                            Text("الغاء")
                                .font(.system(size: 18))
                                .foregroundColor(Color("backgroundLight"))
                                .padding()
                                .frame(width: 120, height: 50)
                                .background(Color("buttonsColor"))
                                .cornerRadius(25)
                                .shadow(radius: 5)
                        }
                    }
                    
                    Spacer()
                    
                    // Next button with NavigationLink to ContentView2
                    Button(action: {
                        // Handle next action if needed
                    }) {
                        NavigationLink(destination: ContentView2()) {
                            Text("التالي")
                                .font(.system(size: 18))
                                .foregroundColor(Color("backgroundLight"))
                                .padding()
                                .frame(width: 120, height: 50)
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
            }
            .background(Color("backgroundLight").edgesIgnoringSafeArea(.all))
        }.navigationBarBackButtonHidden(true)
    }
        
       
    }


struct ContentView1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}



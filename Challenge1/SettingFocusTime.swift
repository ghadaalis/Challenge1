import SwiftUI

// TimeSelectionView
struct ContentView1: View {
    @Binding var showSheet: Bool
    @Environment(\.dismiss) private var dismiss
    @State  var selectedHour: Int
    @State var selectedMinute:Int
    @State  var selectedSecond: Int
    @State  var selectedNumber: Int
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("حدد وقت التركيز لإتمام مهمتك")
                    .font(.title3)
                    .foregroundColor(Color("line1HomePage"))
                    .padding()
                HStack(spacing: 20) {
                    Picker("Hours", selection: $selectedHour) {
                        ForEach(0..<24, id: \.self) { hour in
                            Text("\(hour) hours").tag(hour)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100, height: 100)
                    Picker("Minutes", selection: $selectedMinute) {
                        ForEach(0..<60, id: \.self) { minute in
                            Text("\(minute) min").tag(minute)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100, height: 100)
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
                    Spacer()
                    NavigationLink(destination: ContentView2(showSheet: $showSheet, selectedNumber: $selectedNumber, selectedHour: $selectedHour, selectedMinute: $selectedMinute, selectedSecond: $selectedSecond) ){
                        Text("التالي")
                            .font(.system(size: 18))
                            .foregroundColor(Color("backgroundLight"))
                            .padding()
                            .frame(width: 120, height: 50)
                            .background(Color("buttonsColor"))
                            .cornerRadius(25)
                            .shadow(radius: 5)
                    }
                    Spacer()
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 60)

                //.padding(.top, 60)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSheet = false
                    }) {
                        Text("إلغاء")
                            .foregroundColor(Color("buttonsColor"))
                            .padding()
                    }
                }
            }
            .background(Color("backgroundLight").edgesIgnoringSafeArea(.all))
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Preview for ContentView1
struct ContentView1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1(showSheet: .constant(false), selectedHour: 0, selectedMinute: 0, selectedSecond: 0, selectedNumber: 25)
    }
}


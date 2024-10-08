import SwiftUI
// TimeSelectionView
struct ContentView3: View {
    @Environment(\.dismiss) private var dismiss
    @State  var showSheet: Bool
    @State  var selectedHourB: Int = 0
    @State  var selectedMinuteB :Int = 0
    @State  var selectedSecondB: Int = 0
    @Binding  var selectedHour: Int
    @Binding  var selectedMinute :Int
    @Binding  var selectedSecond: Int
    @Binding var selectedNumber: Int

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("حدد مدة الاستراحة بين الجلسات")
                    .font(.title3)
                    .foregroundColor(Color("line1HomePage")) // Brown text color
                    .padding()
                HStack(spacing: 20) {
                    Picker("Hours", selection: $selectedHourB) {
                        ForEach(0..<24, id: \.self) { hour in
                            Text("\(hour) hours").tag(hour)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100, height: 100)
                    Picker("Minutes", selection: $selectedMinuteB) {
                        ForEach(0..<60, id: \.self) { minute in
                            Text("\(minute) min").tag(minute)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100, height: 100)
                    Picker("Seconds", selection: $selectedSecondB) {
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
                    Button(action: {
                    }) {
                        NavigationLink(destination: TimerView(selectedHour: $selectedHour, selectedMinute: $selectedMinute, selectedSecond: $selectedMinute, selectedHourB: $selectedHourB, selectedMinuteB: $selectedMinuteB, selectedSecondB: $selectedSecondB, numberOfBreaks: $selectedNumber)) {
                            
                            Text("ابدأ")
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
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 60)
               // .padding(.top, 60)
            }
            .background(Color("backgroundLight").edgesIgnoringSafeArea(.all))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("عودة")
                        }
                        .foregroundColor(Color("buttonsColor"))
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSheet = false
                    }) {
                        Text("إلغاء")
                            .foregroundColor(Color("buttonsColor"))
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//struct ContentView3_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView3(showSheet: .constant(false))
//    }
//}

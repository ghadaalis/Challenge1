import SwiftUI
// TimeSelectionView
struct ContentView3: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showSheet: Bool
    @State private var selectedHour = 0
    @State private var selectedMinute = 0
    @State private var selectedSecond = 0

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("حدد مدة الاستراحة بين الجلسات")
                    .font(.title3)
                    .foregroundColor(Color("line1HomePage")) // Brown text color
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
                    Button(action: {
                    }) {
                        NavigationLink(destination: TimerView()) {
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

struct ContentView3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView3(showSheet: .constant(false))
    }
}

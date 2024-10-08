import SwiftUI



struct ContentView2: View {
    @Binding var showSheet: Bool
    @State private var isNavigating: Bool = false
    @Environment(\.dismiss) private var dismiss
    @Binding  var selectedNumber: Int
    @Binding   var selectedHour:Int
    @Binding   var selectedMinute: Int
    @Binding   var selectedSecond: Int
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("حدد عدد الإستراحات التي تحتاجها")
                    .font(.system(size: 20))
                    .foregroundColor(Color("line1HomePage"))
                    .padding(.top, 20)
                
                Spacer()
                Picker(selection: $selectedNumber, label: Text("")) {
                    ForEach(0..<6) { number in
                        Text("\(number)")
                            .tag(number)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 150)
                
                Spacer()
                
                HStack {
                    Spacer()
                    NavigationLink(destination: ContentView3( showSheet: showSheet, selectedHour: $selectedHour, selectedMinute: $selectedMinute, selectedSecond: $selectedSecond, selectedNumber: $selectedNumber))
                    
                    {
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
               // .padding(.top, 60)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss() // Navigates back to the previous view
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
                            .padding()
                    }
                }
            }
            .background(Color("backgroundLight").edgesIgnoringSafeArea(.all))
        }
        .navigationBarBackButtonHidden(true)
    }
}

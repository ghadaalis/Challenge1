import SwiftUI

struct TimerView: View {
    @State private var timeRemaining = 25 * 60 // 25 minutes in seconds
    @State private var timerRunning = false
    @State private var paused = false
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            // Set the background image
            Image("FocusTime")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all) // Ensures it covers the whole screen

            VStack {
                // Header for returning back to main page
                HStack {
                    Button(action: {
                        // action for going back to the main page
                    }) {
                        
                      
                            Text("الصفحة الرئيسية")
                            .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0))) // adjust color
                    }
                    Spacer()
                }
                .padding()

                Spacer()
                Spacer()
                // Circular Timer
                ZStack {
                    Circle()
                    
                        .frame(width: 250.0, height: 250.0)
                        .foregroundColor(Color("backgroundLight"))
                     
                    Circle()
                        
                        .stroke(lineWidth: 10)
                        .opacity(0.3)
                        .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
                     
                       
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(Double(timeRemaining) / (25 * 60), 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear)
                   
                    
                    Text(formatTime(seconds: timeRemaining))
                        .font(.largeTitle)
                        .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
                }
                .frame(width: 200, height: 200)
                
                
               
                // Instruction text
                Spacer()
                Text("ركز لمدة ٢٥ دقيقة")
                    .fontWeight(.bold)
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
                  
                    
                   
                
                Spacer()

                // Control Buttons
                HStack {
                    // Restart button
                    Button(action: {
                        resetTimer()
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("backgroundLight"))
                            .padding()
                            .background{Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0))
                            .clipShape(Circle())
                            }
                    }
                   
                    Spacer()
                    
                    // Pause/Play button
                    Button(action: {
                        if paused {
                            startTimer()
                        } else {
                            pauseTimer()
                        }
                    }) {
                        Image(systemName: paused ? "play.fill" : "pause.fill")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("backgroundLight"))
                           // .padding()
                            .frame(width: 60, height: 50)
                            .padding()
                            .background{Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0))
                            .clipShape(Circle())
                         
                                
                            }
                         
                            
                    }
                    
                    Spacer()
                    
                    // Stop button
                    Button(action: {
                        stopTimer()
                    }) {
                        Image(systemName: "stop.fill")
                        
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("backgroundLight"))
                            .padding()
                            .background{Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0))
                            .clipShape(Circle())
                            }
                    }
                  
                }
                .padding(.all, 100.0)
            }
            .padding()
            .onAppear {
                startTimer()
            }
        }
    }

    // Timer-related functions
    func startTimer() {
        timerRunning = true
        paused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
    }

    func pauseTimer() {
        paused = true
        timer?.invalidate()
    }

    func resetTimer() {
        timeRemaining = 25 * 60
        startTimer()
    }

    func stopTimer() {
        timer?.invalidate()
        timerRunning = false
        timeRemaining = 25 * 60
    }

    // Helper to format time in mm:ss
    func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}






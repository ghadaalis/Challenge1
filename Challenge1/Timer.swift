//
//
//import SwiftUI
//import AVFoundation
//
//struct TimerView: View {
//    @Binding var selectedHour: Int
//    @Binding var selectedMinute: Int
//    @Binding var selectedSecond: Int
//    
//    @Binding var selectedHourB: Int
//    @Binding var selectedMinuteB: Int
//    @Binding var selectedSecondB: Int
//    
//    @Binding var numberOfBreaks: Int
//    
//    @State private var focusTimePerCycle: Int = 0
//    @State private var timeRemaining: Int = 0
//    @State private var breakTimeRemaining: Int = 0
//    @State private var timerRunning = false
//    @State private var paused = false
//    @State private var isBreak = false
//    @State private var currentCycle = 0
//    @State private var timer: Timer?
//    @State private var audioPlayer: AVAudioPlayer?
//    
//    var body: some View {
//        ZStack {
//            // Set the background image
//            Image("FocusTime")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                // Header for returning back to main page
//                HStack {
//                    Button(action: {
//                        // Action for going back to the main page
//                    }) {
//                        
//                    }
//                    Spacer()
//                }
//                .padding(.horizontal, 40)
//                
//                Spacer()
//                
//                // Main Timer Display
//                timerDisplay(timeRemaining: isBreak ? breakTimeRemaining : timeRemaining)
//                
//                Spacer()
//                Text(isBreak ? "استراحة" : "ركز لمدة \(selectedHour) ساعة, \(selectedMinute) دقيقة")
//                .fontWeight(.bold)
//                .bold()
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                
//                Spacer()
//                
//                // Control Buttons
//                HStack {
//                    // Restart button
//                    Button(action: {
//                        resetTimer()
//                    }) {
//                        Image(systemName: "arrow.counterclockwise")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                    
//                    Spacer()
//                    
//                    // Pause/Play button
//                    Button(action: {
//                        togglePause()
//                    }) {
//                        Image(systemName: paused ? "play.fill" : "pause.fill")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                }
//                .padding(.all, 100.0)
//            }
//            .onAppear {
//                resetTimer()
//            }
//        }
//    }
//    
//    // Timer-related functions
//    func startTimer() {
//        timerRunning = true
//        paused = false
//        isBreak = false
//        timeRemaining = focusTimePerCycle
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if timeRemaining > 0 {
//                timeRemaining -= 1
//            } else {
//                timer?.invalidate() // Stop the timer when time is up
//                playBellSound() // Play ring bell sound
//                if currentCycle < numberOfBreaks {
//                    currentCycle += 1
//                    startBreakTimer() // Start break timer automatically
//                } else {
//                    timerRunning = false
//                    currentCycle = 0 // Reset the cycle after all focusing and break timers are complete
//                }
//            }
//        }
//    }
//    
//    func startBreakTimer() {
//        isBreak = true
//        timerRunning = true
//        paused = false
//        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if breakTimeRemaining > 0 {
//                breakTimeRemaining -= 1
//            } else {
//                timer?.invalidate() // Stop the break timer when time is up
//                playBellSound() // Play ring bell sound
//                if currentCycle < numberOfBreaks {
//                    startTimer() // Restart the main timer
//                } else {
//                    timerRunning = false // Stop the cycle after all breaks
//                    currentCycle = 0
//                }
//            }
//        }
//    }
//    
//    func togglePause() {
//        if paused {
//            if isBreak {
//                startBreakTimer() // Resume break timer
//            } else {
//                startTimer() // Resume main timer
//            }
//        } else {
//            paused = true
//            timer?.invalidate() // Pause the timer
//        }
//    }
//    
//    func resetTimer() {
//        timer?.invalidate() // Stop any running timer
//        let totalFocusTime = (selectedHour * 3600) + (selectedMinute * 60) + selectedSecond
//        focusTimePerCycle = totalFocusTime / max(1, numberOfBreaks) // Divide focus time by number of breaks
//        timeRemaining = focusTimePerCycle
//        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//        isBreak = false
//        paused = false
//        currentCycle = 0
//        if totalFocusTime > 0 {
//            startTimer() // Start the main timer
//        }
//    }
//    
//    // Play bell sound when the timer finishes
//    func playBellSound() {
//        guard let url = Bundle.main.url(forResource: "bell", withExtension: "mp3") else {
//            print("Bell sound file not found.")
//            return
//        }
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.prepareToPlay()
//            audioPlayer?.play()
//        } catch {
//            print("Error playing sound: \(error.localizedDescription)")
//        }
//    }
//    
//    // Helper to format time in mm:ss
//    func formatTime(seconds: Int) -> String {
//        let minutes = seconds / 60
//        let seconds = seconds % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//    
//    @ViewBuilder
//    private func timerDisplay(timeRemaining: Int) -> some View {
//        ZStack {
//            Circle()
//                .frame(width: 250.0, height: 250.0)
//                .foregroundColor(Color("backgroundLight"))
//            
//            Circle()
//                .stroke(lineWidth: 10)
//                .opacity(0.3)
//                .foregroundColor(Color("buttonsColor"))
//            
//            let totalTime = isBreak ? ((selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB) : focusTimePerCycle
//            
//            Circle()
//                .trim(from: 0.0, to: CGFloat(Double(totalTime - timeRemaining) / Double(totalTime)))
//                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                .rotationEffect(Angle(degrees: -90.0)) // Rotate to start from 12 o'clock position
//                .animation(.linear, value: timeRemaining)
//            
//            Text(formatTime(seconds: timeRemaining))
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//        }
//        .frame(width: 200, height: 200)
//    }
//}



//
//import SwiftUI
//import AVFoundation
//
//struct TimerView: View {
//    @Binding var selectedHour: Int
//    @Binding var selectedMinute: Int
//    @Binding var selectedSecond: Int
//    
//    @Binding var selectedHourB: Int
//    @Binding var selectedMinuteB: Int
//    @Binding var selectedSecondB: Int
//    
//    @Binding var numberOfBreaks: Int
//    
//    @State private var focusTimePerCycle: Int = 0
//    @State private var timeRemaining: Int = 0
//    @State private var breakTimeRemaining: Int = 0
//    @State private var timerRunning = false
//    @State private var paused = false
//    @State private var isBreak = false
//    @State private var currentCycle = 0
//    @State private var timer: Timer?
//    @State private var audioPlayer: AVAudioPlayer?
//    
//    var body: some View {
//        ZStack {
//            // Set the background image
//            Image("FocusTime")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                // Header for returning back to main page
//                HStack {
//                    Button(action: {
//                        // Action for going back to the main page
//                    }) {
//                        
//                    }
//                    Spacer()
//                }
//                .padding(.horizontal, 40)
//                
//                Spacer()
//                
//                // Main Timer Display
//                timerDisplay(timeRemaining: isBreak ? breakTimeRemaining : timeRemaining)
//                
//                Spacer()
//                Text(isBreak ? "استراحة" : "ركز لمدة \(selectedHour) ساعة, \(selectedMinute) دقيقة")
//                .fontWeight(.bold)
//                .bold()
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                
//                Spacer()
//                
//                // Control Buttons
//                HStack {
//                    // Restart button
//                    Button(action: {
//                        resetTimer()
//                    }) {
//                        Image(systemName: "arrow.counterclockwise")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                    
//                    Spacer()
//                    
//                    // Pause/Play button
//                    Button(action: {
//                        togglePause()
//                    }) {
//                        Image(systemName: paused ? "play.fill" : "pause.fill")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                }
//                .padding(.all, 100.0)
//            }
//            .onAppear {
//                resetTimer()
//            }
//        }
//    }
//    
//    // Timer-related functions
//    func startTimer() {
//        timerRunning = true
//        paused = false
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if isBreak {
//                if breakTimeRemaining > 0 {
//                    breakTimeRemaining -= 1
//                } else {
//                    timer?.invalidate() // Stop the timer when time is up
//                    playBellSound() // Play ring bell sound
//                    if currentCycle < numberOfBreaks {
//                        currentCycle += 1
//                        startTimer() // Start the main timer automatically
//                    } else {
//                        timerRunning = false
//                        currentCycle = 0 // Reset the cycle after all focusing and break timers are complete
//                    }
//                }
//            } else {
//                if timeRemaining > 0 {
//                    timeRemaining -= 1
//                } else {
//                    timer?.invalidate() // Stop the timer when time is up
//                    playBellSound() // Play ring bell sound
//                    if currentCycle < numberOfBreaks {
//                        currentCycle += 1
//                        startBreakTimer() // Start break timer automatically
//                    } else {
//                        timerRunning = false
//                        currentCycle = 0 // Reset the cycle after all focusing and break timers are complete
//                    }
//                }
//            }
//        }
//    }
//    
//    func startBreakTimer() {
//        isBreak = true
//        timerRunning = true
//        paused = false
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if breakTimeRemaining > 0 {
//                breakTimeRemaining -= 1
//            } else {
//                timer?.invalidate() // Stop the break timer when time is up
//                playBellSound() // Play ring bell sound
//                if currentCycle < numberOfBreaks {
//                    startTimer() // Restart the main timer
//                } else {
//                    timerRunning = false // Stop the cycle after all breaks
//                    currentCycle = 0
//                }
//            }
//        }
//    }
//    
//    func togglePause() {
//        if paused {
//            paused = false
//            startTimer() // Resume timer
//        } else {
//            paused = true
//            timer?.invalidate() // Pause the timer
//        }
//    }
//    
//    func resetTimer() {
//        timer?.invalidate() // Stop any running timer
//        let totalFocusTime = (selectedHour * 3600) + (selectedMinute * 60) + selectedSecond
//        focusTimePerCycle = totalFocusTime / max(1, numberOfBreaks) // Divide focus time by number of breaks
//        timeRemaining = focusTimePerCycle
//        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//        isBreak = false
//        paused = false
//        currentCycle = 0
//    }
//    
//    // Play bell sound when the timer finishes
//    func playBellSound() {
//        guard let url = Bundle.main.url(forResource: "bell", withExtension: "mp3") else {
//            print("Bell sound file not found.")
//            return
//        }
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.prepareToPlay()
//            audioPlayer?.play()
//        } catch {
//            print("Error playing sound: \(error.localizedDescription)")
//        }
//    }
//    
//    // Helper to format time in mm:ss
//    func formatTime(seconds: Int) -> String {
//        let minutes = seconds / 60
//        let seconds = seconds % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//    
//    @ViewBuilder
//    private func timerDisplay(timeRemaining: Int) -> some View {
//        ZStack {
//            Circle()
//                .frame(width: 250.0, height: 250.0)
//                .foregroundColor(Color("backgroundLight"))
//            
//            Circle()
//                .stroke(lineWidth: 10)
//                .opacity(0.3)
//                .foregroundColor(Color("buttonsColor"))
//            
//            let totalTime = isBreak ? ((selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB) : focusTimePerCycle
//            
//            Circle()
//                .trim(from: 0.0, to: CGFloat(Double(totalTime - timeRemaining) / Double(totalTime)))
//                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                .rotationEffect(Angle(degrees: -90.0)) // Rotate to start from 12 o'clock position
//                .animation(.linear, value: timeRemaining)
//            
//            Text(formatTime(seconds: timeRemaining))
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//        }
//        .frame(width: 200, height: 200)
//    }
//}



//
//import SwiftUI
//import AVFoundation
//
//struct TimerView: View {
//    @Binding var selectedHour: Int
//    @Binding var selectedMinute: Int
//    @Binding var selectedSecond: Int
//    
//    @Binding var selectedHourB: Int
//    @Binding var selectedMinuteB: Int
//    @Binding var selectedSecondB: Int
//    
//    @Binding var numberOfBreaks: Int
//    
//    @State private var focusTimePerCycle: Int = 0
//    @State private var timeRemaining: Int = 0
//    @State private var breakTimeRemaining: Int = 0
//    @State private var timerRunning = false
//    @State private var paused = false
//    @State private var isBreak = false
//    @State private var currentCycle = 0
//    @State private var timer: Timer?
//    @State private var audioPlayer: AVAudioPlayer?
//    
//    var body: some View {
//        ZStack {
//            // Set the background image
//            Image("FocusTime")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                // Header for returning back to main page
//                HStack {
//                    Button(action: {
//                        // Action for going back to the main page
//                    }) {
//                        
//                    }
//                    Spacer()
//                }
//                .padding(.horizontal, 40)
//                
//                Spacer()
//                
//                // Main Timer Display
//                timerDisplay(timeRemaining: isBreak ? breakTimeRemaining : timeRemaining)
//                
//                Spacer()
//                Text(isBreak ? "استراحة" : "ركز لمدة \(selectedHour) ساعة, \(selectedMinute) دقيقة")
//                .fontWeight(.bold)
//                .bold()
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                
//                Spacer()
//                
//                // Control Buttons
//                HStack {
//                    // Restart button
//                    Button(action: {
//                        resetTimer()
//                    }) {
//                        Image(systemName: "arrow.counterclockwise")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                    
//                    Spacer()
//                    
//                    // Pause/Play button
//                    Button(action: {
//                        togglePause()
//                    }) {
//                        Image(systemName: paused ? "play.fill" : "pause.fill")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                }
//                .padding(.all, 100.0)
//            }
//            .onAppear {
//                resetTimer()
//                startTimer() // Automatically start the timer when the view appears
//            }
//        }
//    }
//    
//    // Timer-related functions
//    func startTimer() {
//        timerRunning = true
//        paused = false
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if isBreak {
//                if breakTimeRemaining > 0 {
//                    breakTimeRemaining -= 1
//                } else {
//                    timer?.invalidate() // Stop the timer when time is up
//                    playBellSound() // Play ring bell sound
//                    if currentCycle < numberOfBreaks {
//                        currentCycle += 1
//                        startTimer() // Start the main timer automatically
//                    } else {
//                        timerRunning = false
//                        currentCycle = 0 // Reset the cycle after all focusing and break timers are complete
//                    }
//                }
//            } else {
//                if timeRemaining > 0 {
//                    timeRemaining -= 1
//                } else {
//                    timer?.invalidate() // Stop the timer when time is up
//                    playBellSound() // Play ring bell sound
//                    if currentCycle < numberOfBreaks {
//                        currentCycle += 1
//                        startBreakTimer() // Start break timer automatically
//                    } else {
//                        timerRunning = false
//                        currentCycle = 0 // Reset the cycle after all focusing and break timers are complete
//                    }
//                }
//            }
//        }
//    }
//    
//    func startBreakTimer() {
//        isBreak = true
//        timerRunning = true
//        paused = false
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if breakTimeRemaining > 0 {
//                breakTimeRemaining -= 1
//            } else {
//                timer?.invalidate() // Stop the break timer when time is up
//                playBellSound() // Play ring bell sound
//                if currentCycle < numberOfBreaks {
//                    startTimer() // Restart the main timer
//                } else {
//                    timerRunning = false // Stop the cycle after all breaks
//                    currentCycle = 0
//                }
//            }
//        }
//    }
//    
//    func togglePause() {
//        if paused {
//            paused = false
//            startTimer() // Resume timer
//        } else {
//            paused = true
//            timer?.invalidate() // Pause the timer
//        }
//    }
//    
//    func resetTimer() {
//        timer?.invalidate() // Stop any running timer
//        let totalFocusTime = (selectedHour * 3600) + (selectedMinute * 60) + selectedSecond
//        focusTimePerCycle = totalFocusTime / max(1, numberOfBreaks) // Divide focus time by number of breaks
//        timeRemaining = focusTimePerCycle
//        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//        isBreak = false
//        paused = false
//        currentCycle = 0
//    }
//    
//    // Play bell sound when the timer finishes
//    func playBellSound() {
//        guard let url = Bundle.main.url(forResource: "bell", withExtension: "mp3") else {
//            print("Bell sound file not found.")
//            return
//        }
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.prepareToPlay()
//            audioPlayer?.play()
//        } catch {
//            print("Error playing sound: \(error.localizedDescription)")
//        }
//    }
//    
//    // Helper to format time in mm:ss
//    func formatTime(seconds: Int) -> String {
//        let minutes = seconds / 60
//        let seconds = seconds % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//    
//    @ViewBuilder
//    private func timerDisplay(timeRemaining: Int) -> some View {
//        ZStack {
//            Circle()
//                .frame(width: 250.0, height: 250.0)
//                .foregroundColor(Color("backgroundLight"))
//            
//            Circle()
//                .stroke(lineWidth: 10)
//                .opacity(0.3)
//                .foregroundColor(Color("buttonsColor"))
//            
//            let totalTime = isBreak ? ((selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB) : focusTimePerCycle
//            
//            Circle()
//                .trim(from: 0.0, to: CGFloat(Double(totalTime - timeRemaining) / Double(totalTime)))
//                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                .rotationEffect(Angle(degrees: -90.0)) // Rotate to start from 12 o'clock position
//                .animation(.linear, value: timeRemaining)
//            
//            Text(formatTime(seconds: timeRemaining))
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//        }
//        .frame(width: 200, height: 200)
//    }
//}



//
//import SwiftUI
//import AVFoundation
//
//struct TimerView: View {
//    @Binding var selectedHour: Int
//    @Binding var selectedMinute: Int
//    @Binding var selectedSecond: Int
//    
//    @Binding var selectedHourB: Int
//    @Binding var selectedMinuteB: Int
//    @Binding var selectedSecondB: Int
//    
//    @Binding var numberOfBreaks: Int
//    
//    @State private var focusTimePerCycle: Int = 0
//    @State private var timeRemaining: Int = 0
//    @State private var breakTimeRemaining: Int = 0
//    @State private var timerRunning = false
//    @State private var paused = false
//    @State private var isBreak = false
//    @State private var currentCycle = 0
//    @State private var timer: Timer?
//    @State private var audioPlayer: AVAudioPlayer?
//    
//    var body: some View {
//        ZStack {
//            // Set the background image
//            Image("FocusTime")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                // Header for returning back to main page
//                HStack {
//                    Button(action: {
//                        // Action for going back to the main page
//                    }) {
//                        
//                    }
//                    Spacer()
//                }
//                .padding(.horizontal, 40)
//                
//                Spacer()
//                
//                // Main Timer Display
//                timerDisplay(timeRemaining: isBreak ? breakTimeRemaining : timeRemaining)
//                
//                Spacer()
//                Text(isBreak ? "استراحة" : "ركز لمدة \(selectedHour) ساعة, \(selectedMinute) دقيقة")
//                .fontWeight(.bold)
//                .bold()
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                
//                Spacer()
//                
//                // Control Buttons
//                HStack {
//                    // Restart button
//                    Button(action: {
//                        resetTimer()
//                        startTimer() // Automatically start the timer when the restart button is pressed
//                    }) {
//                        Image(systemName: "arrow.counterclockwise")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                    
//                    Spacer()
//                    
//                    // Pause/Play button
//                    Button(action: {
//                        togglePause()
//                    }) {
//                        Image(systemName: paused ? "play.fill" : "pause.fill")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                }
//                .padding(.all, 100.0)
//            }
//            .onAppear {
//                resetTimer()
//                startTimer() // Automatically start the timer when the view appears
//            }
//        }
//    }
//    
//    // Timer-related functions
//    func startTimer() {
//        timerRunning = true
//        paused = false
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if isBreak {
//                if breakTimeRemaining > 0 {
//                    breakTimeRemaining -= 1
//                } else {
//                    timer?.invalidate() // Stop the timer when time is up
//                    playBellSound() // Play ring bell sound
//                    if currentCycle < numberOfBreaks {
//                        currentCycle += 1
//                        startTimer() // Start the main timer automatically
//                    } else {
//                        timerRunning = false
//                        currentCycle = 0 // Reset the cycle after all focusing and break timers are complete
//                    }
//                }
//            } else {
//                if timeRemaining > 0 {
//                    timeRemaining -= 1
//                } else {
//                    timer?.invalidate() // Stop the timer when time is up
//                    playBellSound() // Play ring bell sound
//                    if currentCycle < numberOfBreaks {
//                        currentCycle += 1
//                        startBreakTimer() // Start break timer automatically
//                    } else {
//                        timerRunning = false
//                        currentCycle = 0 // Reset the cycle after all focusing and break timers are complete
//                    }
//                }
//            }
//        }
//    }
//    
//    func startBreakTimer() {
//        isBreak = true
//        timerRunning = true
//        paused = false
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if breakTimeRemaining > 0 {
//                breakTimeRemaining -= 1
//            } else {
//                timer?.invalidate() // Stop the break timer when time is up
//                playBellSound() // Play ring bell sound
//                if currentCycle < numberOfBreaks {
//                    startTimer() // Restart the main timer
//                } else {
//                    timerRunning = false // Stop the cycle after all breaks
//                    currentCycle = 0
//                }
//            }
//        }
//    }
//    
//    func togglePause() {
//        if paused {
//            paused = false
//            startTimer() // Resume timer
//        } else {
//            paused = true
//            timer?.invalidate() // Pause the timer
//        }
//    }
//    
//    func resetTimer() {
//        timer?.invalidate() // Stop any running timer
//        let totalFocusTime = (selectedHour * 3600) + (selectedMinute * 60) + selectedSecond
//        focusTimePerCycle = totalFocusTime / max(1, numberOfBreaks) // Divide focus time by number of breaks
//        timeRemaining = focusTimePerCycle
//        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//        isBreak = false
//        paused = false
//        currentCycle = 0
//    }
//    
//    // Play bell sound when the timer finishes
//    func playBellSound() {
//        guard let url = Bundle.main.url(forResource: "bell", withExtension: "mp3") else {
//            print("Bell sound file not found.")
//            return
//        }
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.prepareToPlay()
//            audioPlayer?.play()
//        } catch {
//            print("Error playing sound: \(error.localizedDescription)")
//        }
//    }
//    
//    // Helper to format time in mm:ss
//    func formatTime(seconds: Int) -> String {
//        let minutes = seconds / 60
//        let seconds = seconds % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//    
//    @ViewBuilder
//    private func timerDisplay(timeRemaining: Int) -> some View {
//        ZStack {
//            Circle()
//                .frame(width: 250.0, height: 250.0)
//                .foregroundColor(Color("backgroundLight"))
//            
//            Circle()
//                .stroke(lineWidth: 10)
//                .opacity(0.3)
//                .foregroundColor(Color("buttonsColor"))
//            
//            let totalTime = isBreak ? ((selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB) : focusTimePerCycle
//            
//            Circle()
//                .trim(from: 0.0, to: CGFloat(Double(totalTime - timeRemaining) / Double(totalTime)))
//                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                .rotationEffect(Angle(degrees: -90.0)) // Rotate to start from 12 o'clock position
//                .animation(.linear, value: timeRemaining)
//            
//            Text(formatTime(seconds: timeRemaining))
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//        }
//        .frame(width: 200, height: 200)
//    }
//}



//
//import SwiftUI
//import AVFoundation
//
//struct TimerView: View {
//    @Binding var selectedHour: Int
//    @Binding var selectedMinute: Int
//    @Binding var selectedSecond: Int
//    
//    @Binding var selectedHourB: Int
//    @Binding var selectedMinuteB: Int
//    @Binding var selectedSecondB: Int
//    
//    @Binding var numberOfBreaks: Int
//    
//    @State private var focusTimePerCycle: Int = 0
//    @State private var timeRemaining: Int = 0
//    @State private var breakTimeRemaining: Int = 0
//    @State private var timerRunning = false
//    @State private var paused = false
//    @State private var isBreak = false
//    @State private var currentCycle = 0
//    @State private var timer: Timer?
//    @State private var audioPlayer: AVAudioPlayer?
//    
//    var body: some View {
//        ZStack {
//            // Set the background image
//            Image("FocusTime")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                // Header for returning back to main page
//                HStack {
//                    Button(action: {
//                        // Action for going back to the main page
//                    }) {
//                        
//                    }
//                    Spacer()
//                }
//                .padding(.horizontal, 40)
//                
//                Spacer()
//                
//                // Main Timer Display
//                timerDisplay(timeRemaining: isBreak ? breakTimeRemaining : timeRemaining)
//                
//                Spacer()
//                Text(isBreak ? "استراحة" : "ركز لمدة \(selectedHour) ساعة, \(selectedMinute) دقيقة")
//                .fontWeight(.bold)
//                .bold()
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                
//                Spacer()
//                
//                // Control Buttons
//                HStack {
//                    // Restart button
//                    Button(action: {
//                        if isBreak {
//                            breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//                        } else {
//                            timeRemaining = focusTimePerCycle
//                        }
//                        startTimer() // Automatically start the timer when the restart button is pressed
//                    }) {
//                        Image(systemName: "arrow.counterclockwise")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                    
//                    Spacer()
//                    
//                    // Pause/Play button
//                    Button(action: {
//                        togglePause()
//                    }) {
//                        Image(systemName: paused ? "play.fill" : "pause.fill")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                }
//                .padding(.all, 100.0)
//            }
//            .onAppear {
//                resetTimer()
//                startTimer() // Automatically start the timer when the view appears
//            }
//        }
//    }
//    
//    // Timer-related functions
//    func startTimer() {
//        timerRunning = true
//        paused = false
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if isBreak {
//                if breakTimeRemaining > 0 {
//                    breakTimeRemaining -= 1
//                } else {
//                    timer?.invalidate() // Stop the timer when time is up
//                    playBellSound() // Play ring bell sound
//                    if currentCycle < numberOfBreaks {
//                        currentCycle += 1
//                        startTimer() // Start the main timer automatically
//                    } else {
//                        timerRunning = false
//                        currentCycle = 0 // Reset the cycle after all focusing and break timers are complete
//                    }
//                }
//            } else {
//                if timeRemaining > 0 {
//                    timeRemaining -= 1
//                } else {
//                    timer?.invalidate() // Stop the timer when time is up
//                    playBellSound() // Play ring bell sound
//                    if currentCycle < numberOfBreaks {
//                        currentCycle += 1
//                        startBreakTimer() // Start break timer automatically
//                    } else {
//                        timerRunning = false
//                        currentCycle = 0 // Reset the cycle after all focusing and break timers are complete
//                    }
//                }
//            }
//        }
//    }
//    
//    func startBreakTimer() {
//        isBreak = true
//        timerRunning = true
//        paused = false
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if breakTimeRemaining > 0 {
//                breakTimeRemaining -= 1
//            } else {
//                timer?.invalidate() // Stop the break timer when time is up
//                playBellSound() // Play ring bell sound
//                if currentCycle < numberOfBreaks {
//                    startTimer() // Restart the main timer
//                } else {
//                    timerRunning = false // Stop the cycle after all breaks
//                    currentCycle = 0
//                }
//            }
//        }
//    }
//    
//    func togglePause() {
//        if paused {
//            paused = false
//            startTimer() // Resume timer
//        } else {
//            paused = true
//            timer?.invalidate() // Pause the timer
//        }
//    }
//    
//    func resetTimer() {
//        timer?.invalidate() // Stop any running timer
//        let totalFocusTime = (selectedHour * 3600) + (selectedMinute * 60) + selectedSecond
//        focusTimePerCycle = totalFocusTime / max(1, numberOfBreaks) // Divide focus time by number of breaks
//        timeRemaining = focusTimePerCycle
//        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//        isBreak = false
//        paused = false
//        currentCycle = 0
//    }
//    
//    // Play bell sound when the timer finishes
//    func playBellSound() {
//        guard let url = Bundle.main.url(forResource: "bell", withExtension: "mp3") else {
//            print("Bell sound file not found.")
//            return
//        }
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.prepareToPlay()
//            audioPlayer?.play()
//        } catch {
//            print("Error playing sound: \(error.localizedDescription)")
//        }
//    }
//    
//    // Helper to format time in mm:ss
//    func formatTime(seconds: Int) -> String {
//        let minutes = seconds / 60
//        let seconds = seconds % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//    
//    @ViewBuilder
//    private func timerDisplay(timeRemaining: Int) -> some View {
//        ZStack {
//            Circle()
//                .frame(width: 250.0, height: 250.0)
//                .foregroundColor(Color("backgroundLight"))
//            
//            Circle()
//                .stroke(lineWidth: 10)
//                .opacity(0.3)
//                .foregroundColor(Color("buttonsColor"))
//            
//            let totalTime = isBreak ? ((selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB) : focusTimePerCycle
//            
//            Circle()
//                .trim(from: 0.0, to: CGFloat(Double(totalTime - timeRemaining) / Double(totalTime)))
//                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                .rotationEffect(Angle(degrees: -90.0)) // Rotate to start from 12 o'clock position
//                .animation(.linear, value: timeRemaining)
//            
//            Text(formatTime(seconds: timeRemaining))
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//        }
//        .frame(width: 200, height: 200)
//    }
//}
//
















//
//import SwiftUI
//import AVFoundation
//
//struct TimerView: View {
//    @Binding var selectedHour: Int
//    @Binding var selectedMinute: Int
//    @Binding var selectedSecond: Int
//    
//    @Binding var selectedHourB: Int
//    @Binding var selectedMinuteB: Int
//    @Binding var selectedSecondB: Int
//    
//    @Binding var numberOfBreaks: Int
//    
//    @State private var focusTimePerCycle: Int = 0
//    @State private var timeRemaining: Int = 0
//    @State private var breakTimeRemaining: Int = 0
//    @State private var timerRunning = false
//    @State private var paused = false
//    @State private var isBreak = false
//    @State private var currentCycle = 0
//    @State private var timer: Timer?
//    @State private var audioPlayer: AVAudioPlayer?
//    
//    var body: some View {
//        ZStack {
//            // Set the background image
//            Image("FocusTime")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                // Header for returning back to main page
//                HStack {
//                    Button(action: {
//                        // Action for going back to the main page
//                    }) {
//                        
//                    }
//                    Spacer()
//                }
//                .padding(.horizontal, 40)
//                
//                Spacer()
//                
//                // Main Timer Display
//                timerDisplay(timeRemaining: isBreak ? breakTimeRemaining : timeRemaining)
//                
//                Spacer()
//                Text(isBreak ? "استراحة" : "ركز لمدة \(selectedHour) ساعة, \(selectedMinute) دقيقة")
//                .fontWeight(.bold)
//                .bold()
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                
//                Spacer()
//                
//                // Control Buttons
//                HStack {
//                    // Restart button
//                    Button(action: {
//                        resetTimer()
//                    }) {
//                        Image(systemName: "arrow.counterclockwise")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                    
//                    Spacer()
//                    
//                    // Pause/Play button
//                    Button(action: {
//                        togglePause()
//                    }) {
//                        Image(systemName: paused ? "play.fill" : "pause.fill")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                }
//                .padding(.all, 100.0)
//            }
//            .onAppear {
//                resetTimer()
//            }
//        }
//    }
//    
//    // Timer-related functions
//    func startTimer() {
//        timerRunning = true
//        paused = false
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if isBreak {
//                if breakTimeRemaining > 0 {
//                    breakTimeRemaining -= 1
//                } else {
//                    timer?.invalidate() // Stop the timer when time is up
//                    playBellSound() // Play ring bell sound
//                    if currentCycle < numberOfBreaks {
//                        currentCycle += 1
//                        startTimer() // Start the main timer automatically
//                    } else {
//                        timerRunning = false
//                        currentCycle = 0 // Reset the cycle after all focusing and break timers are complete
//                    }
//                }
//            } else {
//                if timeRemaining > 0 {
//                    timeRemaining -= 1
//                } else {
//                    timer?.invalidate() // Stop the timer when time is up
//                    playBellSound() // Play ring bell sound
//                    if currentCycle < numberOfBreaks {
//                        currentCycle += 1
//                        startBreakTimer() // Start break timer automatically
//                    } else {
//                        timerRunning = false
//                        currentCycle = 0 // Reset the cycle after all focusing and break timers are complete
//                    }
//                }
//            }
//        }
//    }
//    
//    func startBreakTimer() {
//        isBreak = true
//        timerRunning = true
//        paused = false
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if breakTimeRemaining > 0 {
//                breakTimeRemaining -= 1
//            } else {
//                timer?.invalidate() // Stop the break timer when time is up
//                playBellSound() // Play ring bell sound
//                if currentCycle < numberOfBreaks {
//                    startTimer() // Restart the main timer
//                } else {
//                    timerRunning = false // Stop the cycle after all breaks
//                    currentCycle = 0
//                }
//            }
//        }
//    }
//    
//    func togglePause() {
//        if paused {
//            paused = false
//            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//                if isBreak {
//                    if breakTimeRemaining > 0 {
//                        breakTimeRemaining -= 1
//                    } else {
//                        timer?.invalidate() // Stop the timer when time is up
//                        playBellSound() // Play ring bell sound
//                        if currentCycle < numberOfBreaks {
//                            currentCycle += 1
//                            startTimer() // Start the main timer automatically
//                        } else {
//                            timerRunning = false
//                            currentCycle = 0 // Reset the cycle after all focusing and break timers are complete
//                        }
//                    }
//                } else {
//                    if timeRemaining > 0 {
//                        timeRemaining -= 1
//                    } else {
//                        timer?.invalidate() // Stop the timer when time is up
//                        playBellSound() // Play ring bell sound
//                        if currentCycle < numberOfBreaks {
//                            currentCycle += 1
//                            startBreakTimer() // Start break timer automatically
//                        } else {
//                            timerRunning = false
//                            currentCycle = 0 // Reset the cycle after all focusing and break timers are complete
//                        }
//                    }
//                }
//            }
//        } else {
//            paused = true
//            timer?.invalidate() // Pause the timer
//        }
//    }
//    
//    func resetTimer() {
//        timer?.invalidate() // Stop any running timer
//        let totalFocusTime = (selectedHour * 3600) + (selectedMinute * 60) + selectedSecond
//        focusTimePerCycle = totalFocusTime / max(1, numberOfBreaks) // Divide focus time by number of breaks
//        timeRemaining = focusTimePerCycle
//        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//        isBreak = false
//        paused = false
//        currentCycle = 0
//    }
//    
//    // Play bell sound when the timer finishes
//    func playBellSound() {
//        guard let url = Bundle.main.url(forResource: "bell", withExtension: "mp3") else {
//            print("Bell sound file not found.")
//            return
//        }
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.prepareToPlay()
//            audioPlayer?.play()
//        } catch {
//            print("Error playing sound: \(error.localizedDescription)")
//        }
//    }
//    
//    // Helper to format time in mm:ss
//    func formatTime(seconds: Int) -> String {
//        let minutes = seconds / 60
//        let seconds = seconds % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//    
//    @ViewBuilder
//    private func timerDisplay(timeRemaining: Int) -> some View {
//        ZStack {
//            Circle()
//                .frame(width: 250.0, height: 250.0)
//                .foregroundColor(Color("backgroundLight"))
//            
//            Circle()
//                .stroke(lineWidth: 10)
//                .opacity(0.3)
//                .foregroundColor(Color("buttonsColor"))
//            
//            let totalTime = isBreak ? ((selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB) : focusTimePerCycle
//            
//            Circle()
//                .trim(from: 0.0, to: CGFloat(Double(totalTime - timeRemaining) / Double(totalTime)))
//                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                .rotationEffect(Angle(degrees: -90.0)) // Rotate to start from 12 o'clock position
//                .animation(.linear, value: timeRemaining)
//            
//            Text(formatTime(seconds: timeRemaining))
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//        }
//        .frame(width: 200, height: 200)
//    }
//}


// المظبوووط

//
//import SwiftUI
//import AVFoundation
//
//struct TimerView: View {
//    @Binding var selectedHour: Int
//    @Binding var selectedMinute: Int
//    @Binding var selectedSecond: Int
//    
//    @Binding var selectedHourB: Int
//    @Binding var selectedMinuteB: Int
//    @Binding var selectedSecondB: Int
//    
//    @Binding var numberOfBreaks: Int
//    
//    @State private var focusTimePerCycle: Int = 0
//    @State private var timeRemaining: Int = 0
//    @State private var breakTimeRemaining: Int = 0
//    @State private var timerRunning = false
//    @State private var paused = false
//    @State private var isBreak = false
//    @State private var currentCycle = 0
//    @State private var timer: Timer?
//    @State private var audioPlayer: AVAudioPlayer?
//    
//    var body: some View {
//        ZStack {
//            // Set the background image
//            Image("FocusTime")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                // Header for returning back to main page
//                HStack {
//                    Button(action: {
//                        // Action for going back to the main page
//                    }) {
//                        
//                    }
//                    Spacer()
//                }
//                .padding(.horizontal, 40)
//                
//                Spacer()
//                
//                // Main Timer Display
//                timerDisplay(timeRemaining: isBreak ? breakTimeRemaining : timeRemaining)
//                
//                Spacer()
//                Text(isBreak ? "استرخ لقد انجزت الكثير  " : "ركز معنا وقتك ثمين")
//                .fontWeight(.bold)
//                .bold()
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                
//                Spacer()
//                
//                // Control Buttons
//                HStack {
//                    // Restart button
//                    Button(action: {
//                        resetTimer()
//                    }) {
//                        Image(systemName: "arrow.counterclockwise")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                    
//                    Spacer()
//                    
//                    // Pause/Play button
//                    Button(action: {
//                        togglePause()
//                    }) {
//                        Image(systemName: paused ? "play.fill" : "pause.fill")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                }
//                .padding(.all, 100.0)
//            }
//            .onAppear {
//                resetTimer()
//            }
//        }
//    }
//    
//    // Timer-related functions
//    func startTimer() {
//        timerRunning = true
//        paused = false
//        isBreak = false
//        timeRemaining = focusTimePerCycle
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if timeRemaining > 0 {
//                timeRemaining -= 1
//            } else {
//                timer?.invalidate() // Stop the timer when time is up
//                playBellSound() // Play ring bell sound
//                if currentCycle < numberOfBreaks {
//                    currentCycle += 1
//                    startBreakTimer() // Start break timer automatically
//                } else {
//                    timerRunning = false
//                    currentCycle = 0 // Reset the cycle after all focusing and break timers are complete
//                }
//            }
//        }
//    }
//    
//    func startBreakTimer() {
//        isBreak = true
//        timerRunning = true
//        paused = false
//        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if breakTimeRemaining > 0 {
//                breakTimeRemaining -= 1
//            } else {
//                timer?.invalidate() // Stop the break timer when time is up
//                playBellSound() // Play ring bell sound
//                if currentCycle < numberOfBreaks {
//                    startTimer() // Restart the main timer
//                } else {
//                    timerRunning = false // Stop the cycle after all breaks
//                    currentCycle = 0
//                }
//            }
//        }
//    }
//    
//    func togglePause() {
//        if paused {
//            if isBreak {
//                startBreakTimer() // Resume break timer
//            } else {
//                startTimer() // Resume main timer
//            }
//        } else {
//            paused = true
//            timer?.invalidate() // Pause the timer
//        }
//    }
//    
//    func resetTimer() {
//        timer?.invalidate() // Stop any running timer
//        let totalFocusTime = (selectedHour * 3600) + (selectedMinute * 60) + selectedSecond
//        focusTimePerCycle = totalFocusTime / max(1, numberOfBreaks) // Divide focus time by number of breaks
//        timeRemaining = focusTimePerCycle
//        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//        isBreak = false
//        paused = false
//        currentCycle = 0
//        if totalFocusTime > 0 {
//            startTimer() // Start the main timer
//        }
//    }
//    
//    // Play bell sound when the timer finishes
//    func playBellSound() {
//        guard let url = Bundle.main.url(forResource: "bell", withExtension: "mp3") else {
//            print("Bell sound file not found.")
//            return
//        }
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.prepareToPlay()
//            audioPlayer?.play()
//        } catch {
//            print("Error playing sound: \(error.localizedDescription)")
//        }
//    }
//    
//    // Helper to format time in mm:ss
//    func formatTime(seconds: Int) -> String {
//        let minutes = seconds / 60
//        let seconds = seconds % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//    
//    @ViewBuilder
//    private func timerDisplay(timeRemaining: Int) -> some View {
//        ZStack {
//            Circle()
//                .frame(width: 250.0, height: 250.0)
//                .foregroundColor(Color("backgroundLight"))
//            
//            Circle()
//                .stroke(lineWidth: 10)
//                .opacity(0.3)
//                .foregroundColor(Color("buttonsColor"))
//            
//            let totalTime = isBreak ? ((selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB) : focusTimePerCycle
//            
//            Circle()
//                .trim(from: 0.0, to: CGFloat(Double(totalTime - timeRemaining) / Double(totalTime)))
//                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                .rotationEffect(Angle(degrees: -90.0)) // Rotate to start from 12 o'clock position
//                .animation(.linear, value: timeRemaining)
//            
//            Text(formatTime(seconds: timeRemaining))
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//        }
//        .frame(width: 200, height: 200)
//    }
//}


//
//import SwiftUI
//import AVFoundation
//
//struct TimerView: View {
//    @Binding var selectedHour: Int
//    @Binding var selectedMinute: Int
//    @Binding var selectedSecond: Int
//    
//    @Binding var selectedHourB: Int
//    @Binding var selectedMinuteB: Int
//    @Binding var selectedSecondB: Int
//    
//    @Binding var numberOfBreaks: Int
//    
//    @State private var focusTimePerCycle: Int = 0
//    @State private var timeRemaining: Int = 0
//    @State private var breakTimeRemaining: Int = 0
//    @State private var timerRunning = false
//    @State private var paused = false
//    @State private var isBreak = false
//    @State private var currentCycle = 0
//    @State private var timer: Timer?
//    @State private var audioPlayer: AVAudioPlayer?
//    
//    var body: some View {
//        ZStack {
//            // Set the background image
//            Image("FocusTime")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                // Header for returning back to main page
//                HStack {
//                    Button(action: {
//                        // Action for going back to the main page
//                    }) {
//                        
//                    }
//                    Spacer()
//                }
//                .padding(.horizontal, 40)
//                
//                Spacer()
//                
//                // Main Timer Display
//                timerDisplay(timeRemaining: isBreak ? breakTimeRemaining : timeRemaining)
//                
//                Spacer()
//                Text(isBreak ? "استرخ لقد انجزت الكثير  " : "ركز معنا وقتك ثمين")
//                .fontWeight(.bold)
//                .bold()
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                
//                Spacer()
//                
//                // Control Buttons
//                HStack {
//                    // Restart button
//                    Button(action: {
//                        paused = false
//                        resetTimer()
//                    }) {
//                        Image(systemName: "arrow.counterclockwise")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                    
//                    Spacer()
//                    
//                    // Pause/Play button
//                    Button(action: {
//                        togglePause()
//                    }) {
//                        Image(systemName: paused ? "play.fill" : "pause.fill")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                }
//                .padding(.all, 100.0)
//            }
//            .onAppear {
//                resetTimer()
//            }
//        }
//    }
//    
//    // Timer-related functions
//    func startTimer() {
//        timerRunning = true
//        paused = false
//        isBreak = false
//        timeRemaining = focusTimePerCycle
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if timeRemaining > 0 {
//                timeRemaining -= 1
//            } else {
//                timer?.invalidate() // Stop the timer when time is up
//                playBellSound() // Play ring bell sound
//                if currentCycle < numberOfBreaks {
//                    currentCycle += 1
//                    startBreakTimer() // Start break timer automatically
//                } else {
//                    timerRunning = false
//                    currentCycle = 0 // Reset the cycle after all focusing and break timers are complete
//                }
//            }
//        }
//    }
//    
//    func startBreakTimer() {
//        isBreak = true
//        timerRunning = true
//        paused = false
//        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if breakTimeRemaining > 0 {
//                breakTimeRemaining -= 1
//            } else {
//                timer?.invalidate() // Stop the break timer when time is up
//                playBellSound() // Play ring bell sound
//                if currentCycle < numberOfBreaks {
//                    startTimer() // Restart the main timer
//                } else {
//                    timerRunning = false // Stop the cycle after all breaks
//                    currentCycle = 0
//                }
//            }
//        }
//    }
//    
//    func togglePause() {
//        if paused {
//            if isBreak {
//                startBreakTimer() // Resume break timer
//            } else {
//                startTimer() // Resume main timer
//            }
//        } else {
//            paused = true
//            timer?.invalidate() // Pause the timer
//        }
//    }
//    
//    func resetTimer() {
//        timer?.invalidate() // Stop any running timer
//        let totalFocusTime = (selectedHour * 3600) + (selectedMinute * 60) + selectedSecond
//        focusTimePerCycle = totalFocusTime / max(1, numberOfBreaks) // Divide focus time by number of breaks
//        timeRemaining = focusTimePerCycle
//        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//        isBreak = false
//        paused = false
//        currentCycle = 0
//        if totalFocusTime > 0 {
//            startTimer() // Start the main timer
//        }
//    }
//    
//    // Play bell sound when the timer finishes
//    func playBellSound() {
//        guard let url = Bundle.main.url(forResource: "bell", withExtension: "mp3") else {
//            print("Bell sound file not found.")
//            return
//        }
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.prepareToPlay()
//            audioPlayer?.play()
//        } catch {
//            print("Error playing sound: \(error.localizedDescription)")
//        }
//    }
//    
//    // Helper to format time in mm:ss
//    func formatTime(seconds: Int) -> String {
//        let minutes = seconds / 60
//        let seconds = seconds % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//    
//    @ViewBuilder
//    private func timerDisplay(timeRemaining: Int) -> some View {
//        ZStack {
//            Circle()
//                .frame(width: 250.0, height: 250.0)
//                .foregroundColor(Color("backgroundLight"))
//            
//            Circle()
//                .stroke(lineWidth: 10)
//                .opacity(0.3)
//                .foregroundColor(Color("buttonsColor"))
//            
//            let totalTime = isBreak ? ((selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB) : focusTimePerCycle
//            
//            Circle()
//                .trim(from: 0.0, to: CGFloat(Double(totalTime - timeRemaining) / Double(totalTime)))
//                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                .rotationEffect(Angle(degrees: -90.0)) // Rotate to start from 12 o'clock position
//                .animation(.linear, value: timeRemaining)
//            
//            Text(formatTime(seconds: timeRemaining))
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//        }
//        .frame(width: 200, height: 200)
//    }
//}



//
//
//
//import SwiftUI
//import AVFoundation
//
//struct TimerView: View {
//    @Binding var selectedHour: Int
//    @Binding var selectedMinute: Int
//    @Binding var selectedSecond: Int
//    
//    @Binding var selectedHourB: Int
//    @Binding var selectedMinuteB: Int
//    @Binding var selectedSecondB: Int
//    
//    @Binding var numberOfBreaks: Int
//    
//    @State private var focusTimePerCycle: Int = 0
//    @State private var timeRemaining: Int = 0
//    @State private var breakTimeRemaining: Int = 0
//    @State private var timerRunning = false
//    @State private var paused = false
//    @State private var isBreak = false
//    @State private var currentCycle = 0
//    @State private var timer: Timer?
//    @State private var audioPlayer: AVAudioPlayer?
//    
//    var body: some View {
//        ZStack {
//            // Set the background image
//            Image("FocusTime")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                // Header for returning back to main page
//                HStack {
//                    Button(action: {
//                        // Action for going back to the main page
//                    }) {
//                        
//                    }
//                    Spacer()
//                }
//                .padding(.horizontal, 40)
//                
//                Spacer()
//                
//                // Main Timer Display
//                timerDisplay(timeRemaining: isBreak ? breakTimeRemaining : timeRemaining)
//                
//                Spacer()
//                Text(isBreak ? "استرخ لقد انجزت الكثير  " : "ركز معنا وقتك ثمين")
//                .fontWeight(.bold)
//                .bold()
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                
//                Spacer()
//                
//                // Control Buttons
//                HStack {
//                    // Restart button
//                    Button(action: {
//                        paused = false
//                        resetTimer()
//                    }) {
//                        Image(systemName: "arrow.counterclockwise")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                    
//                    Spacer()
//                    
//                    // Pause/Play button
//                    Button(action: {
//                        togglePause()
//                    }) {
//                        Image(systemName: paused ? "play.fill" : "pause.fill")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                }
//                .padding(.all, 100.0)
//            }
//            .onAppear {
//                resetTimer()
//            }
//        }
//    }
//    
//    // Timer-related functions
//    func startTimer() {
//        timerRunning = true
//        paused = false
//        isBreak = false
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if timeRemaining > 0 {
//                timeRemaining -= 1
//            } else {
//                timer?.invalidate() // Stop the timer when time is up
//                playBellSound() // Play ring bell sound
//                if currentCycle < numberOfBreaks {
//                    currentCycle += 1
//                    startBreakTimer() // Start break timer automatically
//                } else {
//                    timerRunning = false
//                    currentCycle = 0 // Reset the cycle after all focusing and break timers are complete
//                }
//            }
//        }
//    }
//    
//    func startBreakTimer() {
//        isBreak = true
//        timerRunning = true
//        paused = false
//        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if breakTimeRemaining > 0 {
//                breakTimeRemaining -= 1
//            } else {
//                timer?.invalidate() // Stop the break timer when time is up
//                playBellSound() // Play ring bell sound
//                if currentCycle < numberOfBreaks {
//                    startTimer() // Restart the main timer
//                } else {
//                    timerRunning = false // Stop the cycle after all breaks
//                    currentCycle = 0
//                }
//            }
//        }
//    }
//    
//    func togglePause() {
//        if paused {
//            paused = false
//            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//                if isBreak {
//                    if breakTimeRemaining > 0 {
//                        breakTimeRemaining -= 1
//                    } else {
//                        timer?.invalidate()
//                        playBellSound()
//                        if currentCycle < numberOfBreaks {
//                            startTimer()
//                        } else {
//                            timerRunning = false
//                            currentCycle = 0
//                        }
//                    }
//                } else {
//                    if timeRemaining > 0 {
//                        timeRemaining -= 1
//                    } else {
//                        timer?.invalidate()
//                        playBellSound()
//                        if currentCycle < numberOfBreaks {
//                            currentCycle += 1
//                            startBreakTimer()
//                        } else {
//                            timerRunning = false
//                            currentCycle = 0
//                        }
//                    }
//                }
//            }
//        } else {
//            paused = true
//            timer?.invalidate() // Pause the timer
//        }
//    }
//    
//    func resetTimer() {
//        timer?.invalidate() // Stop any running timer
//        let totalFocusTime = (selectedHour * 3600) + (selectedMinute * 60) + selectedSecond
//        focusTimePerCycle = totalFocusTime / max(1, numberOfBreaks) // Divide focus time by number of breaks
//        timeRemaining = focusTimePerCycle
//        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//        isBreak = false
//        paused = false
//        currentCycle = 0
//        if totalFocusTime > 0 {
//            startTimer() // Start the main timer
//        }
//    }
//    
//    // Play bell sound when the timer finishes
//    func playBellSound() {
//        guard let url = Bundle.main.url(forResource: "bell", withExtension: "mp3") else {
//            print("Bell sound file not found.")
//            return
//        }
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.prepareToPlay()
//            audioPlayer?.play()
//        } catch {
//            print("Error playing sound: \(error.localizedDescription)")
//        }
//    }
//    
//    // Helper to format time in mm:ss
//    func formatTime(seconds: Int) -> String {
//        let minutes = seconds / 60
//        let seconds = seconds % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//    
//    @ViewBuilder
//    private func timerDisplay(timeRemaining: Int) -> some View {
//        ZStack {
//            Circle()
//                .frame(width: 250.0, height: 250.0)
//                .foregroundColor(Color("backgroundLight"))
//            
//            Circle()
//                .stroke(lineWidth: 10)
//                .opacity(0.3)
//                .foregroundColor(Color("buttonsColor"))
//            
//            let totalTime = isBreak ? ((selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB) : focusTimePerCycle
//            
//            Circle()
//                .trim(from: 0.0, to: CGFloat(Double(totalTime - timeRemaining) / Double(totalTime)))
//                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                .rotationEffect(Angle(degrees: -90.0)) // Rotate to start from 12 o'clock position
//                .animation(.linear, value: timeRemaining)
//            
//            Text(formatTime(seconds: timeRemaining))
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//        }
//        .frame(width: 200, height: 200)
//    }
//}



//
//
//import SwiftUI
//import AVFoundation
//
//struct TimerView: View {
//    @Binding var selectedHour: Int
//    @Binding var selectedMinute: Int
//    @Binding var selectedSecond: Int
//    
//    @Binding var selectedHourB: Int
//    @Binding var selectedMinuteB: Int
//    @Binding var selectedSecondB: Int
//    
//    @Binding var numberOfBreaks: Int
//    
//    @State private var focusTimePerCycle: Int = 0
//    @State private var timeRemaining: Int = 0
//    @State private var breakTimeRemaining: Int = 0
//    @State private var timerRunning = false
//    @State private var paused = false
//    @State private var isBreak = false
//    @State private var currentCycle = 0
//    @State private var timer: Timer?
//    @State private var audioPlayer: AVAudioPlayer?
//    
//    var body: some View {
//        ZStack {
//            // Set the background image
//            Image("FocusTime")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                // Header for returning back to main page
//                HStack {
//                    Button(action: {
//                        // Action for going back to the main page
//                    }) {
//                        
//                    }
//                    Spacer()
//                }
//                .padding(.horizontal, 40)
//                
//                Spacer()
//                
//                // Main Timer Display
//                timerDisplay(timeRemaining: isBreak ? breakTimeRemaining : timeRemaining)
//                
//                Spacer()
//                Text(isBreak ? "استرخ لقد انجزت الكثير  " : "ركز معنا وقتك ثمين")
//                .fontWeight(.bold)
//                .bold()
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                
//                Spacer()
//                
//                // Control Buttons
//                HStack {
//                    // Restart button
//                    Button(action: {
//                        paused = false
//                        resetTimer()
//                    }) {
//                        Image(systemName: "arrow.counterclockwise")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                    
//                    Spacer()
//                    
//                    // Pause/Play button
//                    Button(action: {
//                        togglePause()
//                    }) {
//                        Image(systemName: paused ? "play.fill" : "pause.fill")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                }
//                .padding(.all, 100.0)
//            }
//            .onAppear {
//                resetTimer()
//            }
//        }
//    }
//    
//    // Timer-related functions
//    func startTimer() {
//        timerRunning = true
//        paused = false
//        isBreak = false
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if timeRemaining > 0 {
//                timeRemaining -= 1
//            } else {
//                timer?.invalidate() // Stop the timer when time is up
//                playBellSound() // Play ring bell sound
//                startBreakTimer() // Start break timer automatically
//            }
//        }
//    }
//    
//    func startBreakTimer() {
//        isBreak = true
//        timerRunning = true
//        paused = false
//        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if breakTimeRemaining > 0 {
//                breakTimeRemaining -= 1
//            } else {
//                timer?.invalidate() // Stop the break timer when time is up
//                playBellSound() // Play ring bell sound
//                startTimer() // Start the focus timer again
//            }
//        }
//    }
//    
//    func togglePause() {
//        if paused {
//            paused = false
//            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//                if isBreak {
//                    if breakTimeRemaining > 0 {
//                        breakTimeRemaining -= 1
//                    } else {
//                        timer?.invalidate()
//                        playBellSound()
//                        startTimer() // Start the focus timer again
//                    }
//                } else {
//                    if timeRemaining > 0 {
//                        timeRemaining -= 1
//                    } else {
//                        timer?.invalidate()
//                        playBellSound()
//                        startBreakTimer()
//                    }
//                }
//            }
//        } else {
//            paused = true
//            timer?.invalidate() // Pause the timer
//        }
//    }
//    
//    func resetTimer() {
//        timer?.invalidate() // Stop any running timer
//        let totalFocusTime = (selectedHour * 3600) + (selectedMinute * 60) + selectedSecond
//        focusTimePerCycle = totalFocusTime / max(1, numberOfBreaks) // Divide focus time by number of breaks
//        timeRemaining = focusTimePerCycle
//        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//        isBreak = false
//        paused = false
//        currentCycle = 0
//        if totalFocusTime > 0 {
//            startTimer() // Start the main timer
//        }
//    }
//    
//    // Play bell sound when the timer finishes
//    func playBellSound() {
//        guard let url = Bundle.main.url(forResource: "bell", withExtension: "mp3") else {
//            print("Bell sound file not found.")
//            return
//        }
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.prepareToPlay()
//            audioPlayer?.play()
//        } catch {
//            print("Error playing sound: \(error.localizedDescription)")
//        }
//    }
//    
//    // Helper to format time in mm:ss
//    func formatTime(seconds: Int) -> String {
//        let minutes = seconds / 60
//        let seconds = seconds % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//    
//    @ViewBuilder
//    private func timerDisplay(timeRemaining: Int) -> some View {
//        ZStack {
//            Circle()
//                .frame(width: 250.0, height: 250.0)
//                .foregroundColor(Color("backgroundLight"))
//            
//            Circle()
//                .stroke(lineWidth: 10)
//                .opacity(0.3)
//                .foregroundColor(Color("buttonsColor"))
//            
//            let totalTime = isBreak ? ((selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB) : focusTimePerCycle
//            
//            Circle()
//                .trim(from: 0.0, to: CGFloat(Double(totalTime - timeRemaining) / Double(totalTime)))
//                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                .rotationEffect(Angle(degrees: -90.0)) // Rotate to start from 12 o'clock position
//                .animation(.linear, value: timeRemaining)
//            
//            Text(formatTime(seconds: timeRemaining))
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//        }
//        .frame(width: 200, height: 200)
//    }
//}


// افضللل وااحد

//
//
//import SwiftUI
//import AVFoundation
//
//struct TimerView: View {
//    @Binding var selectedHour: Int
//    @Binding var selectedMinute: Int
//    @Binding var selectedSecond: Int
//    
//    @Binding var selectedHourB: Int
//    @Binding var selectedMinuteB: Int
//    @Binding var selectedSecondB: Int
//    
//    @Binding var numberOfBreaks: Int
//    
//    @State private var focusTimePerCycle: Int = 0
//    @State private var timeRemaining: Int = 0
//    @State private var breakTimeRemaining: Int = 0
//    @State private var timerRunning = false
//    @State private var paused = false
//    @State private var isBreak = false
//    @State private var currentCycle = 0
//    @State private var timer: Timer?
//    @State private var audioPlayer: AVAudioPlayer?
//    
//    var body: some View {
//        ZStack {
//            // Set the background image
//            Image("FocusTime")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                // Header for returning back to main page
//                HStack {
//                    Button(action: {
//                        // Action for going back to the main page
//                    }) {
//                        
//                    }
//                    Spacer()
//                }
//                .padding(.horizontal, 40)
//                
//                Spacer()
//                
//                // Main Timer Display
//                timerDisplay(timeRemaining: isBreak ? breakTimeRemaining : timeRemaining)
//                
//                Spacer()
//                Text(isBreak ? "استرخ لقد انجزت الكثير  " : "ركز معنا وقتك ثمين")
//                .fontWeight(.bold)
//                .bold()
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                
//                Spacer()
//                
//                // Control Buttons
//                HStack {
//                    // Restart button
//                    Button(action: {
//                        paused = false
//                        resetTimer()
//                    }) {
//                        Image(systemName: "arrow.counterclockwise")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                    
//                    Spacer()
//                    
//                    // Pause/Play button
//                    Button(action: {
//                        togglePause()
//                    }) {
//                        Image(systemName: paused ? "play.fill" : "pause.fill")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(Color("backgroundLight"))
//                            .padding()
//                            .background(Color("buttonsColor").clipShape(Circle()))
//                    }
//                }
//                .padding(.all, 100.0)
//            }
//            .onAppear {
//                resetTimer()
//            }
//        }
//    }
//    
//    // Timer-related functions
//    func startTimer() {
//        timerRunning = true
//        paused = false
//        isBreak = false
//        timeRemaining = focusTimePerCycle
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if timeRemaining > 0 {
//                timeRemaining -= 1
//            } else {
//                timer?.invalidate() // Stop the timer when time is up
//                playBellSound() // Play ring bell sound
//                startBreakTimer() // Start break timer automatically
//            }
//        }
//    }
//    
//    func startBreakTimer() {
//        isBreak = true
//        timerRunning = true
//        paused = false
//        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if breakTimeRemaining > 0 {
//                breakTimeRemaining -= 1
//            } else {
//                timer?.invalidate() // Stop the break timer when time is up
//                playBellSound() // Play ring bell sound
//                timeRemaining = focusTimePerCycle // Reset focus timer
//                startTimer() // Start the focus timer again
//            }
//        }
//    }
//    
//    func togglePause() {
//        if paused {
//            paused = false
//            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//                if isBreak {
//                    if breakTimeRemaining > 0 {
//                        breakTimeRemaining -= 1
//                    } else {
//                        timer?.invalidate()
//                        playBellSound()
//                        timeRemaining = focusTimePerCycle // Reset focus timer
//                        startTimer() // Start the focus timer again
//                    }
//                } else {
//                    if timeRemaining > 0 {
//                        timeRemaining -= 1
//                    } else {
//                        timer?.invalidate()
//                        playBellSound()
//                        startBreakTimer()
//                    }
//                }
//            }
//        } else {
//            paused = true
//            timer?.invalidate() // Pause the timer
//        }
//    }
//    
//    func resetTimer() {
//        timer?.invalidate() // Stop any running timer
//        let totalFocusTime = (selectedHour * 3600) + (selectedMinute * 60) + selectedSecond
//        focusTimePerCycle = totalFocusTime / max(1, numberOfBreaks) // Divide focus time by number of breaks
//        timeRemaining = focusTimePerCycle
//        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
//        isBreak = false
//        paused = false
//        currentCycle = 0
//        if totalFocusTime > 0 {
//            startTimer() // Start the main timer
//        }
//    }
//    
//    // Play bell sound when the timer finishes
//    func playBellSound() {
//        guard let url = Bundle.main.url(forResource: "bell", withExtension: "mp3") else {
//            print("Bell sound file not found.")
//            return
//        }
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.prepareToPlay()
//            audioPlayer?.play()
//        } catch {
//            print("Error playing sound: \(error.localizedDescription)")
//        }
//    }
//    
//    // Helper to format time in mm:ss
//    func formatTime(seconds: Int) -> String {
//        let minutes = seconds / 60
//        let seconds = seconds % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//    
//    @ViewBuilder
//    private func timerDisplay(timeRemaining: Int) -> some View {
//        ZStack {
//            Circle()
//                .frame(width: 250.0, height: 250.0)
//                .foregroundColor(Color("backgroundLight"))
//            
//            Circle()
//                .stroke(lineWidth: 10)
//                .opacity(0.3)
//                .foregroundColor(Color("buttonsColor"))
//            
//            let totalTime = isBreak ? ((selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB) : focusTimePerCycle
//            
//            Circle()
//                .trim(from: 0.0, to: CGFloat(Double(totalTime - timeRemaining) / Double(totalTime)))
//                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//                .rotationEffect(Angle(degrees: -90.0)) // Rotate to start from 12 o'clock position
//                .animation(.linear, value: timeRemaining)
//            
//            Text(formatTime(seconds: timeRemaining))
//                .font(.largeTitle)
//                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
//        }
//        .frame(width: 200, height: 200)
//    }
//}



//الكووود الصحييييح
/*
import SwiftUI
import AVFoundation

struct TimerView: View {
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    @Binding var selectedSecond: Int
    
    @Binding var selectedHourB: Int
    @Binding var selectedMinuteB: Int
    @Binding var selectedSecondB: Int
    
    @Binding var numberOfBreaks: Int
    
    @State private var focusTimePerCycle: Int = 0
    @State private var timeRemaining: Int = 0
    @State private var breakTimeRemaining: Int = 0
    @State private var timerRunning = false
    @State private var paused = false
    @State private var isBreak = false
    @State private var currentCycle = 0
    @State private var timer: Timer?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var totalFocusTime: Int = 0
    
    var body: some View {
        ZStack {
            // Set the background image
            Image("FocusTime")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Header for returning back to main page
                HStack {
                    Button(action: {
                        // Action for going back to the main page
                    }) {
                        
                    }
                    Spacer()
                }
                .padding(.horizontal, 40)
                
                Spacer()
                
                // Main Timer Display
                timerDisplay(timeRemaining: isBreak ? breakTimeRemaining : timeRemaining)
                
                Spacer()
                Text(isBreak ? "استرخ لقد انجزت الكثير  " : "ركز معنا وقتك ثمين")
                .fontWeight(.bold)
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
                
                Spacer()
                
                // Control Buttons
                HStack {
                    // Restart button
                    Button(action: {
                        paused = false
                        resetTimer()
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("backgroundLight"))
                            .padding()
                            .background(Color("buttonsColor").clipShape(Circle()))
                    }
                    
                    Spacer()
                    
                    // Pause/Play button
                    Button(action: {
                        togglePause()
                    }) {
                        Image(systemName: paused ? "play.fill" : "pause.fill")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("backgroundLight"))
                            .padding()
                            .background(Color("buttonsColor").clipShape(Circle()))
                    }
                }
                .padding(.all, 100.0)
            }
            .onAppear {
                resetTimer()
            }
        }
    }
    
    // Timer-related functions
    func startTimer() {
        timerRunning = true
        paused = false
        isBreak = false
        timeRemaining = focusTimePerCycle
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
                totalFocusTime -= 1
            } else if totalFocusTime > 0 {
                timer?.invalidate() // Stop the timer when time is up
                playBellSound() // Play ring bell sound
                startBreakTimer() // Start break timer automatically
            } else {
                timer?.invalidate() // Stop the timer when total time is up
                timerRunning = false
            }
        }
    }
    
    func startBreakTimer() {
        isBreak = true
        timerRunning = true
        paused = false
        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if breakTimeRemaining > 0 {
                breakTimeRemaining -= 1
                totalFocusTime -= 1
            } else if totalFocusTime > 0 {
                timer?.invalidate() // Stop the break timer when time is up
                playBellSound() // Play ring bell sound
                timeRemaining = focusTimePerCycle // Reset focus timer
                startTimer() // Start the focus timer again
            } else {
                timer?.invalidate() // Stop the timer when total time is up
                timerRunning = false
            }
        }
    }
    
    func togglePause() {
        if paused {
            paused = false
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if isBreak {
                    if breakTimeRemaining > 0 {
                        breakTimeRemaining -= 1
                        totalFocusTime -= 1
                    } else if totalFocusTime > 0 {
                        timer?.invalidate()
                        playBellSound()
                        timeRemaining = focusTimePerCycle // Reset focus timer
                        startTimer() // Start the focus timer again
                    } else {
                        timer?.invalidate() // Stop the timer when total time is up
                        timerRunning = false
                    }
                } else {
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                        totalFocusTime -= 1
                    } else if totalFocusTime > 0 {
                        timer?.invalidate()
                        playBellSound()
                        startBreakTimer()
                    } else {
                        timer?.invalidate() // Stop the timer when total time is up
                        timerRunning = false
                    }
                }
            }
        } else {
            paused = true
            timer?.invalidate() // Pause the timer
        }
    }
    
    func resetTimer() {
        timer?.invalidate() // Stop any running timer
        totalFocusTime = (selectedHour * 3600) + (selectedMinute * 60) + selectedSecond
        focusTimePerCycle = totalFocusTime / max(1, numberOfBreaks) // Divide focus time by number of breaks
        timeRemaining = focusTimePerCycle
        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
        isBreak = false
        paused = false
        currentCycle = 0
        if totalFocusTime > 0 {
            startTimer() // Start the main timer
        }
    }
    
    // Play bell sound when the timer finishes
    func playBellSound() {
        guard let url = Bundle.main.url(forResource: "bell", withExtension: "mp3") else {
            print("Bell sound file not found.")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    // Helper to format time in mm:ss
    func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @ViewBuilder
    private func timerDisplay(timeRemaining: Int) -> some View {
        ZStack {
            Circle()
                .frame(width: 250.0, height: 250.0)
                .foregroundColor(Color("backgroundLight"))
            
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .foregroundColor(Color("buttonsColor"))
            
            let totalTime = isBreak ? ((selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB) : focusTimePerCycle
            
            Circle()
                .trim(from: 0.0, to: CGFloat(Double(totalTime - timeRemaining) / Double(totalTime)))
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
                .rotationEffect(Angle(degrees: -90.0)) // Rotate to start from 12 o'clock position
                .animation(.linear, value: timeRemaining)
            
            Text(formatTime(seconds: timeRemaining))
                .font(.largeTitle)
                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
        }
        .frame(width: 200, height: 200)
    }
}
*/
///ضبط منبه انتهاء التركيز

import SwiftUI
import AVFoundation

struct TimerView: View {
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    @Binding var selectedSecond: Int
    
    @Binding var selectedHourB: Int
    @Binding var selectedMinuteB: Int
    @Binding var selectedSecondB: Int
    
    @Binding var numberOfBreaks: Int
    
    @State private var focusTimePerCycle: Int = 0
    @State private var timeRemaining: Int = 0
    @State private var breakTimeRemaining: Int = 0
    @State private var timerRunning = false
    @State private var paused = false
    @State private var isBreak = false
    @State private var currentCycle = 0
    @State private var timer: Timer?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var totalFocusTime: Int = 0
    @State private var showAlert = false // حالة للتنبيه
    @State private var isEndOfFocus = false // حالة لتحديد نهاية وقت التركيز

    var body: some View {
        ZStack {
            // Set the background image
            Image("FocusTime")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Header for returning back to main page
                HStack {
                    Button(action: {
                        // Action for going back to the main page
                    }) {
                        
                    }
                    Spacer()
                }
                .padding(.horizontal, 40)
                
                Spacer()
                
                // Main Timer Display
                timerDisplay(timeRemaining: isBreak ? breakTimeRemaining : timeRemaining)
                
                Spacer()
                Text(isBreak ? "استرخ لقد انجزت الكثير  " : "ركز معنا وقتك ثمين")
                .fontWeight(.bold)
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
                
                Spacer()
                
                // Control Buttons
                HStack {
                    // Restart button
                    Button(action: {
                        paused = false
                        resetTimer()
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("backgroundLight"))
                            .padding()
                            .background(Color("buttonsColor").clipShape(Circle()))
                    }
                    
                    Spacer()
                    
                    // Pause/Play button
                    Button(action: {
                        togglePause()
                    }) {
                        Image(systemName: paused ? "play.fill" : "pause.fill")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("backgroundLight"))
                            .padding()
                            .background(Color("buttonsColor").clipShape(Circle()))
                    }
                }
                .padding(.all, 100.0)
            }
            .onAppear {
                resetTimer()
            }
            .alert(isPresented: $showAlert) { // إضافة التنبيه هنا
                Alert(title: Text("وقت التركيز انتهى"),
                      message: Text("ابدأ فترة الاستراحة الآن!"),
                      dismissButton: .default(Text("موافق")) {
                          startBreakTimer() // بدء فترة الاستراحة عند الضغط على "موافق"
                      })
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    // Timer-related functions
    func startTimer() {
        timerRunning = true
        paused = false
        isBreak = false
        timeRemaining = focusTimePerCycle
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
                totalFocusTime -= 1
            } else if totalFocusTime > 0 {
                timer?.invalidate() // Stop the timer when time is up
                playBellSound() // Play ring bell sound
                showAlert = true // عرض التنبيه عند انتهاء الوقت
                isEndOfFocus = true // تحديد نهاية وقت التركيز
            } else {
                timer?.invalidate() // Stop the timer when total time is up
                timerRunning = false
            }
        }
    }
    
    func startBreakTimer() {
        if isEndOfFocus { // تحقق مما إذا كان قد انتهى وقت التركيز
            isBreak = true
            timerRunning = true
            paused = false
            breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if breakTimeRemaining > 0 {
                    breakTimeRemaining -= 1
                    totalFocusTime -= 1
                } else if totalFocusTime > 0 {
                    timer?.invalidate() // Stop the break timer when time is up
                    playBellSound() // Play ring bell sound
                    timeRemaining = focusTimePerCycle // Reset focus timer
                    startTimer() // Start the focus timer again
                } else {
                    timer?.invalidate() // Stop the timer when total time is up
                    timerRunning = false
                }
            }
        }
    }
    
    func togglePause() {
        if paused {
            paused = false
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if isBreak {
                    if breakTimeRemaining > 0 {
                        breakTimeRemaining -= 1
                        totalFocusTime -= 1
                    } else if totalFocusTime > 0 {
                        timer?.invalidate()
                        playBellSound()
                        isEndOfFocus = false // إعادة تعيين حالة نهاية التركيز
                        timeRemaining = focusTimePerCycle // Reset focus timer
                        startTimer() // Start the focus timer again
                    } else {
                        timer?.invalidate() // Stop the timer when total time is up
                        timerRunning = false
                    }
                } else {
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                        totalFocusTime -= 1
                    } else if totalFocusTime > 0 {
                        timer?.invalidate()
                        playBellSound()
                        showAlert = true // عرض التنبيه عند انتهاء الوقت
                        isEndOfFocus = true // تحديد نهاية وقت التركيز
                    } else {
                        timer?.invalidate() // Stop the timer when total time is up
                        timerRunning = false
                    }
                }
            }
        } else {
            paused = true
            timer?.invalidate() // Pause the timer
        }
    }
    
    func resetTimer() {
        timer?.invalidate() // Stop any running timer
        totalFocusTime = (selectedHour * 3600) + (selectedMinute * 60) + selectedSecond
        focusTimePerCycle = totalFocusTime / max(1, numberOfBreaks) // Divide focus time by number of breaks
        timeRemaining = focusTimePerCycle
        breakTimeRemaining = (selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB
        isBreak = false
        paused = false
        currentCycle = 0
        isEndOfFocus = false // إعادة تعيين حالة نهاية التركيز
        if totalFocusTime > 0 {
            startTimer() // Start the main timer
        }
    }
    
    // Play bell sound when the timer finishes
    func playBellSound() {
        guard let url = Bundle.main.url(forResource: "bell", withExtension: "mp3") else {
            print("Bell sound file not found.")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    // Helper to format time in mm:ss
    func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @ViewBuilder
    private func timerDisplay(timeRemaining: Int) -> some View {
        ZStack {
            Circle()
                .frame(width: 250.0, height: 250.0)
                .foregroundColor(Color("backgroundLight"))
            
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .foregroundColor(Color("buttonsColor"))
            
            let totalTime = isBreak ? ((selectedHourB * 3600) + (selectedMinuteB * 60) + selectedSecondB) : focusTimePerCycle
            
            Circle()
                .trim(from: 0.0, to: CGFloat(Double(totalTime - timeRemaining) / Double(totalTime)))
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
                .rotationEffect(Angle(degrees: -90.0)) // Rotate to start from 12 o'clock position
                .animation(.linear, value: timeRemaining)
            
            Text(formatTime(seconds: timeRemaining))
                .font(.largeTitle)
                .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)))
        }
        .frame(width: 200, height: 200)
    }
}


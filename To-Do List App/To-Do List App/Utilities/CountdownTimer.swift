//
//  CountdownTimer.swift
//  To-Do List App
//
//  Created by Alihan on 21.04.2025.
//

import SwiftUI

class CountdownTimer: ObservableObject {
    @Published var timeRemaining: String = ""
    @Published var timeIsUp: Int = -1
    
    var targetDate: Date
    private var timer: Timer?

    init(targetDate: Date) {
        self.targetDate = targetDate
        startTimer()
    }

    private func startTimer() {
        updateRemainingTime()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateRemainingTime()
        }
    }

    private func updateRemainingTime() {
        let now = Date()
        let interval = targetDate.timeIntervalSince(now)
        let remaining: TimeInterval
        
        let redLimit = (UserDefaults.standard.double(forKey: "redHours")) * 3600
        let yellowLimit = (UserDefaults.standard.double(forKey: "yellowDays")) * 86400

        if interval < 0 {
            remaining = 0
        } else {
            remaining = interval
        }
        
        if remaining <= 0 {
            self.timeRemaining = "Time is up!"
            timeIsUp = 0
            timer?.invalidate()
        } else {
            let hours = Int(remaining) / 3600
            let minutes = (Int(remaining) % 3600) / 60
            let seconds = Int(remaining) % 60
            
            
            if remaining <= 0 {
                timeIsUp = 0
            } else if remaining <= redLimit {
                timeIsUp = 3
            } else if remaining <= yellowLimit {
                timeIsUp = 2
            } else {
                timeIsUp = 1
            }

            
            self.timeRemaining = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }

    deinit {
        timer?.invalidate()
    }
}

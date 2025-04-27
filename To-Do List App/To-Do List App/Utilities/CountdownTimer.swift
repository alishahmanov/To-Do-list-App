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
        let remaining = max(0, targetDate.timeIntervalSince(now))
        
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
            } else if remaining <= 86400 {
                timeIsUp = 3 
            } else if remaining <= 259200 {
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

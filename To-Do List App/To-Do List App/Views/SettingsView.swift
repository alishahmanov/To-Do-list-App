//
//  SettingsView.swift
//  To-Do List App
//
//  Created by Alihan on 28.04.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("redHours") var redHours: Double = 1
    @AppStorage("yellowDays") var yellowDays: Double = 1
    
    var body: some View {
        ZStack {
            Color.mainBackground1.ignoresSafeArea(.all)
            HStack {
                VStack {
                    Text("Red Deadline:")
                        .padding()
                        .padding(.bottom, 20)
                        .padding(.top, 30)
                        .foregroundColor(.buttonColor)
                    Text("Yellow Deadline:")
                        .padding()
                        .padding(.top, 20)
                        .foregroundColor(.buttonColor)
                }
                .padding(.bottom, 500)
                VStack {
                    VStack {
                        Text ("\(Int(redHours)) hours")
                            .foregroundColor(.buttonColor)
                        Slider(value: $redHours, in: 0...24)
                            .padding(.horizontal, 20)
                    }
                    .padding()
                    VStack {
                        Text ("\(Int(yellowDays)) days")
                            .foregroundColor(.buttonColor)
                        Slider(value: $yellowDays, in: 1...5)
                            .padding(.horizontal, 20)
                    }
                    .padding()
                }
                .padding(.bottom, 500)
            }
            .navigationBarBackButtonHidden(true)
            .frame(width: 410, height: 740)
        }
    }
}


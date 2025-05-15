//
//  SideMenuView.swift
//  To-Do List App
//
//  Created by Alihan on 25.04.2025.
//
import SwiftUI

struct SideMenuView: View {
    @Binding var showSettingsScreen: Bool
    @Binding var showDoneTask: Bool

    var body: some View {
        ZStack {
            Color.circleCardBackground.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showSettingsScreen = false
                        showDoneTask = false
                    }
                } label: {
                    Text("Main")
                        .foregroundColor(.buttonColor)
                }
                .padding(.top, 10)
                .padding()
                Divider()
                    .background(Color.dividerColor)
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showSettingsScreen = true
                        showDoneTask = false
                    }
                } label: {
                    Text("Settings")
                        .foregroundColor(.buttonColor)
                }
                .padding()
                Divider()
                    .background(Color.dividerColor)
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showDoneTask = true
                        showSettingsScreen = false
                    }
                } label: {
                    Text("Completed Tasks")
                        .foregroundColor(.buttonColor)

                }
                .padding()
                Spacer()
            }
        }
    }
}


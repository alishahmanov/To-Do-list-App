//
//  ContentView.swift
//  To-Do List App
//
//  Created by Alihan on 24.03.2025.
//

import SwiftUI

extension Color {
    static let appBlue = Color(red: 14/255, green: 200/255, blue: 255/255)
}

struct ContentView: View {
    var body: some View {
        Text("Nothing to see here...")
    }
}

struct WelcomeScreenView: View {
    @State private var width: CGFloat = 150
    @State private var height: CGFloat = 150
    @State private var checkMarkX: CGFloat = 0
    @State private var textX: CGFloat = -500
    @State private var nextScreen: Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
                NavigationLink(destination: ContentView(), isActive: $nextScreen) {
                    EmptyView()
                }
                
                Text("Welcome to To-Do List App!")
                    .font(.system(size: 22, weight: .bold, design: .default))
                    .offset(x: textX, y: 0)
                    .background(
                        Text("Welcome to To-Do List App!")
                            .font(.system(size: 22, weight: .bold, design: .default))
                            .foregroundColor(
                                Color.gray
                                    .opacity(0.5)
                            )
                            .offset(x: textX-2, y: 3)
                    )
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: width, height: height)
                    .offset(x: checkMarkX, y: 0)
                    .background(
                        Circle()
                            .foregroundColor(.appBlue)
                            .offset(x: checkMarkX, y: 0)
                    )
                    .onTapGesture {
                        startAnimation()
                    }
            }
        }
    }
    
    func startAnimation() {
           withAnimation(.easeInOut(duration: 0.5)) {
               width = 190
               height = 190
           }

           DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
               withAnimation(.easeInOut(duration: 0.5)) {
                   width = 150
                   height = 150
               }

               DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                   withAnimation(.easeInOut(duration: 0.5)) {
                       width = 50
                       height = 50
                       checkMarkX = 150
                   }

                   DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                       withAnimation(.easeInOut(duration: 0.5)) {
                           textX = -25
                       }

                       DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                           nextScreen = true
                       }
                   }
               }
           }
       }
}

#Preview {
    WelcomeScreenView()
}

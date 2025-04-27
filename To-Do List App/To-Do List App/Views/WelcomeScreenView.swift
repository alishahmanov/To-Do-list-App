//
//  WelcomeScreenView.swift
//  To-Do List App
//
//  Created by Alihan on 21.04.2025.
//


import SwiftUI

struct WelcomeScreenView: View {
    @State private var width: CGFloat = 150
    @State private var height: CGFloat = 150
    @State private var checkMarkX: CGFloat = 0
    @State private var textX: CGFloat = -500
    @State private var nextScreen: Bool = false
    @State private var scale: CGFloat = 1.0
    @State private var checkmarkAnimation: Bool = true
    @ObservedObject var coordinates: ImportanceCirclesCoordinates
    @ObservedObject var viewModel: TaskViewModel

    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            NavigationStack {
                ZStack {
                    Color.backgroundColor
                        .ignoresSafeArea()
                    NavigationLink(destination: ContentView( coordinates: coordinates, viewModel: viewModel), isActive: $nextScreen) {
                        EmptyView()
                    }
                    
                    Text("Welcome to To-Do List App!")
                        .foregroundColor(.nameTaskColor)
                        .font(.system(size: 22, weight: .bold, design: .default))
                        .offset(x: textX, y: 0)
                    if checkmarkAnimation {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .foregroundColor(.backgroundColor)
                            .frame(width: width, height: height)
                            .offset(x: checkMarkX)
                            .scaleEffect(scale)
                            .background(
                                Circle()
                                    .frame(width: 145, height: 145)
                                    .scaleEffect(scale)
                                    .foregroundColor(.buttonColor)
                                    .offset(x: checkMarkX, y: 0)
                            )
                            .onAppear {
                                withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                                    scale = 1.2
                                }
                            }
                            .onTapGesture {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        checkmarkAnimation = false
                                        width = 160
                                        height = 160
                                        startAnimation()
                                    }
                                }
                            }
                    } else {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .foregroundColor(.backgroundColor)
                            .frame(width: width, height: height)
                            .offset(x: checkMarkX)
                            .scaleEffect(1.0)
                            .background(
                                Circle()
                                    .frame(width: width-10, height: height-10)
                                    .foregroundColor(.buttonColor)
                                    .offset(x: checkMarkX, y: 0)
                            )
                    }
                }
            }
        }
    }
    
    func startAnimation() {
           withAnimation(.easeInOut(duration: 0.5)) {
               width = 120
               height = 120
           }

           DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
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
                           withAnimation(.easeInOut(duration: 1)) {
                               textX = -25
                           }
                           
                           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                               nextScreen = true
                           }
                       }
                   }
               }
           }
       }
}

#Preview {
    ContentView(
        coordinates: ImportanceCirclesCoordinates(),
        viewModel: TaskViewModel()
    )
}

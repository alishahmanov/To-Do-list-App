//
//  MenuBlueRectangleView.swift
//  To-Do List App
//
//  Created by Alihan on 21.04.2025.
//


import SwiftUI

struct MenuBlueRectangleView: View {
    @ObservedObject var coordinates: ImportanceCirclesCoordinates
    @Binding var showAddScreen: Bool
    @Binding var showSideMenu: Int
    @Binding var isSideBar: Bool
    var body: some View {
        Rectangle()
            .fill(Color.backgroundColor)
            .frame(maxWidth: .infinity, minHeight: 145, maxHeight: 145)
            .overlay(
                HStack {
                    Button {
                        toggleSideBar()
                    } label: {
                        VStack {
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 40, height: 4)
                                .foregroundColor(Color.buttonColor)
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 30, height: 3)
                                .foregroundColor(Color.buttonColor)
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 20, height: 2)
                                .foregroundColor(Color.buttonColor)
                            
                        }
                        .overlay(
                            Circle()
                                .stroke(Color.buttonColor, lineWidth: 3)
                                .frame(width: 55, height: 55)
                                .blur(radius: 20)
                        )
                    }
                    .padding()
                    .padding(.top, 50)
                    .padding(.leading, 5)

                    Spacer()
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showAddScreen.toggle()
                            
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            coordinates.isEasy = false
                            coordinates.isMedium = true
                            coordinates.isHard = false
                        }

                    } label: {
                        Circle()
                            .fill(Color.buttonColor)
                            .frame(width: 35, height: 35)
                            .overlay(
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                            )
                            .background(
                                Circle()
                                    .stroke(Color.buttonColor, lineWidth: 4)
                                    .frame(width: 45, height: 45)
                                    .blur(radius: 19)
                                
                            )
                    }
                    .padding()
                    .padding(.trailing, 5)
                    .padding(.top, 50)
                }
                )
        
    }
    func toggleSideBar() {
        if isSideBar == false {
            withAnimation(.easeInOut(duration: 0.5)) {
                showSideMenu = showSideMenu + 200
            }
        } else {
            withAnimation(.easeInOut(duration: 0.5)) {
                showSideMenu = showSideMenu - 200
            }
        }
        isSideBar.toggle()
    }
}

#Preview {
    ContentView(
        coordinates: ImportanceCirclesCoordinates(),
        viewModel: TaskViewModel()
    )
}

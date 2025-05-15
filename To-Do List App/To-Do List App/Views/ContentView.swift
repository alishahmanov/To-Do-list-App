//
//  ContentView.swift
//  To-Do List App
//
//  Created by Alihan on 21.04.2025.
//


import SwiftUI

struct ContentView: View {
    @State private var showAddScreen: Bool = false
    @State private var showSideMenu: Int = -300
    @State private var showSettingsScreen: Bool = false
    @State private var showDoneTasks: Bool = false
    @StateObject var coordinates = ImportanceCirclesCoordinates()
    @StateObject var taskCharacteristics = TaskCharacteristics()
    @StateObject var viewModel = TaskViewModel()
    @State var isSideBar: Bool = false
    var body: some View {
        
        ZStack {
            Color.mainBackground1
                .ignoresSafeArea()

            VStack {
                MenuBlueRectangleView(coordinates: coordinates, showAddScreen: $showAddScreen, showSideMenu: $showSideMenu, isSideBar: $isSideBar)
                Group {
                    if showSettingsScreen {
                        SettingsView()
                            .padding(.bottom, 10)
                            .transition(.opacity)
                    } else if showDoneTasks {
                        CompletedTaskView(viewModel: viewModel)
                            .padding(.bottom, 10)
                            .transition(.opacity)
                    } else {
                        ListOfTasksView(showAddScreen: $showAddScreen, coordinates: coordinates, taskCharacteristics: taskCharacteristics, viewModel: viewModel)
                            .padding(.bottom, 10)
                    }
                }
            }
            
            SideMenuView(showSettingsScreen: $showSettingsScreen, showDoneTask: $showDoneTasks)
                .frame(width: 200, height: 700)
                .offset(x: CGFloat(showSideMenu), y: 44)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                showAddScreen = false
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

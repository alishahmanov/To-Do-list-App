//
//  ListOfTasksView.swift
//  To-Do List App
//
//  Created by Alihan on 21.04.2025.
//


import SwiftUI

struct ListOfTasksView: View {
    @Binding var showAddScreen: Bool
//    @Binding var showSideMenu: Int
    @ObservedObject var coordinates: ImportanceCirclesCoordinates
    @ObservedObject var taskCharacteristics: TaskCharacteristics
    @ObservedObject var viewModel: TaskViewModel
    
    var body: some View {
        ZStack() {
            VStack() {
                if viewModel.notes.isEmpty {
                    Text("No tasks yet")
                        .foregroundColor(.buttonColor)
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.notes) { note in
                            TaskCardView(task: note)
                                .padding(.bottom,5)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.mainBackground1)
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button {
                                        withAnimation {
                                            viewModel.deleteTask(at: note)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.importanceRed)
                                    Button {
                                        print("done")
                                    } label: {
                                        Label("Done", systemImage: "checkmark")
                                    }
                                    .tint(.importanceGreen)
                                }
 
                        }                        
                    }
                    .listStyle(PlainListStyle())
                }
            }
            
            .frame(width: 410, height: 740)
            .navigationBarBackButtonHidden(true)
            
            if showAddScreen {
                AddNewTaskView(showAddScreen: $showAddScreen, coordinates: coordinates, taskCharacteristics: taskCharacteristics, viewModel: viewModel)
                    .frame(width: 350, height: 510)
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.buttonColor, lineWidth: 2)
                    )
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(1)
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

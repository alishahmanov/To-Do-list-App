//
//  CompletedTaskView.swift
//  To-Do List App
//
//  Created by Alihan on 14.05.2025.
//

import SwiftUI

struct CompletedTaskView: View {
    @ObservedObject var viewModel: TaskViewModel
    var body: some View {
        ZStack {        
            VStack {
                if viewModel.completedNotes.isEmpty {
                    Text("No completed tasks")
                        .foregroundColor(.buttonColor)
                } else {
                    List {
                        ForEach(viewModel.completedNotes) { note in
                            TaskCardView(task: note)
                                .padding(.bottom,5)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.mainBackground1)
                                .swipeActions(edge: .trailing) {
                                    Button {
                                        viewModel.deleteCompletedTask(at: note)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.importanceRed)
                                }
                            
                        }
                    }
                    .listStyle(PlainListStyle())

                }
            }
            .navigationBarBackButtonHidden(true)
            .frame(width: 410, height: 740)
        }
    }
}
#Preview {
    ContentView(
        coordinates: ImportanceCirclesCoordinates(),
        viewModel: TaskViewModel()
    )
}

//
//  AddNewTaskView.swift
//  To-Do List App
//
//  Created by Alihan on 21.04.2025.
//


import SwiftUI

struct AddNewTaskView: View {
    @State var x: CGFloat = 0
    @State var y: CGFloat = 0
    @State var showAlert: Bool = false
    @Binding var showAddScreen: Bool
    @ObservedObject var coordinates: ImportanceCirclesCoordinates
    @ObservedObject var taskCharacteristics: TaskCharacteristics
    @ObservedObject var viewModel: TaskViewModel
    
    
    var body: some View {
        ZStack {
            VStack {
                FielderView(text: "Name the task", placeholder: $taskCharacteristics.taskName, fieldText: "Name")
                    .frame(width: 360)
                FielderView(text: "Description (optional)", placeholder: $taskCharacteristics.taskDescription, fieldText: "Description")
                    .frame(width: 360)
                DatePicker("Deadline", selection: $taskCharacteristics.selectedDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .padding(8)
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                    .foregroundColor(.nameTaskColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.buttonColor, lineWidth: 1)
                            .padding(.horizontal, 10)
                            .padding(.top, 10)
                    )
                    .frame(width: 360)
                
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.buttonColor, lineWidth: 1)
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                    .frame(height: 150)
                    .overlay(
                        HStack {
                            Text("Importance")
                                .foregroundColor(.nameTaskColor)
                                .padding(.leading, 25)
                                .padding(.trailing, 50)
                            Spacer()
                            HStack {
                                Button {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        if x == 0 {
                                            x = x - 60
                                            coordinates.isEasy = false
                                            coordinates.isMedium = false
                                            coordinates.isHard = true
                                        }
                                        else if x == -60 {
                                            x = 60
                                            coordinates.isEasy = true
                                            coordinates.isMedium = false
                                            coordinates.isHard = false
                                        }
                                        else if x == 60 {
                                            x = 0
                                            coordinates.isEasy = false
                                            coordinates.isMedium = true
                                            coordinates.isHard = false
                                        }
                                    }
                                } label: {
                                    LeftButton()
                                        .stroke(Color.buttonColor, lineWidth: 2)
                                        .frame(width: 25, height: 25)
                                }
                                
                            }
                            
                            ImportanceView(coordinates: coordinates)
                                .frame(width: 50)
                                .offset(x: x, y: y)
                            HStack {
                                Button {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        if x == 0 {
                                            x = x + 60
                                            coordinates.isEasy = true
                                            coordinates.isMedium = false
                                            coordinates.isHard = false
                                        }
                                        else if x == 60 {
                                            x = -60
                                            coordinates.isEasy = false
                                            coordinates.isMedium = false
                                            coordinates.isHard = true
                                        }
                                        else if x == -60 {
                                            x = 0
                                            coordinates.isEasy = false
                                            coordinates.isMedium = true
                                            coordinates.isHard = false
                                        }
                                    }
                                } label: {
                                    RightButton()
                                        .stroke(Color.buttonColor, lineWidth: 2)
                                        .frame(width: 25, height: 25)
                                }
                            }
                            Spacer()
                        }
                    )
                    .frame(width: 360)
                
                Button {
                    
                    if taskCharacteristics.taskName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        showAlert = true
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            coordinates.isEasy = false
                            coordinates.isMedium = true
                            coordinates.isHard = false
                        }
                        
                        let importanceLevel = whichImportanceLevel()
                        
                        
                        viewModel.addNote(
                            name: taskCharacteristics.taskName,
                            description: taskCharacteristics.taskDescription,
                            deadline: taskCharacteristics.selectedDate,
                            importance: importanceLevel
                        )
                        
                        taskCharacteristics.taskName = ""
                        taskCharacteristics.taskDescription = ""
                        taskCharacteristics.selectedDate = Date()
                        
                        
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showAddScreen = false
                        }
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.buttonColor)
                            .frame(width: 350, height: 50)
                        Text("Add Task")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"),
                          message: Text("Put a task name!"),
                          dismissButton: .default(Text("OK")))
                }
                .padding()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 17/255, green: 43/255, blue: 80/255))
                    .shadow(radius: 10)
            )
        }
        .frame(width: 380, height: 200)
    }
    
    func whichImportanceLevel() -> String {
        if coordinates.isEasy { return "Easy" }
        else if coordinates.isMedium { return "Medium" }
        else if coordinates.isHard { return "Hard" }
        else {
            print("Wrong value")
            return "Unknown"
        }
    }

}

#Preview {
    ContentView(
        coordinates: ImportanceCirclesCoordinates(),
        viewModel: TaskViewModel()
    )
}

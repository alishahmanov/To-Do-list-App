//
//  TaskViewModel.swift
//  To-Do List App
//
//  Created by Alihan on 21.04.2025.
//
import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var notes: [TaskItem] = []
    @Published var completedNotes: [TaskItem] = []
    private let keyActive = "tasks_active"
    private let keyCompleted = "tasks_completed"

    
    init() {
        loadTasks()
    }
    func loadTasks() {
        if let activeData = UserDefaults.standard.data(forKey: keyActive) {
            if let decodedActive = try? JSONDecoder().decode([TaskItem].self, from: activeData) {
                notes = decodedActive
            }
        }
        if let completedData = UserDefaults.standard.data(forKey: keyCompleted) {
            if let decodedCompleted = try? JSONDecoder().decode([TaskItem].self, from: completedData) {
                completedNotes = decodedCompleted
            }
        }
    }
    
    func makeCompleted(task: TaskItem) {
        if let index = notes.firstIndex(of: task) {
            let remainingTime = CountdownTimer(targetDate: task.deadline).timeRemaining
            var completedTask = task
            completedTask.isCompleted = true
            completedTask.timeCompleted = remainingTime
            completedNotes.append(completedTask)
            notes.remove(at: index)
            saveTasks()
        }
    }

    func saveTasks() {
        if let activeEncoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(activeEncoded, forKey: keyActive)
        } else {
            print("error")
        }
        if let completedEncoded = try? JSONEncoder().encode(completedNotes) {
            UserDefaults.standard.set(completedEncoded, forKey: keyCompleted)
        } else {
            print("error")
        }
    }
    func addNote(name: String, description: String, deadline: Date, importance: String) {
        let newTask = TaskItem(name: name, description: description, deadline: deadline, importance: importance, isCompleted: false)
        notes.append(newTask)
        saveTasks()
    }
    func deleteTask(at offset: IndexSet) {
        notes.remove(atOffsets: offset)
        saveTasks()
    }
    
    func deleteTask(at task: TaskItem) {
        if let index = notes.firstIndex(where: { $0.id == task.id }) {
            notes.remove(at: index)
            saveTasks()
        }
    }
    func deleteCompletedTask(at task: TaskItem) {
        if let index = completedNotes.firstIndex(where: { $0.id == task.id}) {
            completedNotes.remove(at: index)
            saveTasks()
        }
    }
}
    
    
   

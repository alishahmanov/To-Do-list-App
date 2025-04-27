//
//  TaskViewModel.swift
//  To-Do List App
//
//  Created by Alihan on 21.04.2025.
//
import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var notes: [TaskItem] = []
    private let key = "tasks"
    
    init() {
        if let savedData = UserDefaults.standard.data(forKey: key) {
            do {
                notes = try JSONDecoder().decode([TaskItem].self, from: savedData)
            } catch {
                print("error:\(error)")
            }
        }
    }
    func saveTasks() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: key)
        } else {
            print("error")
        }
    }
    func addNote(name: String, description: String, deadline: Date, importance: String) {
        let newTask = TaskItem(name: name, description: description, deadline: deadline, importance: importance)
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
}
    
    
   

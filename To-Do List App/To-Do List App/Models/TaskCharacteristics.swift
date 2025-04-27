//
//  TaskCharacteristics.swift
//  To-Do List App
//
//  Created by Alihan on 21.04.2025.
//
import SwiftUI

class TaskCharacteristics: ObservableObject {
    @Published var taskName: String = ""
    @Published var taskDescription: String = ""
    @Published var isImportant: Bool = false
    @Published var selectedDate: Date = Date()
    
}

//
//  TaskItem.swift
//  To-Do List App
//
//  Created by Alihan on 21.04.2025.
//

import SwiftUI

struct TaskItem: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var description: String
    var deadline: Date
    var importance: String
}

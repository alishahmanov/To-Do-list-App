//
//  ImportanceCirclesCoordinates.swift
//  To-Do List App
//
//  Created by Alihan on 21.04.2025.
//
import SwiftUI

class ImportanceCirclesCoordinates: ObservableObject {
    @Published var easyX: CGFloat = -10
    @Published var isEasy: Bool = true
    @Published var mediumX: CGFloat = -5
    @Published var isMedium: Bool = true
    @Published var hardX: CGFloat = 0
    @Published var isHard: Bool = true
}

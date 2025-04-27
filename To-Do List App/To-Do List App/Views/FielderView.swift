//
//  FielderView.swift
//  To-Do List App
//
//  Created by Alihan on 21.04.2025.
//


import SwiftUI

struct FielderView: View {
    var text: String
    @Binding var placeholder: String
    var fieldText: String
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(Color.nameTaskColor)
                .padding(.leading, 14)
                .padding(.top, 20)
            Spacer()
        }
        TextField(fieldText, text: $placeholder)
            .foregroundColor(Color.descriptionTaskColor)
            .padding(8)
            .padding(.horizontal, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.buttonColor, lineWidth: 1)
                    .padding(.horizontal, 10)
                )
    }
}

#Preview {
    ContentView(
        coordinates: ImportanceCirclesCoordinates(),
        viewModel: TaskViewModel()
    )
}

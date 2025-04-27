//
//  ImportanceView.swift
//  To-Do List App
//
//  Created by Alihan on 21.04.2025.
//


import SwiftUI

struct ImportanceView: View {
    @ObservedObject var coordinates: ImportanceCirclesCoordinates
    var body: some View {
            HStack {
                Spacer()
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(coordinates.isEasy ? Color.buttonColor : Color.clear)
                    .offset(x: -18, y: 0)
                HStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(coordinates.isMedium ? Color.buttonColor : Color.clear)
                        .offset(x: 0, y: 0)
                        .padding(.trailing, 5)
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(coordinates.isMedium ? Color.buttonColor : Color.clear)
                        .offset(x: -10, y: 0)
                    
                }
                ZStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(coordinates.isHard ? Color.buttonColor : Color.clear)
                        .offset(x: -10, y: -15)
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(coordinates.isHard ? Color.buttonColor : Color.clear)
                        .offset(x: 20, y: -15)
                    Image(systemName: "star.fill")
                        .resizable()

                        .frame(width: 25, height: 25)
                        .foregroundColor(coordinates.isHard ? Color.buttonColor : Color.clear)
                        .offset(x: 5 ,  y: 10)
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

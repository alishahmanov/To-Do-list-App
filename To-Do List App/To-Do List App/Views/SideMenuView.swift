//
//  SideMenuView.swift
//  To-Do List App
//
//  Created by Alihan on 25.04.2025.
//
import SwiftUI

struct SideMenuView: View {
    var body: some View {
        ZStack {
            Color.circleCardBackground.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                Button {
                    print("Show")
                } label: {
                    Text("Main")
                        .foregroundColor(.buttonColor)
                }
                .padding(.top, 10)
                .padding()
                Divider()
                    .background(Color.dividerColor)
                Button {
                    print("Show")
                } label: {
                    Text("Settings")
                        .foregroundColor(.buttonColor)
                }
                .padding()
                Divider()
                    .background(Color.dividerColor)
                Button {
                    print("Show")
                } label: {
                    Text("Completed Tasks")
                        .foregroundColor(.buttonColor)

                }
                .padding()
                Spacer()
            }
        }
    }
}

#Preview {
    SideMenuView()
}

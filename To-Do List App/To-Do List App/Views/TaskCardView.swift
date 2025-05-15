//
//  TaskCardView.swift
//  To-Do List App
//
//  Created by Alihan on 21.04.2025.
//


import SwiftUI

struct TaskCardView: View {
    let task: TaskItem
    @State private var scale: CGFloat = 1.0
    @State private var isExpanded = false
    @StateObject private var timer: CountdownTimer

    init(task: TaskItem) {
        self.task = task
        _timer = StateObject(wrappedValue: CountdownTimer(targetDate: task.deadline))
    }

    var baseColor: Color {
        if task.isCompleted {
            return .buttonColor
        } else {
            if timer.timeIsUp == 1 {
                return .importanceGreen
            } else if timer.timeIsUp == 2 {
                return .importanceYellow
            } else if timer.timeIsUp == 3 {
                return .importanceRed
            } else {
                return .gray
            }
        }
    }
    var starsImportance: Int {
        switch task.importance {
        case "Easy": return 1
        case "Medium": return 2
        case "Hard": return 3
        default: return 0
        }
    }

    var animatedColor: Color {
        isExpanded ? baseColor : baseColor.opacity(0.5)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(task.name)
                    .foregroundColor(.nameTaskColor)
                    .font(.headline)
                Text(task.description)
                    .font(.subheadline)
                    .foregroundColor(.descriptionTaskColor)
                    .lineLimit(1)
                if starsImportance == 1 {
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(Color.importanceTaskColor)
                        .frame(width: 20, height: 20)
                        .padding(.top, 5)                    
                }
                else if starsImportance == 2 {
                    HStack {
                        ForEach(0..<2) { _ in
                            Image(systemName: "star.fill")
                                .resizable()
                                .foregroundColor(Color.importanceTaskColor)
                                .frame(width: 20, height: 20)
                        }
                    }
                    .padding(.top, 5)
                    
                }
                else if starsImportance == 3 {
                    HStack {
                        ForEach(0..<3) { _ in
                            Image(systemName: "star.fill")
                                .resizable()
                                .foregroundColor(Color.importanceTaskColor)
                                .frame(width: 20, height: 20)
                        }
                    }
                    .padding(.top, 5)
                }
                if task.isCompleted, let timeDone = task.timeCompleted {
                    Text("Task was done \(timeDone) early")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                } else {
                    Text("\(timer.timeRemaining)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(timer.timeIsUp == 3 ? .importanceRed : .white)
                        .padding(.top, 10)
                }
                Text("Deadline: \(task.deadline.formatted(date: .abbreviated, time: .omitted))")
                    .font(.caption)
                    .foregroundColor(.deadlineTextColor)
            }
            
            Spacer()
            
            ZStack {
                if task.isCompleted {
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(.buttonColor)
                        .frame(width: 35, height: 35)
                } else {
                    Circle()
                        .fill(animatedColor)
                        .frame(width: 35, height: 35)
                        .scaleEffect(scale)
                        .padding(.trailing)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.0)
                                .repeatForever(autoreverses: true)
                            ) {
                                scale = 1.3
                                isExpanded.toggle()
                            }
                        }
                }
            }
        }
        .padding()
        .background(
            GeometryReader { geo in
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.cartColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(baseColor, lineWidth: 1.5)
                        )

                    Path { path in
                        let width = geo.size.width
                        let height = geo.size.height

                        let right = width
                        let top: CGFloat = 12
                        let bottom = height - 12

                        path.move(to: CGPoint(x: right-1, y: top))
                        path.addCurve(
                            to: CGPoint(x: right - 30, y: top - 11),
                            control1: CGPoint(x: right, y: top - 9),
                            control2: CGPoint(x: right - 5, y: top - 10)
                        )
                        path.addCurve(
                            to: CGPoint(x: right - 30, y: bottom+10),
                            control1: CGPoint(x: right - 150, y: top + 10),
                            control2: CGPoint(x: right - 150, y: bottom - 10)
                        )
                        path.addCurve(
                            to: CGPoint(x: right - 1, y: bottom - 10),
                            control1: CGPoint(x: right - 5, y: bottom + 10),
                            control2: CGPoint(x: right - 1, y: bottom + 15)
                        )

                        path.closeSubpath()
                    }
                    .fill(Color.circleCardBackground)
                }
            }
        )
    }
}

#Preview {
    ContentView(
        coordinates: ImportanceCirclesCoordinates(),
        viewModel: TaskViewModel()
    )
}

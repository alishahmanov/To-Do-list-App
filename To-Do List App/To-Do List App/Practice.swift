import SwiftUI

struct AnimatedView: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .scaleEffect(scale)
                .animation(.easeInOut(duration: 1.0), value: scale)
            

            Button("Animate") {
                scale += 0.5
            }
        }
    }
}


struct SwipeActionsExampleView: View {
    @State private var items = ["🍎 Apple", "🍌 Banana", "🍇 Grape"]

    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button {
                            print("Starred \(item)")
                        } label: {
                            Label("Favorite", systemImage: "star")
                        }
                        .tint(.yellow)

                        Button {
                            if let index = items.firstIndex(of: item) {
                                items.remove(at: index)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }

                    .swipeActions(edge: .leading) {
                        Button {
                            print("Shared \(item)")
                        } label: {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                        .tint(.blue)
                    }
            }
        }
        .navigationTitle("Swipe Actions")
    }
}


//#Preview {
//    SwipeActionsExampleView()
//}

//Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//    withAnimation(.easeInOut(duration: 1.0)) {
//        isExpanded.toggle()
//    }
//}

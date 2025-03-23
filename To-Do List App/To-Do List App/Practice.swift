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

#Preview {
    AnimatedView()
}

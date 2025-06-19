import SwiftUI

struct ErrorView: View {
    let errorText: String
    var onButtonTap: () -> Void

    var body: some View {
        VStack(spacing: 10) {
            Text(errorText)
            Button(action: onButtonTap) {
                Text("Retry")
            }
        }
    }
}

#Preview {
    ErrorView(errorText: "foo.error", onButtonTap: {})
}

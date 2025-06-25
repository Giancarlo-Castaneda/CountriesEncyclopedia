import SwiftUI

struct ErrorView: View {
    let errorText: LocalizedStringKey
    var onButtonTap: () -> Void

    var body: some View {
        VStack(spacing: 10) {
            Text(errorText)
            Button(action: onButtonTap) {
                Text("RETRY_BUTTON_TEXT")
            }
        }
    }
}

#Preview {
    ErrorView(errorText: "foo.error", onButtonTap: {})
}

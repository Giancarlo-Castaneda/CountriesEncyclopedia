import SwiftUI
import NukeUI

struct LazyImageView: View {

    let imageURL: URL?
    let accesibilityText: String

    var body: some View {
        LazyImage(url: imageURL) { state in
            if let image = state.image {
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .accessibilityLabel(accesibilityText)
            } else if state.error != nil {
                Image(systemName: "flag")
                    .imageScale(.medium)
            } else {
                ZStack {
                    Rectangle()
                        .fill(.secondary)

                    ProgressView()
                        .tint(.white)
                }
            }
        }
    }
}

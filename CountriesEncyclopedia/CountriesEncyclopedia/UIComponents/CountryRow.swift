import SwiftUI
import NukeUI

struct CountryRow: View {

    let country: CountryRowData
    let isFavorite: Bool
    let onToggleFavorite: () -> Void
    let onRowSelection: () -> Void

    var body: some View {
        Button {
            onRowSelection()
        } label: {
            HStack(alignment: .top, spacing: 10) {
                LazyImageView(imageURL: country.flagURL, accesibilityText: country.flagAltText)
                    .frame(width: 90, height: 70)
                VStack(alignment: .leading) {
                    Text(country.name)
                        .font(.headline)
                    Text(country.officialName)
                        .font(.subheadline)
                    Text(country.capital)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Button(action: onToggleFavorite) {
                    Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.accentColor)
                }
                .buttonStyle(.plain)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: Color.secondary.opacity(0.3), radius: 4, x: 2, y: 4)
        )
    }
}

#Preview {
    CountryRow(country: CountryEntity.mock, isFavorite: true, onToggleFavorite: {}, onRowSelection: {})
}

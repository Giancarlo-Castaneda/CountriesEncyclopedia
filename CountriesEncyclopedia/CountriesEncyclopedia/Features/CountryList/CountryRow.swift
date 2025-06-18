import SwiftUI

struct CountryRow: View {

    let country: CountryEntity
    let isFavorite: Bool
    let onToggleFavorite: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "flag")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 70)
                .accessibilityLabel(country.flagAltText)
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
            }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: Color.secondary.opacity(0.3), radius: 4, x: 2, y: 4)
        )
    }
}

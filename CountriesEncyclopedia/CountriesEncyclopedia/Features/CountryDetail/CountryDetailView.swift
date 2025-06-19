import SwiftUI
import NukeUI

struct CountryDetailView: View {
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var country: CountryEntity

    var body: some View {
        ScrollView {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 10) {
                    ZStack(alignment: .bottomLeading) {
                        flagView
                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .shadow(color: Color.secondary.opacity(0.3), radius: 4, x: 2, y: 4)
                            )
                        VStack(alignment: .center) {
                            Text(country.name)
                                .font(.title.bold())

                            Text(country.officialName)
                                .font(.body)
                                .padding(.bottom, 10)
                        }
                        .padding(5)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color(.systemGray6))
                                .shadow(color: Color.secondary.opacity(0.3), radius: 4, x: 2, y: 4)
                        )
                        .padding(.leading, 16)
                        .offset(y: 16)
                    }

                    VStack(alignment: .center) {
                        HStack {
                            if !country.region.isEmpty {
                                InfoView(mainText: "Region",
                                         secondaryText: country.region)
                            }

                            if !country.region.isEmpty && !country.subregion.isEmpty {
                                Divider()
                            }

                            if !country.subregion.isEmpty {
                                InfoView(mainText: "Subregion",
                                         secondaryText: country.subregion)
                            }

                            if !country.subregion.isEmpty && !country.capital.isEmpty {
                                Divider()
                            }

                            if !country.capital.isEmpty {
                                InfoView(mainText: "Capital", secondaryText: country.capital)
                            }
                        }
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color(.systemBackground))
                                .shadow(color: Color.secondary.opacity(0.3), radius: 4, x: 2, y: 4)
                        )

                        LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                            InfoCard(title: "Timezone(s)") {
                                Text(country.formattedTimezones)
                            }
                            InfoCard(title: "Population") {
                                Text(country.population, format: .number)
                            }
                            InfoCard(title: "Language(s)") {
                                Text(country.languages)
                            }
                            InfoCard(title: "Currencies") {
                                Text(country.currenciesText)
                            }
                            InfoCard(title: "Car Drive Side") {
                                HStack(spacing: 8) {
                                    Text("LEFT")
                                        .foregroundColor(country.isLeftSide ? .secondary : .primary)
                                    Image(systemName: "car.circle")
                                        .imageScale(.large)
                                        .foregroundStyle(.primary)
                                    Text("RIGHT")
                                        .foregroundColor(country.isLeftSide ? .primary : .secondary)
                                }
                            }
                            if let coatURL = country.coatAtArms {
                                InfoCard(title: "Coat of Arms") {
                                    CoatOfArmsView(image: coatURL)
                                }
                            }
                        }
                        .padding(.top, 10)
                    }
                    .padding(.top)
                    Spacer()
                }

                Spacer()
            }
        }
        .scrollIndicators(.hidden)
        .padding()
        .toolbar {
            Button {
            } label: {
                Image(systemName: country.isSaved ? "bookmark.fill" : "bookmark")
            }
        }
    }

    private var flagView: some View {
        LazyImage(url: country.flagURL) { state in
            if let image = state.image {
                image.resizable().aspectRatio(contentMode: .fit)
            } else if state.error != nil {
                Image(systemName: "xmark.circle")
                    .imageScale(.medium)
                    .foregroundStyle(.red)
            } else {
                ZStack {
                    Rectangle()
                        .fill(.secondary)

                    ProgressView()
                        .tint(.white)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }

    private struct CoatOfArmsView: View {
        let image: URL

        var body: some View {
            LazyImage(url: image) { state in
                if let image = state.image {
                    image.resizable().aspectRatio(contentMode: .fit)
                } else if state.error != nil {
                    Image(systemName: "xmark.circle")
                        .imageScale(.small)
                        .foregroundStyle(.red)
                } else {
                    ProgressView()
                        .tint(.secondary)
                }
            }
            .frame(width: 50, height: 50, alignment: .leading)
        }
    }
}

private struct InfoView: View {
    let mainText: String
    let secondaryText: String

    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(mainText)
                .font(.headline)
                .foregroundColor(Color.primary)

            Text(secondaryText)
                .font(.body)
                .foregroundColor(Color.secondary)
        }
        .padding(.horizontal)
    }
}

struct InfoCard<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)

            content
                .font(.subheadline)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: Color.secondary.opacity(0.3), radius: 4, x: 2, y: 4)
        )
    }
}

#Preview {
    CountryDetailView(country: .mock)
}

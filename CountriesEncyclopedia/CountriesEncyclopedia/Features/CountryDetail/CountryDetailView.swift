import SwiftUI
import NukeUI

struct CountryDetailView: View {
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    @State var viewModel: CountryDetailViewModel

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
                            Text(viewModel.country.name)
                                .font(.title.bold())

                            Text(viewModel.country.officialName)
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
                            if !viewModel.country.region.isEmpty {
                                InfoView(mainText: "Region",
                                         secondaryText: viewModel.country.region)
                            }

                            if !viewModel.country.region.isEmpty && !viewModel.country.subregion.isEmpty {
                                Divider()
                            }

                            if !viewModel.country.subregion.isEmpty {
                                InfoView(mainText: "Subregion",
                                         secondaryText: viewModel.country.subregion)
                            }

                            if !viewModel.country.subregion.isEmpty && !viewModel.country.capital.isEmpty {
                                Divider()
                            }

                            if !viewModel.country.capital.isEmpty {
                                InfoView(mainText: "Capital", secondaryText: viewModel.country.capital)
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
                                Text(viewModel.country.formattedTimezones)
                            }
                            InfoCard(title: "Population") {
                                Text(viewModel.country.population, format: .number)
                            }
                            InfoCard(title: "Language(s)") {
                                Text(viewModel.country.languages)
                            }
                            InfoCard(title: "Currencies") {
                                Text(viewModel.country.currenciesText)
                            }
                            InfoCard(title: "Car Drive Side") {
                                HStack(spacing: 8) {
                                    Text("LEFT")
                                        .foregroundColor(viewModel.country.isLeftSide ? .secondary : .primary)
                                    Image(systemName: "car.circle")
                                        .imageScale(.large)
                                        .foregroundStyle(.primary)
                                    Text("RIGHT")
                                        .foregroundColor(viewModel.country.isLeftSide ? .primary : .secondary)
                                }
                            }
                            if let coatURL = viewModel.country.coatAtArms {
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
                viewModel.toogleFavorite()
            } label: {
                Image(systemName: viewModel.country.isFavorite ? "bookmark.fill" : "bookmark")
            }
        }
    }

    private var flagView: some View {
        LazyImage(url: viewModel.country.flagURL) { state in
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
    CountryDetailView(viewModel: CountryDetailViewModel(dependencies: RootDependencies(), country: .mock))
}

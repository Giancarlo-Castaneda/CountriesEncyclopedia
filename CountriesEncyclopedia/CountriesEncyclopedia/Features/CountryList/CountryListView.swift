import SwiftUI

struct CountryListView: View {
    @State var viewModel: CountryListViewModel

    private func fetchCountries() {
        Task {
            await viewModel.loadCountries()
        }
    }

    // MARK: - Body

    var body: some View {
        NavigationStack(path: $viewModel.routing) {
            content
                .navigationTitle("Search")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer, prompt: "Search")
                .navigationDestination(for: CountryEntity.self) { selectedCountry in
                    CountryDetailView(viewModel: viewModel.makeDetailViewModel(for: selectedCountry))
                }
                .task {
                    fetchCountries()
                }
                .onChange(of: viewModel.searchText) { oldValue, newValue in
                    if newValue.count > 1 {
                        viewModel.search(by: newValue)
                    }

                    if newValue.isEmpty {
                        fetchCountries()
                    }
                }
        }
    }

    // MARK: - Private UI Components

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .success:
            listView

        case .failure:
            ErrorView(
                errorText: "There was an error loading the countries.",
                onButtonTap: { fetchCountries() }
            )

        case .loading:
            ProgressView()

        case .empty:
            Text("There are results to show at the moment")
        }
    }

    private var listView: some View {
        List {
            ForEach(viewModel.countryList) { country in
                CountryRow(
                    country: country,
                    isFavorite: viewModel.isFavorite(country),
                    onToggleFavorite: { viewModel.toogleFavorite(country) },
                    onRowSelection: { viewModel.routing.append(country) }
                )
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
        }
        .scrollIndicators(.hidden)
        .listStyle(.plain)
    }
}

#Preview {
    let dependencies = RootDependencies()
    CountryListView(viewModel: CountryListViewModel(dependencies: dependencies))
}

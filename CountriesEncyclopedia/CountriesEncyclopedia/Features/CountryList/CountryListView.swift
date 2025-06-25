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
                .navigationTitle("SEARCH_TAB_TITLE")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer, prompt: "SEARCH_PROMPT")
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
                errorText: "ERROR_FETCHING_COUNTRIES",
                onButtonTap: { fetchCountries() }
            )

        case .loading:
            ProgressView()

        case .empty:
            Text("ERROR_NO_COUNTRIES_FOUND")
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

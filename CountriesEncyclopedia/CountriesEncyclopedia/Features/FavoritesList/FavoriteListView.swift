import SwiftUI

struct FavoriteListView: View {
    @State var viewModel: FavoriteListViewModel

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Saved")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer, prompt: "Search")
                .task {
                    viewModel.fetchSavedCountries()
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
                onButtonTap: { viewModel.fetchSavedCountries() }
            )

        case .loading:
            ProgressView()

        case .empty:
            Text("Let's add some countries to your favorites!")
        }
    }

    // MARK: listView

    private var listView: some View {
        List(viewModel.filteredCountries) { country in
            CountryRow(country: country,
                       isFavorite: viewModel.isFavorite(country),
                       onToggleFavorite: { viewModel.removeFavorite(country) },
                       onRowSelection: {}
            )
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview {
    let dependencies = RootDependencies()
    FavoriteListView(viewModel: FavoriteListViewModel(dependencies: dependencies))
}

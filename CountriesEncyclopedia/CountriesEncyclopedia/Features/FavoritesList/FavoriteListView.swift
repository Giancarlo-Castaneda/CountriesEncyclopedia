import SwiftUI

struct FavoriteListView: View {
    @State var viewModel: FavoriteListViewModel

    var body: some View {
        NavigationStack {
            List(viewModel.filteredCountries) { country in
                CountryRow(country: country,
                           isFavorite: viewModel.isFavorite(country),
                           onToggleFavorite: { viewModel.removeFavorite(country) },
                           onRowSelection: {}
                )
                .listRowSeparator(.hidden)
            }
            .navigationTitle("Saved")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer, prompt: "Search")
            .onAppear {
                viewModel.fetchSavedCountries()
            }
        }
    }
}

#Preview {
    let dependencies = RootDependencies()
    FavoriteListView(viewModel: FavoriteListViewModel(dependencies: dependencies))
}

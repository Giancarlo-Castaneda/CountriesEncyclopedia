import SwiftUI

struct CountryListView: View {
    @State private var viewModel = CountryListViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.countryList) { country in
                    CountryRow(
                        country: country,
                        isFavorite: viewModel.isFavorite(country),
                        onToggleFavorite: { viewModel.toogleFavorite(country) }
                    )
                }
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer, prompt: "Search")
            .onAppear {
                if viewModel.countryList.isEmpty {
                    viewModel.loadCountries()
                }
            }
            .onChange(of: viewModel.searchText) { oldValue, newValue in
                if newValue.count > 1 {
                    viewModel.search(by: newValue)
                }

                if newValue.isEmpty {
                    viewModel.loadCountries()
                }
            }
        }
    }
}

#Preview {
    CountryListView()
}

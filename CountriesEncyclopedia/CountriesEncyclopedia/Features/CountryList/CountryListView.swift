import SwiftUI

struct CountryListView: View {
    @State private var viewModel = CountryListViewModel()
    @State var searchText: String = ""

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
            .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Search")
            .onAppear {
                viewModel.loadCountries()
            }
        }
    }
}

#Preview {
    CountryListView()
}

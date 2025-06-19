import SwiftUI

struct CountryListView: View {
    @State var viewModel: CountryListViewModel

    var body: some View {
        NavigationStack(path: $viewModel.routing) {
            List {
                ForEach(viewModel.countryList) { country in
                    CountryRow(
                        country: country,
                        isFavorite: viewModel.isFavorite(country),
                        onToggleFavorite: { viewModel.toogleFavorite(country) },
                        onRowSelection: { selectedCountry in viewModel.routing.append(selectedCountry) }
                    )
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer, prompt: "Search")
            .navigationDestination(for: CountryEntity.self) { selectedCountry in
                CountryDetailView(viewModel: viewModel.makeDetailViewModel(for: selectedCountry))
            }
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
    let dependencies = RootDependencies()
    CountryListView(viewModel: CountryListViewModel(dependencies: dependencies))
}

//
//  HomeView.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 17/12/23.
//

import SwiftUI

struct MovieList: View {
    @EnvironmentObject var router: Router
    @State var showAlert : Bool = false
    let moviesViewModel : MoviesViewModel
    @State var isLoading = true
    
    @State var movieList : [Movie] = []
    @State var mostPopularMovieList : [Movie] = []
    
    @State var showSearchBar : Bool = false
    @State var searchText : String = ""
    
    @State var selectedCategory = ""
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
                    Spacer()
                        .frame(height: 20)
                    
                    if showSearchBar {
                        SearchBarView(searchText: $searchText)
                    }
                    
                    VStack(spacing: 16) {
                        HStack {
                            Text("Genres")
                                .foregroundStyle(Color.white)
                                .font(.title3)
                            Spacer()
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                if isLoading {
                                    GenreItemView(name: "Action", selected: $selectedCategory)
                                        .redacted(reason: .placeholder)
                                    
                                    GenreItemView(name: "Action", selected: $selectedCategory)
                                        .redacted(reason: .placeholder)
                                    
                                    GenreItemView(name: "Action", selected: $selectedCategory)
                                        .redacted(reason: .placeholder)
                                } else {
                                    ForEach(moviesViewModel.categories, id: \.self) { category in
                                        GenreItemView(name: category, selected: $selectedCategory)
                                            .onTapGesture {
                                                DispatchQueue.main.async{
                                                    if selectedCategory == category {
                                                        selectedCategory = ""
                                                    } else {
                                                        selectedCategory = category
                                                    }
                                                }
                                                
                                            }
                                    }
                                }
                            }
                            
                        }
                    }
                    
                    
                    MovieScrollableList(title: "All", isLoading: $isLoading, movieList: $movieList)
                    
                    MovieScrollableList(title: "Most popular", isLoading: $isLoading, movieList: $mostPopularMovieList)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        
        .background(Color( #colorLiteral(red: 0.11, green: 0.12, blue: 0.20, alpha: 1.00) ))
        .task {
            await moviesViewModel.getMovies()
            DispatchQueue.main.async {
                movieList = moviesViewModel.movies
                mostPopularMovieList = moviesViewModel.mostPopularMovies
                if !movieList.isEmpty {
                    isLoading = false
                }
                
            }
        }
        .onChange(of: searchText, { oldValue, newValue in
            moviesViewModel.filterMovies(filter: newValue, genre: selectedCategory)
            DispatchQueue.main.async {
                movieList = moviesViewModel.moviesFiltered
            }
        })
        .onChange(of: selectedCategory, { oldValue, newValue in
            moviesViewModel.filterMovies(filter: searchText, genre: newValue)
            DispatchQueue.main.async {
                movieList = moviesViewModel.moviesFiltered
            }
        })
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Movies")
                    .foregroundStyle(Color.white)
                    .font(.title2)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.white)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            showSearchBar.toggle()
                        }
                        
                    }
            }
        }
        .onChange(of: moviesViewModel.error) {
            showAlert = moviesViewModel.error != nil
        }
        .alert(moviesViewModel.error?.description ?? "", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}

#Preview {
    MovieList(moviesViewModel: MoviesViewModel())
}

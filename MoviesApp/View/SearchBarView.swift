//
//  SearchBarView.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 21/12/23.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText : String
    
    var body: some View {
        ZStack {
            
            if searchText.isEmpty {
                HStack {
                    Text("Search")
                        .foregroundColor(Color(UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)))
                        .padding(.horizontal, 24)
                    Spacer()
                }
            }
            
            TextField("", text: $searchText)
                .foregroundColor(Color(UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)))
                .padding(.leading, 24)
            
            HStack {
                Spacer()
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(UIColor(red: 0.67, green: 0.67, blue: 0.67, alpha: 1.00)))
                    .padding(.horizontal)
            }
            
        }
        .frame(height: 60)
        .background(Color.white.opacity(0.1))
        .cornerRadius(25)
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}

//
//  GenreItemView.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 21/12/23.
//

import SwiftUI

struct GenreItemView: View {
    @State var name : String
    @Binding var selected : String
    var body: some View {
        Text(name)
            .foregroundStyle(Color.white)
            .padding(.vertical, 8)
            .frame(width: 140)
            .background(selected == name ? Color(UIColor(red: 0.39, green: 0.18, blue: 0.87, alpha: 1.00)) : Color.white.opacity(0.1))
            .cornerRadius(22)
        
            
    }
}

#Preview {
    GenreItemView(name: "Example", selected: .constant(""))
}

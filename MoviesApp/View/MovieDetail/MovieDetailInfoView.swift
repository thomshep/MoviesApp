//
//  MovieDetailInfoView.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 21/12/23.
//

import SwiftUI

struct MovieDetailInfoView: View {
    let icon : String
    let title : String
    let info : String
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .foregroundStyle(Color.white)
                .font(.title)
            
            Text(title)
                .foregroundStyle(Color.gray)
                .font(.subheadline)
            
            Text(info)
                .foregroundStyle(Color.white)
                .font(.headline)
        }
        .frame(width: 110, height: 110)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 2)
        )
    }
}

#Preview {
    MovieDetailInfoView(icon: "video", title: "Genre", info: "Action")
}

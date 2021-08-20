//
//  UniversityListView.swift
//  SummerSchool
//
//  Created by Dan, Radu-Ionut on 04.08.2021.
//

import SwiftUI

// MARK: - University List
struct UniversityListView: View {
    
    @State private var showFavourites = false
    @StateObject private var universityHolder = Universities()
    
    var body: some View {
        NavigationView {
            List($universityHolder.universities) { $university in
                NavigationLink(
                    destination: UniversityDetailView(university: $university)
                ) {
                    UniversityRow(university: $university)
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("Summer School")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button(action: toggleFavourites) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(showFavourites ? .red : .gray)
                }
            )
        }
    }
    
    private func toggleFavourites() {
        showFavourites.toggle()
        
        if showFavourites {
            universityHolder.loadFavouriteUniversities()
        } else {
            universityHolder.reloadUniversities()
        }
    }
    
}
// MARK: - Row
struct UniversityRow: View {
    @Binding var university: University
    
    var body: some View {
        Image(university.image)
            .resizable()
            .clipShape(Circle())
            .frame(width: 50, height: 50)
        
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text(university.name)
                    .font(.headline)
                
                Text("Year: \(String(university.year))")
                    .font(.body)
                
                Text("City: \(university.city)")
                    .font(.body)
            }
            
            Spacer()
            
            Image(systemName: university.isFavourite ? "heart.fill" : "heart")
                .foregroundColor(.red)
                .onTapGesture {
                    university.isFavourite.toggle()
                }
        }
    }
}

// MARK: - Preview
struct UniversityListView_Previews: PreviewProvider {
    static var previews: some View {
        UniversityListView()
    }
}

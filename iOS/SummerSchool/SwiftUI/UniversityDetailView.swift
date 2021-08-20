//
//  UniversityDetailView.swift
//  SummerSchool
//
//  Created by Dan, Radu-Ionut on 04.08.2021.
//

import SwiftUI

// MARK: - UniversityDetailView
struct UniversityDetailView: View {
    @Binding var university: University
    
    var body: some View {
        ScrollView(.vertical) {
            UniversityInformationView(university: $university)
                .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - Information View
struct UniversityInformationView: View {
    @Binding var university: University
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(university.image)
                .resizable()
                .scaledToFit()
                .padding(.top)
            
            Text(university.name)
                .font(.headline)
            
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Year: \(String(university.year))")
                        .font(.callout)
                        .foregroundColor(.gray)
                    
                    Text("City: \(university.city)")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: university.isFavourite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .onTapGesture {
                        university.isFavourite.toggle()
                    }
            }
            
            Divider()
            
            if let description = university.description {
                Text(description)
                    .font(.callout)
            }
        }
    }
}

// MARK: - Preview
struct UniversityDetailView_Previews: PreviewProvider {
    private static let universities: [University] = Bundle.main.decode("universities.json")
    
    static var previews: some View {
        UniversityDetailView(university: .constant(universities[0]))
    }
}

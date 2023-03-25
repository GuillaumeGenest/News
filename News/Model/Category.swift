//
//  Category.swift
//  News
//
//  Created by Guillaume Genest on 24/03/2023.
//

import Foundation
import SwiftUI


enum Country: String, CaseIterable{
    case French = "fr"
    case USA = "us"
    case UK = "ae"
    case Espagne = "es"
}



enum Category: String, CaseIterable{
    case general
    case business
    case technology
    case entertainment
    case sports
    case science
    case health
    
}

extension Category: Identifiable {
    var id: String { rawValue }
}

struct CategoryButtonView: View {
    let oncolor: Color = .orange
    let offcolor: Color = .gray
    
    @Binding var selectedCategoryType: Category
    @State private var isSelectingMode = false
    private let categorytypes = Category.allCases
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(categorytypes.indices) { index in
                    Text(categorytypes[index].rawValue.capitalized)
                        .foregroundColor(selectedCategoryType == categorytypes[index] ? .white : offcolor)
                        .padding(.horizontal,4)
                        .background(selectedCategoryType == categorytypes[index] ? oncolor : Color.white)
                        .cornerRadius(15)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isSelectingMode.toggle()
                                selectedCategoryType = categorytypes[index]
                            }
                        }
                }
            }
        }.background(Color.white)
        .padding(8)
            
            }
        }

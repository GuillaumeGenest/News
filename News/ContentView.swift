//
//  ContentView.swift
//  News
//
//  Created by Guillaume Genest on 24/03/2023.
//

import SwiftUI

struct ContentView: View {
        
        @State var category : Category = .general
        @State var countrylanguage: Country = .French
        @StateObject var viewModel = NewsViewModel()
        
        var body: some View {
            NavigationStack{
                VStack(alignment: .leading){
                    HStack{
                        Text("Aujourd'hui: ") +
                        Text(Date.now, format: .dateTime.day().month().year())
                            
                        Spacer()
                        Menu {
                            Button(action: {countrylanguage = .USA},
                            label: { Text("Americain")})
                            Button(action: {countrylanguage = .French},
                                           label: {
                                Text("Francais")
                            })
                        } label: {
                            Image(systemName: "gearshape")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .font(.headline)
                                .padding(8)
                                .foregroundColor(.primary)
                                .background(.thickMaterial)
                                .cornerRadius(10)
                                .shadow(radius: 4)
                        }.onChange(of: countrylanguage) { categoryselected in
                            viewModel.getArticles(category: category.rawValue, country: categoryselected.rawValue)
                        }


                        
                    }.padding(.horizontal,8)
                    CategoryButtonView(selectedCategoryType: $category).onChange(of: category) { categoryselected in
                        viewModel.getArticles(category: categoryselected.rawValue, country: countrylanguage.rawValue)
                    }
                    List(viewModel.news, id: \.title) { article in
                        NavigationLink(destination: NewsDetailView(article: article)) {
                            VStack(alignment: .leading) {
                                HStack{
                                    AsyncImage(url: URL(string: article.urlToImage ?? "")) { phase in
                                        if let image = phase.image {
                                            image
                                                .renderingMode(.original)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 100, height: 100)
                                                .clipped()
                                                .cornerRadius(15)
                                                }
                                                else {
                                                    VStack{
                                                        Image(systemName: "photo")
                                                        .resizable()
                                                        .foregroundColor(.black)
                                                        .frame(width: 40.0, height: 40.0)
                                                }.frame(width: 100, height: 100)
                                                .background(Color.gray)
                                                .cornerRadius(15)
                                        }
                                    }
                                    Text(article.title)
                                        .font(.headline)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Actualité ")
                    
            }
            .onAppear {
                viewModel.getArticles(category: category.rawValue, country: countrylanguage.rawValue)
            }
            
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct NewsDetailView: View {
    
    let article: News
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                Text(article.title)
                    .font(.title)
                
                if let date = article.publishedAt{
                    Text("Date de publication: "  + date.FormattedDate(format: "MM-dd-yyyy HH:mm"))
                        .padding(.top, 8)
                }
                AsyncImage(url: URL(string: article.urlToImage ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .renderingMode(.original)
                            .resizable()
                            //.aspectRatio(contentMode: .fill)
                            .frame(height: 400)
                            .clipped()
                            .cornerRadius(15)
                            .padding(.horizontal,8)
                        
                    }
                    else {
                        VStack{
                            Image(systemName: "photo")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width: 40.0, height: 40.0)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                        .background(Color.gray)
                        .cornerRadius(15)
                    }
                }
                
               
                if let description = article.description {
                    VStack{
                        Text(description)
                            .font(.body)
                        if let url = article.url {
                            Link("Lire la suite", destination: url)
                                .font(.body)
                        }
                    }
                }
                
            }.padding(.horizontal,8)
        }
        .navigationBarTitle("News", displayMode: .inline)
    }
}

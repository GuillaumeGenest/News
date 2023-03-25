//
//  ViewModel.swift
//  News
//
//  Created by Guillaume Genest on 24/03/2023.
//

import Foundation
class NewsViewModel: ObservableObject {
    
    @Published var news: [News] = []
    
    func getArticles(category: String, country: String) {
        let apiKey = "851dfef8f907405e9003a45a4ef62401"
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=\(country)&category=\(category)&apiKey=\(apiKey)")!
           let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
               guard let self = self else { return }
               guard error == nil else {
                   print("Error fetching articles: \(error!)")
                   return
               }
               guard let data = data else {
                   print("No data returned from server")
                   return
               }
               
               print(String(data: data, encoding: .utf8)!)

               do {
                   let decoder = JSONDecoder()
                   decoder.dateDecodingStrategy = .iso8601
                   let response = try decoder.decode(NewsAPIResult.self, from: data)
                   DispatchQueue.main.async {
                       self.news = response.articles
                   }
               } catch {
                   print("Error decoding JSON: \(error)")
               }
           }
           task.resume()
       }
}

struct NewsAPIResult: Codable {
    let articles: [News]
}

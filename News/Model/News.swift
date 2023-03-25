//
//  News.swift
//  News
//
//  Created by Guillaume Genest on 24/03/2023.
//

import Foundation


struct News: Codable{
        var author: String?
        var title: String
        var description: String?
        var url: URL?
        var urlToImage: String?
        var publishedAt: Date?
        var source: Source?
    }

    struct Source: Codable {
        var name: String?
    }

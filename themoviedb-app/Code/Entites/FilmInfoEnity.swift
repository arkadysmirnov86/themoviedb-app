//
//  FilmInfoEnity.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 7/31/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

struct FilmInfoEnity: Decodable {
    var id: Int
    var title: String
}

extension FilmInfoEnity {
    var asModel: FilmModel {
        return FilmModel(poster: "", name: title, releaseDate: Date(), overview: "")
    }
}

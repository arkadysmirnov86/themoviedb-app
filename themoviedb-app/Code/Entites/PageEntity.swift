//
//  PageEntity.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 7/31/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

struct PageEntity<T: Decodable>: Decodable {
    var page: Int
    var total_results: Int
    var total_pages: Int
    var results: Array<T>
}

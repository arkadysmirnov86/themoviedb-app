//
//  PageModel.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 8/1/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

struct PageModel<T> {
    var page: Int
    var totalPages: Int
    var items: [T]?
}

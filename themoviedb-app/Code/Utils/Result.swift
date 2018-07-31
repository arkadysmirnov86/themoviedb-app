//
//  Result.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 7/31/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}

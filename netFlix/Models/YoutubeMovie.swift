//
//  YoutubeMovie.swift
//  netFlix
//
//  Created by Daniel on 2/3/24.
//

import UIKit

struct YoutubeMovieResponse : Codable {
    let items : [ItemElements]
}

struct ItemElements : Codable {
    let id : IdElements
}

struct IdElements : Codable {
    let kind : String
    let videoId : String
}

//
//  YoutubeSearchResponse.swift
//  MovieApp
//
//  Created by Aleksandr Kan on 23/03/23.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    
    let items: [VideoObject]
    
}


struct VideoObject: Codable {
    let id: IdVideo
}

struct IdVideo: Codable {
    let kind: String
    let videoId: String
}

//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Ahmed Salem on 20/11/2022.
//

import Foundation

struct YoutubeSearchResponse : Codable
{
    let items: [VideoElement]
}

struct VideoElement : Codable
{
    let id : IDVideoElement
}

struct IDVideoElement : Codable
{
    let kind : String
    let videoId : String
}

//"items": [
//    {
//      "kind": "youtube#searchResult",
//      "etag": "0sGg5g5KQTO7gjdI9rsy6eK2FNI",
//      "id": {
//        "kind": "youtube#video",
//        "videoId": "uq2OGLUel0M"
//      }
//    },

//
//  Environment.swift
//
//  Created by Luann Marques Luna on 18/02/21.
//

import Foundation

var apiKey: String {
    get {
        
        guard let filePath = Bundle.main.path(forResource: "GlobalInfo", ofType: "plist") else {
            fatalError("Couldn't find file 'GlobaInfo.plist'.")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'GlobaInfo.plist'.")
        }
        
        if (value.starts(with: "_")) {
            fatalError("Register for a TMDB developer account and get an API key at https://developers.themoviedb.org/3/getting-started/introduction.")
        }
        return value
    }
}

var baseURL: String {
    get {
        
        guard let filePath = Bundle.main.path(forResource: "GlobalInfo", ofType: "plist") else {
            fatalError("Couldn't find file 'GlobaInfo.plist'.")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "BaseURL") as? String else {
            fatalError("Couldn't find key 'BaseURL' in 'GlobaInfo.plist'.")
        }
        
        if (value.starts(with: "_")) {
            fatalError("Base URL not Found")
        }
        return value
    }
}


var imgBaseUrl: String {
    get {
        
        guard let filePath = Bundle.main.path(forResource: "GlobalInfo", ofType: "plist") else {
            fatalError("Couldn't find file 'GlobaInfo.plist'.")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "ImgBaseURL") as? String else {
            fatalError("Couldn't find key 'ImgBaseURL' in 'GlobaInfo.plist'.")
        }
        
        if (value.starts(with: "_")) {
            fatalError("Base URL not Found")
        }
        return value
    }
}

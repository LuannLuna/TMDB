//
//  Configurable.swift
//  TMDB
//
//  Created by Luann Marques Luna on 18/02/21.
//

import Foundation

public protocol Configurable { }

public extension Configurable {
    
    func with(_ configure: (inout Self) -> Void) -> Self {
        var this = self
        configure(&this)
        return this
    }
}

extension NSObject: Configurable { }

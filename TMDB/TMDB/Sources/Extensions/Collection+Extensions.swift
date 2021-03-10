//
//  Collection+Extensions.swift
//
//  Created by Luann Marques Luna on 20/02/21.
//

import Foundation

extension Collection {
    func element(at index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

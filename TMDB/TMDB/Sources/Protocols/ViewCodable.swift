//
//  ViewCodable.swift
//  TMDB
//
//  Created by Luann Marques Luna on 18/02/21.
//

import SnapKit

protocol ViewCodable {
    func setup()
    func setupViews()
    func setupAnchors()
    func setupLayouts()
}

extension ViewCodable {

    func setup() {
        setupViews()
        setupAnchors()
        setupLayouts()
    }
    
    func setupLayouts() {}

}


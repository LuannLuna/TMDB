//
//  GenreCollectionViewCell.swift
//  TMDB
//
//  Created by Luann Marques Luna on 22/02/21.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    private lazy var title = UILabel().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var thumbView = UIImageView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.image = #imageLiteral(resourceName: "placeholder")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func fill(genre: Genre) {
        title.text = genre.name
    }
}


extension GenreCollectionViewCell: ViewCodable {
    func setupViews() {
        addSubview(thumbView)
        addSubview(title)
    }
    
    func setupAnchors() {
        thumbView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        title.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

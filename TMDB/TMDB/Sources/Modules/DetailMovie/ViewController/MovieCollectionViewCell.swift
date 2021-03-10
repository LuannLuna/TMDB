//
//  MovieCollectionViewCell.swift
//  TMDB
//
//  Created by Luann Marques Luna on 22/02/21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    private lazy var stackView = UIStackView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .fill
        $0.spacing = 5
        $0.axis = .vertical
    }
    
    private lazy var thumbView = UIImageView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
        $0.image = #imageLiteral(resourceName: "placeholder")
    }
    
    private lazy var title = UILabel().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = $0.font.withSize(13)
        $0.textColor = .black
        $0.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func fill(movie: Movie) {
        if let img = movie.img {
            thumbView.downloaded(from: img, contentMode: .scaleToFill)
            title.text =  movie.title
        }
    }
}


extension MovieCollectionViewCell: ViewCodable {
    func setupViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(thumbView)
        stackView.addArrangedSubview(title)
    }
    
    func setupAnchors() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

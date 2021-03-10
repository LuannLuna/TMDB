//
//  HomeMovieTableViewCell.swift
//  TMDB
//
//  Created by Luann Marques Luna on 21/02/21.
//

import UIKit

class HomeMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func fill(movie: Movie) {
        title.text = movie.title
        date.text = movie.releaseDate?.atFormat(with: "EEE MM/dd/YYYY")
        overview.text = movie.overview
        if let img = movie.img {
            thumb.downloaded(from: img, contentMode: .scaleAspectFill)
        }
    }
    
    override func prepareForReuse() {
        title.text = ""
        date.text = ""
        overview.text = ""
        thumb.image = #imageLiteral(resourceName: "placeholder")
    }
}

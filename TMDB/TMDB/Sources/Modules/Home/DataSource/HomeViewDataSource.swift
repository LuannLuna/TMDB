//
//  MovieDataSource.swift
//  TMDB
//
//  Created by Luann Marques Luna on 26/02/21.
//

import UIKit

class HomeViewDataSource: NSObject, UITableViewDataSource {
    
    weak var viewModel: HomeViewModelDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItens() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HomeMovieTableViewCell
        
        if let movie = viewModel?.elementAt(index: indexPath.row) {
            cell?.fill(movie: movie)
        }
        
        return cell ?? UITableViewCell()
    }
}

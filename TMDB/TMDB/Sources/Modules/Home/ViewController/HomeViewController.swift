//
//  HomeViewController.swift
//  TMDB
//
//  Created by Luann Marques Luna on 19/02/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModelDelegate?
    
    private lazy var dataSource = HomeViewDataSource().with {
        $0.viewModel = viewModel
    }
    
    private lazy var tableView = UITableView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = dataSource
    }
    
    init(viewModel: HomeViewModelDelegate) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        navigationItem.title = "Popular Movies"
        
        tableView.register(UINib(nibName: "HomeMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        setupView()
        view.backgroundColor = .white
        
        viewModel?.viewDidLoad() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.didTapElement(index: indexPath.row)
    }
}



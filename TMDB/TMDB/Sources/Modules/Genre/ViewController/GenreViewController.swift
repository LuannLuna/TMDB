//
//  GenreViewController.swift
//  TMDB
//
//  Created by Luann Marques Luna on 21/02/21.
//

import UIKit

class GenreViewController: UIViewController {
    
    var viewModel: GenreViewModelDelegate?
    
    private lazy var collectionFlow = UICollectionViewFlowLayout()
    
    private lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionFlow).with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.delegate = self
        $0.dataSource = self
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        $0.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        $0.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    init(viewModel: GenreViewModelDelegate) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupView()
        navigationItem.title = "Genres"
        
        viewModel?.featchData {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setupView() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension GenreViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 150)
    }
}

extension GenreViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension GenreViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfElements ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? GenreCollectionViewCell
        
        if let genre = viewModel?.elementAt(index: indexPath.row) {
            cell?.fill(genre: genre)
        }
        
        return cell ?? UICollectionViewCell()
    }
    
}

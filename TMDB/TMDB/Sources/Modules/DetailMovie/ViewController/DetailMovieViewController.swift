//
//  DetailMovieViewController.swift
//  TMDB
//
//  Created by Luann Marques Luna on 21/02/21.
//

import UIKit

protocol DetailMovieViewControllerDelegate: class {
    
}

class DetailMovieViewController: UIViewController {
        
    var viewModel: DetailMovieViewModelDelegate?
    
    private lazy var scrollView = UIScrollView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alwaysBounceVertical = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    private lazy var stackView = UIStackView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 8
    }
    
    private lazy var ThumbImageView = UIImageView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width / 2)
            make.height.equalTo(UIScreen.main.bounds.height / 2)
        }
        $0.downloaded(from: viewModel?.img ?? "")
    }
    
    private lazy var titleLabel = UILabel().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.text = viewModel?.overview ?? ""
    }
    
    private lazy var score = UILabel().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Score: " + (viewModel?.average ?? "") + "  ⭐️⭐️⭐️ "
        $0.font = $0.font.withSize(13)
        $0.textAlignment = .right
    }
    
    private lazy var releaseDate = UILabel().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Release date: " + (viewModel?.releaseDate ?? "") + "  🗓 "
        $0.font = $0.font.withSize(15)
        $0.textAlignment = .right
    }
    
    
    //MARK: - CollectionView
    
    private lazy var headCollection = UILabel().with {
        $0.text = "Similar Movies"
    }
    
    private lazy var collectionFlow = UICollectionViewFlowLayout().with {
        $0.scrollDirection = .horizontal
    }
    
    private lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionFlow).with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.delegate = self
        $0.dataSource = self
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        $0.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        $0.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    
    init(viewModel: DetailMovieViewModelDelegate) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = viewModel?.title
        viewModel?.viewDidAppear {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        setup()
    }
    
    deinit {
        viewModel?.onFinish()
    }
}

extension DetailMovieViewController: ViewCodable {
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(ThumbImageView)
        stackView.addArrangedSubview(score)
        stackView.addArrangedSubview(releaseDate)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(headCollection)
        stackView.addArrangedSubview(collectionView)
    }
    
    func setupAnchors() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        
        stackView.setCustomSpacing(40, after: titleLabel)
        
        collectionView.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(150)
        }
    }
    
}

extension DetailMovieViewController: DetailMovieViewControllerDelegate {
    
}

extension DetailMovieViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 150)
    }
}

extension DetailMovieViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.didTapped(at: indexPath.row)
    }
    
}

extension DetailMovieViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItens ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MovieCollectionViewCell
        
        if let movie = viewModel?.elementAt(index: indexPath.row) {
            cell?.fill(movie: movie)
        }
        
        return cell ?? UICollectionViewCell()
    }
    
}


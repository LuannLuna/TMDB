//
//  ApplicationViewModel.swift
//  TMDB
//
//  Created by Luann Marques Luna on 18/02/21.
//

import Foundation

protocol ApplicationViewModelProtocol: class {
    func viewDidLoad()
}

class ApplicationViewModel: ApplicationViewModelProtocol {
    
    weak var view: ApplicationViewControllerProtocol?
    weak var coordinator: ApplicationCoordinatorProtocol?
    
    func viewDidLoad() {
        coordinator?.didSetupFinished()
    }
}

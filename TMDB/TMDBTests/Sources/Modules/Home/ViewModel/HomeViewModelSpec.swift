//
//  HomeViewModelSpec.swift
//  TMDBTests
//
//  Created by Luann Marques Luna on 22/02/21.
//

import Quick
import Nimble

@testable import TMDB

class HomeViewModelSpec: QuickSpec {
    
    var sut: HomeViewModel!
    var movieServiceMock: MovieServiceMock!
    
    override func spec() {
        describe("HomeViewModel") {
            
            context("when fetch movies with sucess") {
                
                beforeEach {
                    self.buildServiceMock(with: .success)
                }
                
                it("then popular movies could not be zero") {
                    expect(self.sut.numberOfItens()).toNot(be(0))
                }
            }
            
            context("when fetch movies with failure") {
                
                beforeEach {
                    self.buildServiceMock(with: .failure)
                }
                
                it("then popular movies should be zero") {
                    expect(self.sut.numberOfItens()).to(be(0))
                }
                
            }
            
            context("when fetch movie with name Space Sweepers") {
                
                beforeEach {
                    self.buildServiceMock(with: .success)
                }
                
                it("then first movie must be Space Sweepers") {
                    expect(self.sut.elementAt(index: 0)?.title).to(equal("Space Sweepers"))
                }
                
            }
            
            context("when fetch movie with name Space Sweepers with failure") {
                
                beforeEach {
                    self.buildServiceMock(with: .failure)
                }
                
                it("then first movies should be nil") {
                    expect(self.sut.elementAt(index: 0)).to(beNil())
                }
                
            }
        }
    }
}

extension HomeViewModelSpec {
    func buildServiceMock(with result: ResultCase) {
        self.movieServiceMock = MovieServiceMock(result: result)
        self.buildViewModel(movieServiceMock)
    }
    
    func buildViewModel(_ movieServiceMock: MovieServiceMock) {
        sut = HomeViewModel(service: movieServiceMock)
        sut.viewDidLoad {
            
        }
    }
}

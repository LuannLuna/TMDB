//
//  GenreViewModelSpec.swift
//  TMDBTests
//
//  Created by Luann Marques Luna on 22/02/21.
//

import Quick
import Nimble

@testable import TMDB

class GenreViewModelSpec: QuickSpec {
    var sut: GenreViewModel!
    var genreServiceMock: GenreServiceMock!
    
    override func spec() {
        describe("GenreViewModel") {
            
            context("when fetch genre with sucess") {
                
                beforeEach {
                    self.buildServiceMock(with: .success)
                }
                
                it("then genres could not be zero") {
                    expect(self.sut.numberOfElements).toNot(be(0))
                }
            }
            
            context("when fetch genres with failure") {
                
                beforeEach {
                    self.buildServiceMock(with: .failure)
                }
                
                it("then genres should be zero") {
                    expect(self.sut.numberOfElements).to(be(0))
                }
            }
            
            context("when fetch genre with name Action") {
                
                beforeEach {
                    self.buildServiceMock(with: .success)
                }
                
                it("then first genre must be Action") {
                    expect(self.sut.elementAt(index: 0)?.name).to(equal("Action"))
                }
                
            }
            
            context("when fetch genre with name Action with failure") {
                
                beforeEach {
                    self.buildServiceMock(with: .failure)
                }
                
                it("then first genre should be nil") {
                    expect(self.sut.elementAt(index: 0)).to(beNil())
                }
                
            }
    
        }
    }
}

extension GenreViewModelSpec {
    func buildServiceMock(with result: ResultCase) {
        self.genreServiceMock = GenreServiceMock(result: result)
        self.buildViewModel(genreServiceMock)
    }
    
    func buildViewModel(_ genreServiceMock: GenreServiceMock) {
        sut = GenreViewModel(service: genreServiceMock)
        sut.featchData {
            
        }
    }
}

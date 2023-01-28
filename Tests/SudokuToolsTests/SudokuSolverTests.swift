//
//  SudokuSolverTests.swift
//  
//
//  Created by Fernando Jose Manzano on 18/1/23.
//

import Foundation
import Nimble
import Quick

@testable import SudokuTools

class SudokuSolverTests: QuickSpec {
    override func spec() {
        
        describe("Solving sudokus") {
            
            var solver: SudokuSolver!
            beforeEach {
                solver = SudokuSolver()
            }
            
            context("non solvable board") {
                describe("of 2x2") {
                    it("should return error") {
                        let board = [[1, nil],
                                     [1, nil]]
                        expect { try solver.solve(board) }
                            .to(throwError(SudokuSolverError.noSolution))
                    }
                }
            }
            
            context("valid board") {
                describe("of 1x1") {
                    it("should solve to 1") {
                        let solution = try solver.solve([[nil]])
                        expect(solution).to(equal([[1]]))
                    }
                }
                
                describe("of 2x2") {
                    it("should have solution") {
                        let board = [[1, nil], [2, nil]]
                        let expectedSolution = [[1, 2], [2, 1]]
                        let solution = try solver.solve(board)
                        expect(solution).to(equal(expectedSolution))
                    }
                    it("should have solution") {
                        let board = [[1, nil], [nil, 1]]
                        let expectedSolution = [[1, 2], [2, 1]]
                        let solution = try solver.solve(board)
                        expect(solution).to(equal(expectedSolution))
                    }
                    it("should have solution") {
                        let board = [[1, 2], [nil, nil]]
                        let expectedSolution = [[1, 2], [2, 1]]
                        let solution = try solver.solve(board)
                        expect(solution).to(equal(expectedSolution))
                    }
                    it("should have solution") {
                        let board = [[nil, nil], [2, 1]]
                        let expectedSolution = [[1, 2], [2, 1]]
                        let solution = try solver.solve(board)
                        expect(solution).to(equal(expectedSolution))
                    }
                    it("should have solution") {
                        let board = [[nil, 2], [nil, 1]]
                        let expectedSolution = [[1, 2], [2, 1]]
                        let solution = try solver.solve(board)
                        expect(solution).to(equal(expectedSolution))
                    }
                    it("should have solution") {
                        let board = [[1, nil], [2, nil]]
                        let expectedSolution = [[1, 2], [2, 1]]
                        let solution = try solver.solve(board)
                        expect(solution).to(equal(expectedSolution))
                    }
                    it("should have solution") {
                        let board = [[2, nil], [nil, 2]]
                        let expectedSolution = [[2, 1], [1, 2]]
                        let solution = try solver.solve(board)
                        expect(solution).to(equal(expectedSolution))
                    }
                    it("should have solution") {
                        let board = [[2, 1], [nil, nil]]
                        let expectedSolution = [[2, 1], [1, 2]]
                        let solution = try solver.solve(board)
                        expect(solution).to(equal(expectedSolution))
                    }
                    it("should have solution") {
                        let board = [[nil, nil], [1, 2]]
                        let expectedSolution = [[2, 1], [1, 2]]
                        let solution = try solver.solve(board)
                        expect(solution).to(equal(expectedSolution))
                    }
                    it("should have solution") {
                        let board = [[nil, 1], [nil, 2]]
                        let expectedSolution = [[2, 1], [1, 2]]
                        let solution = try solver.solve(board)
                        expect(solution).to(equal(expectedSolution))
                    }
                    
                }
                
            }

        }
        
    }
}

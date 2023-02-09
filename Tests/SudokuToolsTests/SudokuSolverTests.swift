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
                it("should return error") {
                    let board = [
                        [ 1 , nil,  3 , nil],
                        [nil, nil,  2 , nil],
                        [nil,  3 , nil, nil],
                        [nil, nil, nil,  4 ]
                    ]
                    expect {
                        try solver.solve(board)
                    }.to(throwError(SudokuSolverError.noSolution))
                }
            }
            
            context("valid board") {
                describe("of 4x4") {
                    it("should return a solution") {
                        let board = [
                            [ 1 , nil, nil, nil],
                            [nil, nil,  2 , nil],
                            [nil,  3 , nil, nil],
                            [nil, nil, nil,  4 ]
                        ]
                        let expectedSolution = [
                            [1, 2, 4, 3],
                            [3, 4, 2, 1],
                            [4, 3, 1, 2],
                            [2, 1, 3, 4]
                        ]
                        let solution = try solver.solve(board)
                        expect(solution).to(equal(expectedSolution))
                    }
                }
                describe("of 9x9") {
                    it("should return a solution") {
                        let board = [
                            [nil, nil,  6 ,  3 , nil, nil,  9 ,  2 , nil],
                            [nil, nil,  5 , nil, nil, nil,  1 , nil, nil],
                            [ 4 , nil, nil,  8 , nil,  1 , nil, nil,  7 ],
                            [ 7 , nil, nil, nil, nil,  6 ,  4 , nil,  3 ],
                            [ 8 , nil, nil,  1 , nil, nil, nil, nil, nil],
                            [nil, nil,  4 ,  7 ,  3 , nil, nil, nil,  9 ],
                            [ 6 , nil, nil, nil, nil,  8 , nil, nil, nil],
                            [ 5 , nil,  8 , nil,  1 ,  3 ,  7 , nil,  2 ],
                            [nil, nil, nil, nil,  2 , nil,  6 , nil, nil]
                        ]
                        let expectedSolution = [
                            [1, 7, 6, 3, 5, 4, 9, 2, 8],
                            [3, 8, 5, 9, 7, 2, 1, 4, 6],
                            [4, 9, 2, 8, 6, 1, 3, 5, 7],
                            [7, 5, 9, 2, 8, 6, 4, 1, 3],
                            [8, 6, 3, 1, 4, 9, 2, 7, 5],
                            [2, 1, 4, 7, 3, 5, 8, 6, 9],
                            [6, 2, 7, 4, 9, 8, 5, 3, 1],
                            [5, 4, 8, 6, 1, 3, 7, 9, 2],
                            [9, 3, 1, 5, 2, 7, 6, 8, 4]
                        ]
                        let solution = try solver.solve(board)
                        expect(solution).to(equal(expectedSolution))
                    }
                }
            }
            
            context("empty board") {
                it("should return a solution") {
                    let board: [[Int?]] = [
                        [nil, nil, nil, nil],
                        [nil, nil, nil, nil],
                        [nil, nil, nil, nil],
                        [nil, nil, nil, nil]
                    ]
                    expect {
                        try solver.solve(board)
                    }.toNot(throwError())
                }
            }

            context("invalid board") {

                describe("board size not allowed") {
                    it("should throw invalidCells error") {
                        let board: [[Int?]] = [
                            [ 1 , nil, nil],
                            [nil,  2 , nil],
                            [nil, nil,  3 ]
                        ]
                        expect {
                            try solver.solve(board)
                        }.to(throwError(SudokuSolverError.invalidCells))
                    }
                }

                describe("less rows than columns") {
                    it("should throw invalidCells error") {
                        let board: [[Int?]] = [
                            [ 1 , nil, nil, nil, nil],
                            [nil,  2 , nil, nil, nil],
                            [nil, nil,  3 , nil,  5 ],
                            [nil, nil, nil,  4 , nil]
                        ]
                        expect {
                            try solver.solve(board)
                        }.to(throwError(SudokuSolverError.invalidCells))
                    }
                }

                describe("more rows than columns") {
                    it("should throw invalidCells error") {
                        let board: [[Int?]] = [
                            [ 2 , nil, nil],
                            [nil,  3 , nil],
                            [nil, nil,  1 ],
                            [ 3 , nil, nil]
                        ]
                        expect {
                            try solver.solve(board)
                        }.to(throwError(SudokuSolverError.invalidCells))
                    }
                }

                describe("rows with different sizes") {
                    it("should throw invalidCells error") {
                        let board: [[Int?]] = [
                            [nil, nil,  1 ],
                            [nil,  2 , nil],
                            [ 3 , nil],
                            [nil,  1 , nil]
                        ]
                        expect {
                            try solver.solve(board)
                        }.to(throwError(SudokuSolverError.invalidCells))
                    }
                }

            }

        }
        
    }
}

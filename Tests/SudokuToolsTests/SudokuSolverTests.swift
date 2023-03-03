//
//  SudokuSolverTests.swift
//  
//
//  Created by Fernando Jose Manzano on 18/1/23.
//

import Foundation
import XCTest
import Nimble

@testable import SudokuTools

class SudokuSolverTests: XCTestCase {
    
    var solver: SudokuSolver!
    
    override func setUp() {
        super.setUp()
        solver = SudokuSolver()
    }
    
    func test_solve_nonSolvableBoard_shouldReturnError() {
        let board = [
            [ 1 , nil,  3 , nil],
            [nil, nil,  2 , nil],
            [nil,  3 , nil, nil],
            [nil, nil, nil,  4 ]
        ]
        expect {
            try self.solver.solve(board)
        }.to(throwError(SudokuSolverError.noSolution))
    }
    
    func test_solve_valid4x4Board_shouldReturnSolution() {
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
        let solution = try? solver.solve(board)
        expect(solution).to(equal(expectedSolution))
    }
    
    func test_solve_valid9x9Board_shouldReturnSolution() {
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
        let solution = try? solver.solve(board)
        expect(solution).to(equal(expectedSolution))
    }
    
    func test_solve_emptyBoard_shouldReturnSolution() {
        let board: [[Int?]] = [
            [nil, nil, nil, nil],
            [nil, nil, nil, nil],
            [nil, nil, nil, nil],
            [nil, nil, nil, nil]
        ]
        expect {
            try self.solver.solve(board)
        }.toNot(throwError())
    }
    
    func test_solve_invalidBoardSize_shouldThrowError() {
        let board: [[Int?]] = [
            [ 1 , nil, nil],
            [nil,  2 , nil],
            [nil, nil,  3 ]
        ]
        expect {
            try self.solver.solve(board)
        }.to(throwError(SudokuSolverError.invalidCells))
    }
    
    func test_solve_lessRowsThanColumns_shouldThrowError() {
        let board: [[Int?]] = [
            [ 1 , nil, nil, nil, nil],
            [nil,  2 , nil, nil, nil],
            [nil, nil,  3 , nil,  5 ],
            [nil, nil, nil,  4 , nil]
        ]
        expect {
            try self.solver.solve(board)
        }.to(throwError(SudokuSolverError.invalidCells))
    }
    
    func test_solve_moreRowsThanColumns_shouldThrowError() {
        let board: [[Int?]] = [
            [ 2 , nil, nil],
            [nil,  3 , nil],
            [nil, nil,  1 ],
            [ 3 , nil, nil]
        ]
        expect {
            try self.solver.solve(board)
        }.to(throwError(SudokuSolverError.invalidCells))
    }
    
    func test_solve_rowsWithDifferentSizes_shouldThrowError() {
        let board: [[Int?]] = [
            [nil, nil,  1 ],
            [nil,  2 , nil],
            [ 3 , nil],
            [nil,  1 , nil]
        ]
        expect {
            try self.solver.solve(board)
        }.to(throwError(SudokuSolverError.invalidCells))
    }

}

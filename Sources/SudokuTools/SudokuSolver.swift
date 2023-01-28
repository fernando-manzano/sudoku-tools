//
//  SudokuSolver.swift
//  
//
//  Created by Fernando Jose Manzano on 18/1/23.
//

import Foundation

public class SudokuSolver {
    
    typealias Board = [[Int?]]
    
    public func solve(_ board: [[Int?]]) throws -> [[Int]] {
        var board = board
        let solutionFound = recursiveSolver(&board)
        if solutionFound {
            return createSolution(from: board)
        } else {
            throw SudokuSolverError.noSolution
        }
    }
    
    private func recursiveSolver(_ board: inout Board) -> Bool {
        for (rowIndex, row) in board.enumerated() {
            for (columnIndex, element) in row.enumerated() {
                if element == nil {
                    var candidates = findCandidates(board, row: rowIndex, column: columnIndex)
                    var solutionFound = false
                    while !solutionFound && !candidates.isEmpty {
                        board[rowIndex][columnIndex] = candidates.removeFirst()
                        solutionFound = recursiveSolver(&board)
                    }
                    return solutionFound
                }
            }
        }
        return true
    }
    
    private func createSolution(from board: Board) -> [[Int]] {
        return board.map { row in
            row.compactMap { $0 }
        }
    }
    
    private func findCandidates(_ board: Board, row: Int, column: Int) -> [Int] {
        guard board[row][column] == nil else {
            return []
        }
        let rowValues = board[row].compactMap { $0 }
        let columnValues = board.compactMap { row in row[column] }
        let allValues = 1...board.count
        let candidates = allValues.filter { value in
            !columnValues.contains(value) && !rowValues.contains(value)
        }
        return candidates
    }
    
}

public enum SudokuSolverError: Error {
    case noSolution
}

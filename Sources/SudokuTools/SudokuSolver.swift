//
//  SudokuSolver.swift
//  
//
//  Created by Fernando Jose Manzano on 18/1/23.
//

import Foundation

public class SudokuSolver {
    
    public init() {}
    
    public func solve(_ cells: [[Int?]]) throws -> [[Int]] {
        
        guard let board = SudokuBoard(cells: cells) else {
            throw SudokuSolverError.invalidCells
        }

        let solutionFound = recursiveSolver(board)
        if solutionFound {
            return createSolution(from: board)
        } else {
            throw SudokuSolverError.noSolution
        }

    }
    
    private func recursiveSolver(_ board: SudokuBoard) -> Bool {
        var boardIndex = BoardIndex(length: board.size)
        while let cellIndex = boardIndex.nextIndex() {
            let cell = board.cells[cellIndex.row][cellIndex.column]
            if cell == nil {
                var candidates = findCandidates(board, row: cellIndex.row, column: cellIndex.column)
                var solutionFound = false
                while !solutionFound && !candidates.isEmpty {
                    board.cells[cellIndex.row][cellIndex.column] = candidates.removeFirst()
                    solutionFound = recursiveSolver(board)
                }
                if !solutionFound {
                    board.cells[cellIndex.row][cellIndex.column] = nil
                }
                return solutionFound
            }
        }
        return true
    }
    
    private func createSolution(from board: SudokuBoard) -> [[Int]] {
        return board.cells.map { row in
            row.compactMap { $0 }
        }
    }
    
    private func findCandidates(_ board: SudokuBoard, row: Int, column: Int) -> [Int] {
        
        guard board.cells[row][column] == nil else {
            return []
        }
        
        let rowCells = board.getCells(inRow: row)
        let columnCells = board.getCells(inColumn: column)
        let blockCells = board.getCellsInBlock(row: row, column: column)
        let allValues = board.getPossibleValues()
        
        let candidates = allValues.filter { value in
            !columnCells.contains(value) && !rowCells.contains(value) && !blockCells.contains(value)
        }

        return candidates
    }
    
}

public enum SudokuSolverError: Error {
    case noSolution
    case invalidCells
}

class SudokuBoard {
    
    var cells: [[Int?]]
    let size: Int
    let blockSize: Int
    
    init?(cells: [[Int?]]) {
        let boardSize = cells.count
        let blockSize = Int(exactly: sqrt(Double(boardSize)))
        let cellIsSquare = cells.allSatisfy { row in
            return row.count == boardSize
        }
        if cellIsSquare, let blockSize = blockSize {
            self.blockSize = blockSize
            self.cells = cells
            self.size = cells.count
        } else {
            return nil
        }
    }
    
    func getCells(inRow row: Int) -> [Int] {
        return cells[row].compactMap { $0 }
    }
    
    func getCells(inColumn column: Int) -> [Int] {
        return cells.compactMap { row in row[column] }
    }
    
    func getCellsInBlock(row: Int, column: Int) -> [Int] {
        var cellsInBlock = [Int]()
        let blockBoundaries = getBlockBoundaries(row: row, column: column)
        for row in cells[blockBoundaries.fromRow..<blockBoundaries.toRow] {
            for cell in row[blockBoundaries.fromColumn..<blockBoundaries.toColumn] {
                if let cellValue = cell {
                    cellsInBlock.append(cellValue)
                }
            }
        }
        return cellsInBlock
    }
    
    func getPossibleValues() -> ClosedRange<Int> {
        return 1...size
    }
    
    func getBlockBoundaries(row: Int, column: Int) -> BoardBlockBoundaries {
        let fromRow = row - row % blockSize
        let toRow = fromRow + blockSize
        let fromColumn = column - column % blockSize
        let toColumn = fromColumn + blockSize
        return BoardBlockBoundaries(fromRow: fromRow, toRow: toRow, fromColumn: fromColumn, toColumn: toColumn)
    }
    
}

struct BoardBlockBoundaries {
    let fromRow: Int
    let toRow: Int
    let fromColumn: Int
    let toColumn: Int
}

struct BoardIndex: Hashable {
    
    private var row: Int
    private var column: Int
    private let length: Int
    
    init(length: Int) {
        self.row = 0
        self.column = 0
        self.length = length
    }
    
    mutating func nextIndex() -> (row: Int, column: Int)? {
        if indexOutOfRange() {
            return nil
        } else {
            let currentIndex = (row, column)
            moveIndexForward()
            return currentIndex
        }
    }
    
    private func indexOutOfRange() -> Bool {
        return row == length
    }
    
    private mutating func moveIndexForward() {
        if column < length - 1  {
            column += 1
        } else {
            row += 1
            column = 0
        }
    }
    
}

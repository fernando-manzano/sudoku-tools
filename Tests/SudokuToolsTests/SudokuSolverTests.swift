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
            
            context("valid board") {
                describe("empty board of 1x1") {
                    it("should solve to 1") {
                        let solution = solver.solve([[nil]])
                        expect(solution).to(equal([[1]]))
                    }
                }
            }

        }
        
    }
}

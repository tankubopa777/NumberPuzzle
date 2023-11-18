//
//  PuzzleLogic.swift
//  NumberPuzzle
//
//  Created by warunporn intarachana on 10/11/2566 BE.
//

import Foundation

class PuzzleLogic: ObservableObject {
    @Published var numbers = Array(1...15) + [0]
    @Published var hasWon = false
    @Published var moveCount = 0
    
    init() {
        newGame()
    }

//  move number
    func moveNumber(row: Int, column: Int) {
//  when you win you can not move number
        if hasWon {
            return
        }

        let index = row * 4 + column
//      check above if its clear
        if let above = index < 4 ? nil : index - 4, numbers[above] == 0 {
            numbers.swapAt(above, index)
            moveCount += 1
//      check below if its clear
        } else if let below = index > 11 ? nil : index + 4, numbers[below] == 0 {
            numbers.swapAt(below, index)
            moveCount += 1
//      check left side if its clear
        } else if let left = column == 0 ? nil : index - 1, numbers[left] == 0 {
            numbers.swapAt(left, index)
            moveCount += 1
//      check right side if its clear
        } else if let right = column == 3 ? nil : index + 1, numbers[right] == 0 {
            numbers.swapAt(right, index)
            moveCount += 1
        }

        checkWin()
    }

    func newGame() {
        numbers.shuffle()
        while !isSolvable(numbers) {
            numbers.shuffle()
        }
        hasWon = false
        moveCount = 0
    }

// function for check win
//    func winNow() {
//        numbers = Array(1...15) + [0]
//        hasWon = true
//    }

    private func checkWin() {
        hasWon = numbers == Array(1...15) + [0]
    }

//  function for check this random number you can win
    func isSolvable(_ numbers: [Int]) -> Bool {
        var inversions = 0
        for i in 0..<numbers.count {
            for j in i+1..<numbers.count {
                if numbers[i] > numbers[j] && numbers[i] != 0 && numbers[j] != 0 {
                    inversions += 1
                }
            }
        }

        let rowOfBlankSpace = (numbers.firstIndex(of: 0)! / 4) + 1
        if rowOfBlankSpace % 2 == 0 {
            return inversions % 2 == 0
        } else {
            return inversions % 2 != 0
        }
    }

}


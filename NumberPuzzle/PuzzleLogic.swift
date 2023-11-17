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

    func moveNumber(row: Int, column: Int) {
        // ถ้าเกมชนะแล้ว ไม่ทำอะไรทั้งสิ้น
        if hasWon {
            return
        }
        
        let index = row * 4 + column
        if let above = index < 4 ? nil : index - 4, numbers[above] == 0 {
            numbers.swapAt(above, index)
            moveCount += 1
        } else if let below = index > 11 ? nil : index + 4, numbers[below] == 0 {
            numbers.swapAt(below, index)
            moveCount += 1
        } else if let left = column == 0 ? nil : index - 1, numbers[left] == 0 {
            numbers.swapAt(left, index)
            moveCount += 1
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

    func winNow() {
        numbers = Array(1...15) + [0]
        hasWon = true
        // รีเซ็ตจำนวนการเคลื่อนไหวเมื่อชนะเกม

    }

    private func checkWin() {
        hasWon = numbers == Array(1...15) + [0]
    }

    private func isSolvable(_ numbers: [Int]) -> Bool {
        // Logic to determine if the puzzle is solvable
        return true
    }
}


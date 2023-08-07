//
//  SudosuVIew.swift
//  KuComics
//
//  Created by weixin on 2023/4/27.
//

import SwiftUI

// 数独数据模型
struct Sudoku {
    var board: [[Int]]
    
    // 生成随机棋盘
    init() {
        board = Array(repeating: Array(repeating: 0, count: 9), count: 9)
        for i in 0..<9 {
            for j in 0..<9 {
                if Bool.random() { // 50% 的概率生成随机数字
                    board[i][j] = Int.random(in: 1...9)
                }
            }
        }
    }
    
    // 检查行、列、宫是否存在重复数字
    func isInvalid(_ row: Int, _ col: Int) -> Bool {
        let num = board[row][col]
        
        // 检查行
        for i in 0..<9 {
            if i != col && board[row][i] == num {
                return true
            }
        }
        
        // 检查列
        for i in 0..<9 {
            if i != row && board[i][col] == num {
                return true
            }
        }
        
        // 检查宫
        let startRow = row / 3 * 3
        let startCol = col / 3 * 3
        for i in startRow...startRow+2 {
            for j in startCol...startCol+2 {
                if (i != row || j != col) && board[i][j] == num {
                    return true
                }
            }
        }
        
        return false
    }
    
    // 检查是否解决方案
    func isSolved() -> Bool {
        for i in 0..<9 {
            for j in 0..<9 {
                if board[i][j] == 0 || isInvalid(i, j) {
                    return false
                }
            }
        }
        return true
    }
}

struct SudokuGameView: View {
    @StateObject var viewModel = SudokuGameViewModel()
    
    var body: some View {
        VStack {
            Text("数独游戏").font(.title).padding()
            
            VStack(spacing: 10) {
                ForEach(0..<9) { row in
                    HStack(spacing: 10) {
                        ForEach(0..<9) { col in
                            TextField("", value: $viewModel.sudoku.board[row][col], formatter: NumberFormatter())
                                .multilineTextAlignment(.center)
                                .font(Font.system(size: 20, weight: .black))
                                .foregroundColor(viewModel.isInvalid(row, col) ? .red : .primary)
                                .frame(width: 30, height: 30)
                                .background(Color.white)
                                .cornerRadius(4)
                        }
                    }
                }
            }
            
            HStack {
                Button("重置") {
                    viewModel.reset()
                }
                Spacer()
                Button("显示答案") {
                    viewModel.showAnswer()
                }
            }.padding()
            
            if viewModel.isSolved {
                Text("恭喜你，你解决了数独").font(.headline).foregroundColor(.green)
            }
        }
    }
}

struct SudokuGameView_Previews: PreviewProvider {
    static var previews: some View {
        SudokuGameView()
    }
}

class SudokuGameViewModel: ObservableObject {
    @Published var sudoku = Sudoku()
    
    // 检查是否存在错误
    func isInvalid(_ row: Int, _ col: Int) -> Bool {
        return !sudoku.isSolved() && sudoku.isInvalid(row, col)
    }
    
    // 重置游戏
    func reset() {
        sudoku = Sudoku()
    }

    // 显示答案
    func showAnswer() {
        for i in 0..<9 {
            for j in 0..<9 {
                sudoku.board[i][j] = sudoku.board[i][j]
            }
        }
    }
    
    // 检查答案是否正确
    var isSolved: Bool {
        return sudoku.isSolved()
    }
}

//
//  Grid.swift
//  Entrop.io
//
//  Created by Thomas Sabino-Benowitz on 9/25/20.
//

import Foundation

protocol DelegateMethods {
    func updateGrid()
    func showGeneration()
    func showPopulation()
    
}

public enum Patterns {
    case random
    case behive
    case blinker
    case toad
    case beacon
    case pulsar
    case pentadecathlon
    case glider
}

class GameGrid: NSObject {
    let size: Int
    var cells: [Cell] = []
    
    var generation = 0
    var population: Int {
        cells.filter{$0.status == .off }.count
    }
    
    
    var delegateMethods: DelegateMethods?
    
    public init(gridSize: Int) {
        self.size = gridSize
        
        for y in 0..<size {
            for x in 0..<size {
                let cell = Cell(x: x, y: y)
                cells.append(cell)
            }
        }
        
        super.init()
        
        self.presetPatterns(pattern: .glider)
    }
    
    private func randomizeGrid() {
        for cell in cells {
            let randomStatus = Int.random(in: 0...5)
            cell.status = randomStatus == 0 ? .on : .off
        }
    }
    
    func clearGrid() {
        for cell in cells {
            cell.status = .off
        }
        generation = 0
        
        callDelegateMethods()
    }
    
    public func presetPatterns(pattern: Patterns = .behive) {
        print(pattern)
        
        clearGrid()
        
        switch pattern {
        case .random:
            randomizeGrid()
            
        case .behive:
            
            cellAt(x: 3, y: 2).status = .on
                cellAt(x: 4, y: 2).status = .on
            
                cellAt(x: 2, y: 3).status = .on
                cellAt(x: 5, y: 3).status = .on
            
                cellAt(x: 3, y: 4).status = .on
                cellAt(x: 4, y: 4).status = .on
            
        case .blinker:
            
            cellAt(x: 3, y: 2).status = .on
            cellAt(x: 4, y: 2).status = .on
            cellAt(x: 5, y: 2).status = .on
            
        case .toad:
            
            cellAt(x: 4, y: 3).status = .on
                cellAt(x: 5, y: 3).status = .on
                cellAt(x: 6, y: 3).status = .on
            
                cellAt(x: 3, y: 4).status = .on
                cellAt(x: 4, y: 4).status = .on
                cellAt(x: 5, y: 4).status = .on
            
        case .beacon:
            
            cellAt(x: 2, y: 2).status = .on
            cellAt(x: 3, y: 2).status = .on
            cellAt(x: 2, y: 3).status = .on
            
            cellAt(x: 5, y: 4).status = .on
            cellAt(x: 4, y: 5).status = .on
            cellAt(x: 5, y: 5).status = .on
            
        case .pulsar:
            // Row 1
            cellAt(x: 6, y: 2).status = .on
                cellAt(x: 6, y: 3).status = .on
                cellAt(x: 6, y: 4).status = .on
                cellAt(x: 7, y: 4).status = .on
            
                cellAt(x: 12, y: 2).status = .on
                cellAt(x: 12, y: 3).status = .on
                cellAt(x: 12, y: 4).status = .on
                cellAt(x: 11, y: 4).status = .on
            
            // Row 2
                cellAt(x: 2, y: 6).status = .on
                cellAt(x: 3, y: 6).status = .on
                cellAt(x: 4, y: 6).status = .on
                cellAt(x: 4, y: 7).status = .on
            
                cellAt(x: 7, y: 6).status = .on
                cellAt(x: 8, y: 6).status = .on
                cellAt(x: 8, y: 7).status = .on
                cellAt(x: 6, y: 7).status = .on
                cellAt(x: 6, y: 8).status = .on
                cellAt(x: 7, y: 8).status = .on
            
                cellAt(x: 10, y: 6).status = .on
                cellAt(x: 11, y: 6).status = .on
                cellAt(x: 10, y: 7).status = .on
                cellAt(x: 12, y: 7).status = .on
                cellAt(x: 11, y: 8).status = .on
                cellAt(x: 12, y: 8).status = .on
            
                cellAt(x: 14, y: 6).status = .on
                cellAt(x: 15, y: 6).status = .on
                cellAt(x: 16, y: 6).status = .on
                cellAt(x: 14, y: 7).status = .on
            
            // Row 3
                cellAt(x: 2, y: 12).status = .on
                cellAt(x: 3, y: 12).status = .on
                cellAt(x: 4, y: 12).status = .on
                cellAt(x: 4, y: 11).status = .on
            
                cellAt(x: 6, y: 10).status = .on
                cellAt(x: 7, y: 10).status = .on
                cellAt(x: 6, y: 11).status = .on
                cellAt(x: 8, y: 11).status = .on
                cellAt(x: 7, y: 12).status = .on
                cellAt(x: 8, y: 12).status = .on
            
                cellAt(x: 11, y: 10).status = .on
                cellAt(x: 12, y: 10).status = .on
                cellAt(x: 12, y: 11).status = .on
                cellAt(x: 10, y: 11).status = .on
                cellAt(x: 10, y: 12).status = .on
                cellAt(x: 11, y: 12).status = .on
            
                cellAt(x: 14, y: 11).status = .on
                cellAt(x: 14, y: 12).status = .on
                cellAt(x: 15, y: 12).status = .on
                cellAt(x: 16, y: 12).status = .on
            
            // Row 4
                cellAt(x: 6, y: 14).status = .on
                cellAt(x: 6, y: 15).status = .on
                cellAt(x: 6, y: 16).status = .on
                cellAt(x: 7, y: 14).status = .on
            
                cellAt(x: 12, y: 14).status = .on
                cellAt(x: 12, y: 15).status = .on
                cellAt(x: 12, y: 16).status = .on
                cellAt(x: 11, y: 14).status = .on
            
        case .pentadecathlon:
            // Object 1
            cellAt(x: 5, y: 4).status = .on
            cellAt(x: 6, y: 4).status = .on
            cellAt(x: 7, y: 4).status = .on
            cellAt(x: 6, y: 5).status = .on
            cellAt(x: 6, y: 6).status = .on
            cellAt(x: 5, y: 7).status = .on
            cellAt(x: 6, y: 7).status = .on
            cellAt(x: 7, y: 7).status = .on
            
            // Object 2
            cellAt(x: 5, y: 9).status = .on
            cellAt(x: 6, y: 9).status = .on
            cellAt(x: 7, y: 9).status = .on
            cellAt(x: 5, y: 10).status = .on
            cellAt(x: 6, y: 10).status = .on
            cellAt(x: 7, y: 10).status = .on
            
            // Object 3
            cellAt(x: 5, y: 12).status = .on
            cellAt(x: 6, y: 12).status = .on
            cellAt(x: 7, y: 12).status = .on
            cellAt(x: 6, y: 13).status = .on
            cellAt(x: 6, y: 14).status = .on
            cellAt(x: 5, y: 15).status = .on
            cellAt(x: 6, y: 15).status = .on
            cellAt(x: 7, y: 15).status = .on
            
        case .glider:
                cellAt(x: 3, y: 2).status = .on
                cellAt(x: 4, y: 3).status = .on
                cellAt(x: 4, y: 4).status = .on
                cellAt(x: 3, y: 4).status = .on
                cellAt(x: 2, y: 4).status = .on
        }
        
        generation = 0
        
        callDelegateMethods()
        
    }
    
    func cellAt(x: Int, y: Int) -> Cell {
        var position: Int
        position = (y * size) + x
        return cells[position]
    }
    
    func cellCoordinates(index: Int) -> (x: Int, y: Int) {
        var x = 0
        var y = 0
        
        y = index / size
        x = index - (y * size)
        
        return (x, y)
    }
    
    func cellTapped(at index: Int) {
        if cells[index].status == .on {
            cells[index].status = .off
        } else {
            cells[index].status = .on
        }
        callDelegateMethods()
    }
    
    func performGameTurn() {
        var index = 0
        var cellsInOffing: [Cell] = []
        var conceivedCells: [Cell] = []
        
        for cell in cells {
            var count = 0
            let coordinates = cellCoordinates(index: index)
            
            // West
            if coordinates.x != 0 {
                if cellAt(x: coordinates.x - 1, y: coordinates.y).status == .on {
                    count = count + 1
                }
            }
            
            // North West
            if coordinates.x != 0 && coordinates.y != 0 {
                if cellAt(x: coordinates.x - 1, y: coordinates.y - 1).status == .on {
                    count = count + 1
                }
            }
            
            // North
            if coordinates.y != 0 {
                if cellAt(x: coordinates.x, y: coordinates.y - 1).status == .on {
                    count = count + 1
                }
            }
            
            // North East
            if coordinates.x < (size - 1) && coordinates.y != 0 {
                if cellAt(x: coordinates.x + 1, y: coordinates.y - 1).status == .on {
                    count = count + 1
                }
            }
            
            // East
            if coordinates.x < (size - 1) {
                if cellAt(x: coordinates.x + 1, y: coordinates.y).status == .on {
                    count = count + 1
                }
            }
            
            // South East
            if coordinates.x < (size - 1) && coordinates.y < (size - 1) {
                if cellAt(x: coordinates.x + 1, y: coordinates.y + 1).status == .on {
                    count = count + 1
                }
            }
            
            // South
            if coordinates.y < (size - 1) {
                if cellAt(x: coordinates.x, y: coordinates.y + 1).status == .on {
                    count = count + 1
                }
            }
            
            // South West
            if coordinates.x != 0 && coordinates.y < (size - 1) {
                if cellAt(x: coordinates.x - 1, y: coordinates.y + 1).status == .on {
                    count = count + 1
                }
            }
            
            if cell.status == .on {
                if count < 2 || count > 3 {
                    cellsInOffing.append(cell)
                }
            } else { // cell.status= .on
                if count == 3 {
                    conceivedCells.append(cell)
                }
            }
            index = index + 1
        }
        
        for cell in cellsInOffing {
            cell.status = .off
        }
        
        for cell in conceivedCells {
            cell.status = .on
        }
        
        generation += 1
        callDelegateMethods()
    }

    private func callDelegateMethods() {
        delegateMethods?.updateGrid()
        delegateMethods?.showGeneration()
        delegateMethods?.showPopulation()
    }

}

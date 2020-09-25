//
//  GridView.swift
//  Entrop.io
//
//  Created by Thomas Sabino-Benowitz on 9/25/20.
//

import UIKit

class GridView: UIView {

    // MARK: Properties
    var gameGrid = GameGrid(gridSize: 25)
    private var cellSize: Int = 15
    
    private var timer: Timer?
    var timeInterval = 0.25
    var timerRunning: Bool {
        timer == nil ? false : true
    }
    
    public convenience init(gridSize: Int, cellSize: Int) {
        let frame = CGRect(x: 0, y: 0, width: cellSize * gridSize, height: cellSize * gridSize)
        self.init(frame: frame)
        self.gameGrid = GameGrid(gridSize: gridSize)
        self.cellSize = cellSize
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - Functions
    
    public func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    public func clearGrid() {
        gameGrid.clearGrid()
        setNeedsDisplay()
    }
    
    public func cellTapped(at index: Int) {
        gameGrid.cellTapped(at: index)
        setNeedsDisplay()
    }
    
    @objc private func performGameTurn() {
        self.gameGrid.performGameTurn()
        self.setNeedsDisplay()
    }
    
    public func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: self,
                                     selector: #selector(performGameTurn),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    public func step() {
        gameGrid.performGameTurn()
        setNeedsDisplay()
    }
    
    public func presetPattern(pattern: Patterns) {
        gameGrid.clearGrid()
        gameGrid.presetPatterns(pattern: pattern)
        setNeedsDisplay()
    }
    
}



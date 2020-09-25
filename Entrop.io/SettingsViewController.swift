//
//  SettingsViewController.swift
//  Entrop.io
//
//  Created by Thomas Sabino-Benowitz on 9/25/20.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: Properties
    var gridView: GridView?
    var gameViewController: GameViewController?
    
    //MARK: Outlets
    @IBOutlet weak var speedSegmentedControl: UISegmentedControl!
    @IBOutlet weak var colorSegmentedControl: UISegmentedControl!
    
    
    // MARK: Actions
    @IBAction func colorSegmentedControl(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 1:
            gameViewController?.cellsColor = UIColor.systemRed
        case 2:
            gameViewController?.cellsColor = UIColor.systemBlue
        case 3:
            gameViewController?.cellsColor = UIColor.systemGreen
        default:
            gameViewController?.cellsColor = UIColor.systemOrange
        }
    }
    
    
    @IBAction func speedSegmentedControl(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 1:
            gridView?.timeInterval = 0.50
        case 2:
            gridView?.timeInterval = 0.75
        case 3:
            gridView?.timeInterval = 1.0
        default:
            gridView?.timeInterval = 0.25
        }
    }
    
    
    @IBAction func playButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the current speed
        switch(gridView?.timeInterval) {
        case 0.50:
            speedSegmentedControl.selectedSegmentIndex = 1
        case 0.75:
            speedSegmentedControl.selectedSegmentIndex = 2
        case 1.00:
            speedSegmentedControl.selectedSegmentIndex = 3
        default:
            speedSegmentedControl.selectedSegmentIndex = 0
        }
        // Load the current color
        switch(gameViewController?.cellsColor) {
        case UIColor.systemRed:
            colorSegmentedControl.selectedSegmentIndex = 1
        case UIColor.systemBlue:
            colorSegmentedControl.selectedSegmentIndex = 2
        case UIColor.systemGreen:
            colorSegmentedControl.selectedSegmentIndex = 3
        default: // Default to orange
            colorSegmentedControl.selectedSegmentIndex = 0
        }
    }
}

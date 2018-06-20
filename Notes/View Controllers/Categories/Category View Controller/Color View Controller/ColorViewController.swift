//
//  ColorViewController.swift
//  Notes
//
//  Created by Виктория Бадисова on 20.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit

protocol ColorViewControllerDelegate {
    func controller(_ controller: ColorViewController, didPick color: UIColor)
}

class ColorViewController: UIViewController {
    
    //MARK: - Properties

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    //MARK: -
    
    var delegate: ColorViewControllerDelegate?
    
    //MARK: -
    
    var color: UIColor = .white
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Choose color"
        
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.controller(self, didPick: colorView.backgroundColor ?? .white)
    }
    
    //MARK: - View methods
    
    private func setupView() {
        setupSliders()
        setupColorView()
 
    }
    
    private func setupSliders() {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        redSlider.value = Float(r)
        greenSlider.value = Float(g)
        blueSlider.value = Float(b)
    }
    
    private func setupColorView() {
        updateColorView()
    }
    
    private func updateColorView() {
        let color = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1.0)
        colorView.backgroundColor = color
    }
    
    //MARK: - Actions
    
    @IBAction func colorDidChange(_ sender: UISlider) {
        updateColorView()
    }
    
}

//
//  CustomNavigationBar.swift
//  GoGame
//
//  Created by FFK on 20.05.2024.
//

import UIKit

protocol CustomNavigationProtocol: AnyObject {
    
    func firstButtonTapped()
    func secondButtonTapped()
}

class CustomNavigationBar: UIView {
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    weak var delegate: CustomNavigationProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureNibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureNibView()
    }
    
    private func loadViewFromNib() -> UIView? {
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: .main)
        return nib.instantiate(withOwner: self).first as? UIView
    }
    
    private func configureNibView() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        addSubview(view)
        setUp()
    }
    
    private func setUp() {
        firstButton.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        secondButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        thirdButton.setImage(UIImage(systemName: "bell.badge"), for: .normal)

    }
    
    @IBAction func firstButton(_ sender: UIButton) {
        delegate?.firstButtonTapped()
    }
    
    @IBAction func secondButton(_ sender: UIButton) {
        delegate?.secondButtonTapped()
    }
}

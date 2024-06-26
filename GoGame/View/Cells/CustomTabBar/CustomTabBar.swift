//
//  CustomTabBar.swift
//  GoGame
//
//  Created by FFK on 24.05.2024.
//

import UIKit

protocol CustomTabBarProtocol: AnyObject {
    func favouriteButtonTapped()
}

class CustomTabBar: UIView {
    
    weak var delegate: CustomTabBarProtocol?
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var networkButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var personButton: UIButton!
    
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
    
    func configureNibView() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        addSubview(view)
        
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func favouriteButtonTapped() {
        delegate?.favouriteButtonTapped()
    }
    
}

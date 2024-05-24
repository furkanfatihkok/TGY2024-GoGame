//
//  CustomNavigationBar.swift
//  GoGame
//
//  Created by FFK on 20.05.2024.
//

import UIKit


protocol CustomNavigationProtocol: AnyObject {
    func searchButtonTapped()
}

class CustomNavigationBar: UIView {
    
    @IBOutlet weak var lineButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var bellButton: UIButton!
    
    weak var delegate: CustomNavigationProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureNibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureNibView()
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: .main)
        return nib.instantiate(withOwner: self).first as? UIView
    }
    
    func configureNibView() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        addSubview(view)
        setUp()
    }
    
    private func setUp() {
        lineButton.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        bellButton.setImage(UIImage(systemName: "bell.badge"), for: .normal)

    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        delegate?.searchButtonTapped()
    }
    
}

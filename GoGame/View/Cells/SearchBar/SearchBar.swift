//
//  SearchBar.swift
//  GoGame
//
//  Created by FFK on 24.05.2024.
//

import UIKit

protocol SearchBarProtocol: AnyObject {
    func searchTextFieldTapped()
}

class SearchBar: UIView {
    
    @IBOutlet weak var discoverLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    weak var delegate: SearchBarProtocol?
    
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
    }
    
    @IBAction func searchTextButton(_ sender: UITextField) {
        delegate?.searchTextFieldTapped()
    }
    
}

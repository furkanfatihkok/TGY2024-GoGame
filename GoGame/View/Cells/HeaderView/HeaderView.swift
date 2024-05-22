//
//  HeaderView.swift
//  GoGame
//
//  Created by FFK on 20.05.2024.
//

import UIKit

class HeaderView: UIView {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var viewLabel: UILabel!
    
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
}

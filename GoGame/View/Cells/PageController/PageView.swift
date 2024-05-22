//
//  PageView.swift
//  GoGame
//
//  Created by FFK on 22.05.2024.
//

import UIKit
import Kingfisher

class PageView: UIView {
    
    @IBOutlet weak var pageImage: UIImageView!
    @IBOutlet weak var pageController: UIPageControl!
    
    private var imageUrls: [String] = []
    private var currentIndex: Int = 0
    
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
        
        setupPageController()
    }
    
    func setupPageController() {
        pageController.addTarget(self, action: #selector(pageControlTapped(_ :)), for: .valueChanged)
    }
    
    func updateImage(with urls: [String]) {
        imageUrls = urls
        pageController.numberOfPages = urls.count
        pageController.currentPage = 0
        updatePageImage()
    }
    
    private func updatePageImage() {
        guard !imageUrls.isEmpty, currentIndex < imageUrls.count else { return }
        let imageUrl = imageUrls[currentIndex]
        if let url = URL(string: imageUrl) {
            pageImage.kf.setImage(with: url)
        }
    }
    
    @objc private func pageControlTapped(_ sender: UIPageControl) {
        currentIndex = sender.currentPage
        updatePageImage()
    }
}

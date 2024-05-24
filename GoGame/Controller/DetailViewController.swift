//
//  DetailViewController.swift
//  GoGame
//
//  Created by FFK on 24.05.2024.
//

import UIKit
import Kingfisher

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var gamesImage: UIImageView!
    @IBOutlet weak var gamesName: UILabel!
    @IBOutlet weak var gamesDescription: UILabel!
    
    var selectedID: Int?
    
    weak var delegate: CustomNavigationProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.delegate = self
        
        navigationBar.lineButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        navigationBar.searchButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        navigationBar.bellButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        
        navigationBar.lineButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        navigationBar.bellButton.layer.cornerRadius = 25
        
        mainView.layer.cornerRadius = 24
        gamesImage.layer.cornerRadius = 25
        
        if let gameID = selectedID {
            fetchGamesDetail(gameID)
        }
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true)
    }
    
    private func fetchGamesDetail(_ gameID: Int) {
        GameNetworking.shared.fetchGameDetails(gameID: gameID) { [weak self] response in
            switch response {
            case .success(let gameDetail):
                DispatchQueue.main.sync {
                    self?.configure(with: gameDetail)
                }
            case.failure(_):
                print("No fetching GamesDetail")
            }
        }
    }
    
    private func configure(with gameDetail: GameDetail) {
        gamesName.text = gameDetail.name
        gamesDescription.text = gameDetail.description.stringByRemovingHTMLTags()
        gamesImage.layer.cornerRadius = 25
        
        if let imageURL = URL(string: gameDetail.backgroundImage) {
            gamesImage.kf.setImage(with: imageURL)
        } else {
            gamesImage.image = nil
        }
        
        if let imageURL = URL(string: gameDetail.backgroundImage) {
            imageView.kf.setImage(with: imageURL)
        } else {
            imageView.image = nil
        }
    }
}

//MARK: - CustomNavigationProtocol

extension DetailViewController: CustomNavigationProtocol {
    func searchButtonTapped() {
        if navigationBar.searchButton.currentImage == UIImage(systemName: "bookmark.fill") {
            navigationBar.searchButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        } else {
            navigationBar.searchButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }
    }
    
}

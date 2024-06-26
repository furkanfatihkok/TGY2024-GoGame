//
//  DetailViewController.swift
//  GoGame
//
//  Created by FFK on 24.05.2024.
//

import UIKit
import Kingfisher

final class DetailViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var navigationBar: CustomNavigationBar!
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var gamesImage: UIImageView!
    @IBOutlet private weak var gamesName: UILabel!
    @IBOutlet private weak var gamesDescription: UILabel!
    @IBOutlet private weak var gamesReleased: UILabel!
    
    //MARK: - Properties
    
    var selectedID: Int?
    private var detailViewModel: DetailViewModel!
    
    //MARK: - LifeCycles Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        fetchGameDetails()
    }
    
    //MARK: - Setup Methods
    
    private func setupUI() {
        navigationBar.delegate = self
        navigationBar.firstButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        navigationBar.secondButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        navigationBar.thirdButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        
        mainView.layer.cornerRadius = 24
        gamesImage.layer.cornerRadius = 25
    }
    
    private func setupViewModel() {
        detailViewModel = DetailViewModel()
    }
    
    private func fetchGameDetails() {
        guard let gameID = selectedID else { return }
        detailViewModel.fetchGameDetails(gameID: gameID) { [weak self] response in
            switch response {
            case .success(let gameDetail):
                DispatchQueue.main.async {
                    self?.configure(with: gameDetail)
                }
            case .failure(_):
                print("No fetching DetailVC")
            }
        }
    }
    
    //MARK: - Configuration
    
    private func configure(with gameDetail: GameDetail) {
        gamesName.text = gameDetail.name
        gamesReleased.text = gameDetail.released
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
    
    func firstButtonTapped() {
        self.dismiss(animated: true)
    }
    
    func secondButtonTapped() {
        
        guard let gameID = selectedID,
              let name = gamesName.text,
              let released = gamesReleased.text else { return }
        
        if navigationBar.secondButton.currentImage == UIImage(systemName: "bookmark.fill") {
            navigationBar.secondButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            CoreDataManager.shared.deleteGame(id: Int64(gameID))
        } else {
            navigationBar.secondButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            CoreDataManager.shared.saveGame(id: Int64(gameID), name: name, released: released)
        }
    }
    
}

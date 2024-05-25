//
//  FavouriteCell.swift
//  GoGame
//
//  Created by FFK on 25.05.2024.
//

import UIKit
import Kingfisher

class FavouriteCell: UICollectionViewCell {
    
    static let identifier = "FavouriteCell"
    
    @IBOutlet weak var gamesImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with games: GameModel) {
        nameLabel.text = "GTA5"
        titleLabel.text = games.name
        mainLabel.text = games.id.description
        releasedLabel.text = games.released
        gamesImage.layer.cornerRadius = 24
        
        if let imageURL = URL(string: games.backgroundImage) {
            gamesImage.kf.setImage(with: imageURL)
        } else {
            gamesImage.image = nil
        }
    }
}

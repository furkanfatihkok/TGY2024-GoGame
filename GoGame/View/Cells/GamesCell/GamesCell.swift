//
//  GamesCell.swift
//  GoGame
//
//  Created by FFK on 22.05.2024.
//

import UIKit
import Kingfisher

class GamesCell: UICollectionViewCell {
    
    static let identifier = "GamesCell"
    
    @IBOutlet weak var gamesImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with game: Game) {
        nameLabel.text = "GTA5"
        titleLabel.text = game.name
        mainLabel.text = "HANGİ OYUNU DAHA ÇOK SEVİYORUM......"
        releasedLabel.text = game.released
        gamesImage.layer.cornerRadius = 24
        
        if let imageURL = URL(string: game.backgroundImage) {
            gamesImage.kf.setImage(with: imageURL)
        } else {
            gamesImage.image = nil
        }
    }
}

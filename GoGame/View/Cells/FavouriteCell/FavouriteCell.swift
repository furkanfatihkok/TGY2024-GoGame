//
//  FavouriteCell.swift
//  GoGame
//
//  Created by FFK on 26.05.2024.
//

import UIKit
import Kingfisher

class FavouriteCell: UITableViewCell {
    
    static let identifier = "FavouriteCell"
    
    @IBOutlet weak var gamesID: UILabel!
    @IBOutlet weak var gamesName: UILabel!
    @IBOutlet weak var gamesReleased: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with games: GameModel) {
        gamesID.text = String("\(games.id)")
        gamesName.text = games.name
        gamesReleased.text = games.released
        
    }
}


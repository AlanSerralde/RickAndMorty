//
//  sa.swift
//  RickAndMorty
//
//  Created by Diplomado on 05/12/23.
//

import UIKit

class RickAndMortyTableViewCell: UITableViewCell {
    
//    @IBOutlet weak var ImgCellOutlet: UIImageView!
    
    @IBOutlet weak var nameLabelCellOutlet: UILabel!
    
    @IBOutlet weak var speciesLabelCellOutlet: UILabel!
    
    @IBOutlet weak var idLabelCellOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)



    }
    
}

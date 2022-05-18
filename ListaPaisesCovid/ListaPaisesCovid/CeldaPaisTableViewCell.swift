//
//  CeldaPaisTableViewCell.swift
//  ListaPaisesCovid
//
//  Created by Mac13 on 29/04/22.
//

import UIKit

class CeldaPaisTableViewCell: UITableViewCell {

    @IBOutlet weak var banderaPais: UIImageView!
    @IBOutlet weak var nombrePaisLbl: UILabel!
    @IBOutlet weak var activosLbl: UILabel!
    @IBOutlet weak var recuperadosLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //redondear imagen
        banderaPais.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

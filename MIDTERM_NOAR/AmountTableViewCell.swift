//
//  AmountTableViewCell.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-16.
//

import UIKit

class AmountTableViewCell: UITableViewCell {

    
    @IBOutlet weak var amountName: UILabel!
    
    @IBOutlet weak var qnty: UILabel!
    
    @IBOutlet weak var amount: UILabel!
    
    @IBOutlet weak var timeDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  LineupTableVC.swift
//  Lucky Sports
//
//  Created by Qoo on 09/05/2023.
//

import UIKit

class LineupTableVC: UITableViewCell {

    @IBOutlet var titleLable: UILabel!
    @IBOutlet var countryLable: UILabel!
    @IBOutlet var imgTitle: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(data: ELineup){
        titleLable.text=data.playerName
        
        let url=data.playerPicUrl?.components(separatedBy: "_file")
        if (url?.count ?? 0) > 1  {
            imgTitle.setImage(with: BaseUrl.imgBaseURL + (url?[1] ?? "" ) , placeholder: Utility.getPlaceHolder())
        }else{
            imgTitle.image=UIImage(named: "allLeagues")
        }
      }
    
}

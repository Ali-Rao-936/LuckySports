//
//  HomeMatchesItemTableVC.swift
//  Lucky Sports
//
//  Created by Qoo on 09/05/2023.
//

import UIKit

class HomeMatchesItemTableVC: UITableViewCell {
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var imgLeague: UIImageView!
    @IBOutlet var leagueLable: UILabel!
    @IBOutlet var statusLable: UILabel!
    @IBOutlet var gameImage: UIImageView!
    @IBOutlet var gameLable: UILabel!
    @IBOutlet var homeImage: UIImageView!
    @IBOutlet var awayImage: UIImageView!
    @IBOutlet var vsLable: UILabel!
    @IBOutlet var awayName: UILabel!
    @IBOutlet var homeName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(data:DataEsports){
        let url=data.league?.logoUrl?.components(separatedBy: "_file")
        if (url?.count ?? 0) > 1  {
            self.imgLeague.setImage(with: BaseUrl.imgBaseURL + (url?[1] ?? "" ) , placeholder: Utility.getPlaceHolder())
        }
        if Utility.getCurrentLang() == "cn"{
            leagueLable.text=data.league?.cnName
        }else{
            leagueLable.text=data.league?.enName
        }

        gameLable.text = data.statusName
        homeImage.setImage(with: data.homeTeamLogo, placeholder: Utility.getPlaceHolder())
        awayImage.setImage(with: data.awayTeamLogo, placeholder: Utility.getPlaceHolder())
        homeName.text=data.homeTeamName
        awayName.text=data.awayTeamName
    }
    
}

//
//  MatchDetailsItemTableVC.swift
//  Lucky Sports
//
//  Created by Qoo on 09/05/2023.
//

import UIKit

class MatchDetailsItemTableVC: UITableViewCell {
    
    @IBOutlet var timeLable: UILabel!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var awayTeamLogo: UIImageView!
    @IBOutlet weak var homeTeamLogo: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(data:Scores,homeTeamName:String,awayTeamName:String,homeTeamLogo:String,awayTeamLogo:String){
        self.homeTeamLogo.setImage(with: homeTeamLogo, placeholder: Utility.getPlaceHolder())
        self.awayTeamLogo.setImage(with: awayTeamLogo, placeholder: Utility.getPlaceHolder())
        self.awayTeamLogo.cornerRadius = self.awayTeamLogo.bounds.height / 2
        self.homeTeamLogo.cornerRadius = self.homeTeamLogo.bounds.height / 2
        
        self.homeScore.text = data.team1 ?? "0"
        self.awayScore.text = data.team2 ?? "0"
        self.homeTeamName.text=homeTeamName
        self.awayTeamName.text=awayTeamName
        
        self.timeLable.text = data.type
    }
}

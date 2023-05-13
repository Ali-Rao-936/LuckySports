//
//  MatchDetailsViewController.swift
//  Lucky Sports
//
//  Created by Qoo on 09/05/2023.
//

import UIKit

class MatchDetailsViewController: UIViewController {

    @IBOutlet var lineupView: UIView!
    @IBOutlet var imgRight: UIImageView!
    @IBOutlet var imgLeft: UIImageView!
    @IBOutlet var teamName: UILabel!
    @IBOutlet var imgTeam: UIImageView!
    @IBOutlet var lineupTableView: UITableView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var lineupTitle: UILabel!
    @IBOutlet var scoreTitle: UILabel!
    @IBOutlet var scoreLable: UILabel!
    @IBOutlet var imgHome: UIImageView!
    @IBOutlet var awayName: UILabel!
    @IBOutlet var homeName: UILabel!
    @IBOutlet var imgAway: UIImageView!
    @IBOutlet var leagueLable: UILabel!
    @IBOutlet var imgLeague: UIImageView!
    
    
    var homeLineup:[ELineup]=[]
    var awayLineup:[ELineup]=[]
    
    var viewmodel=EsportsViewModel()
    var matchId:String?
    var homeTeamLogoString:String?
    var awayTeamLogoString:String?
    var leagueName:String?
    var leagueLogo:String?
    var isHomeLineup = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavBar(name: "Details".localized)
        setBackButton()
        tableView.registerCell(identifier: "MatchDetailsItemTableVC")
        tableView.registerCell(identifier: "LineupTableVC")
        
        viewmodel.delegate=self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewmodel.getEsportsMatchDetail(matchID: matchId ?? "0")
      //  viewmodel.getEsportsMatchDetail(matchID: "8587444")
        
        
        scoreTitle.setOnClickListener {
            self.lineupView.isHidden = true
            self.scoreTitle.textColor = .white
            self.scoreTitle.backgroundColor = Colors.primaryColor()
            self.lineupTitle.textColor = .black
            self.lineupTitle.backgroundColor = Colors.ThirdSubtitle()
        }
        
        lineupTitle.setOnClickListener {
            self.lineupView.isHidden = false
            self.scoreTitle.textColor = .black
            self.scoreTitle.backgroundColor = Colors.ThirdSubtitle()
            self.lineupTitle.textColor = .white
            self.lineupTitle.backgroundColor = Colors.primaryColor()
        }
        
        
        imgLeft.setOnClickListener {
            self.isHomeLineup = true
            self.teamName.text =  self.viewmodel.matchDetail?.homeTeamName
            self.imgTeam.setImage(with: self.homeTeamLogoString, placeholder: Utility.getPlaceHolder())
            self.lineupTableView.reloadData()
        }
        
        
        imgRight.setOnClickListener {
            self.isHomeLineup = false
            self.teamName.text =  self.viewmodel.matchDetail?.awayTeamName
            self.imgTeam.setImage(with: self.awayTeamLogoString, placeholder: Utility.getPlaceHolder())
            self.lineupTableView.reloadData()
        }
    }


}

extension MatchDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.lineupTableView {
            return homeLineup.count
        }else{
            return viewmodel.matchDetail?.scores?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.lineupTableView {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LineupTableVC", for: indexPath) as! LineupTableVC
        if isHomeLineup{
            cell.configureCell(data: homeLineup[indexPath.row])
        } else{
            cell.configureCell(data: awayLineup[indexPath.row])
        }
            
        return cell
            
            
    }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchDetailsItemTableVC") as! MatchDetailsItemTableVC
        cell.configureCell(data: viewmodel.matchDetail?.scores?[indexPath.row] ?? Scores("{}"), homeTeamName: viewmodel.matchDetail?.homeTeamName ?? "", awayTeamName: viewmodel.matchDetail?.awayTeamName ?? "", homeTeamLogo: homeTeamLogoString ?? "" , awayTeamLogo: awayTeamLogoString ?? "" )
        return cell
        
    }
        
    }
    
    
}

extension MatchDetailsViewController:EsportsViewModelDelegate{
    func didFinishEsportsListFetch() {
        
    }
    
    func didFinishEsportsLeaguesFetch() {
        
    }
    
    func didFinishFetchMatchDetail() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Utility.dateFormat.yyyyMMddHHmmss.rawValue
        
       // let tim = Utility.formatDate(date: dateFormatter.date(from: viewmodel.matchDetail?.matchTime ?? ""), with: .ddMMyyyyWithTimeZone)
       // timeLable.text = "Today, \(tim)"
        leagueLable.text = leagueName
        let url =  leagueLogo?.components(separatedBy: "_file")
        if (url?.count ?? 0) > 1  {
            self.imgLeague.setImage(with: BaseUrl.imgBaseURL + (url?[1] ?? "" ) , placeholder: Utility.getPlaceHolder())
        }
        homeName.text=viewmodel.matchDetail?.homeTeamName
        teamName.text=viewmodel.matchDetail?.homeTeamName
        awayName.text=viewmodel.matchDetail?.awayTeamName
        imgHome.setImage(with: homeTeamLogoString, placeholder: Utility.getPlaceHolder())
        imgTeam.setImage(with: homeTeamLogoString, placeholder: Utility.getPlaceHolder())
        imgAway.setImage(with: awayTeamLogoString, placeholder: Utility.getPlaceHolder())
        scoreLable.text=(viewmodel.matchDetail?.homeTeamScore ?? "0") + " : " + (viewmodel.matchDetail?.awayTeamScore ?? "0")
        self.tableView.reloadData()
        sortLineup()
    }
    func sortLineup(){
        let homeTeamId=viewmodel.matchDetail?.homeTeamId
        viewmodel.matchDetail?.lineup?.forEach({element in
            if homeTeamId == element.teamId{
                self.homeLineup.append(element)
            }else{
                self.awayLineup.append(element)
            }
        })
        lineupTableView.reloadData()
    }
}

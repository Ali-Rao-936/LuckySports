//
//  HomeViewController.swift
//  Lucky Sports
//
//  Created by Qoo on 08/05/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewmodel=EsportsViewModel()
    var gamesList:[GameTypeModel]?
    
    var  matchesList : [MatchCategory]? = []
    static var leagueList : [String] = []
    var liveList : [DataEsports] = []
    var upComingList : [DataEsports] = []
    var otherList : [DataEsports] = []
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    var isSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavBar(name: "Lucky Sports".localized)
        
        viewmodel.delegate=self
        searchBar.delegate = self
        viewmodel.getAllEsportsMatches(page: "1")
        populateGameTypes()
        
        collectionView.registerCell(identifier: "HomeTitleCollectionVC")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .right)
        
        tableView.registerCell(identifier: "HomeMatchesItemTableVC")
        tableView.registerCell(identifier: "NoMatchesTableVC")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func populateGameTypes(){
        gamesList=[]
        gamesList?.append(GameTypeModel(id: "0", name: "All Games".localized, image: "AllGamesIcon"))
        gamesList?.append(GameTypeModel(id: "101", name: "CS:GO".localized, image: "CsGoIcon"))
        gamesList?.append(GameTypeModel(id: "102", name: "LOL".localized, image: "LoLIcon"))
        gamesList?.append(GameTypeModel(id: "103", name: "Honor Of Kings".localized, image: "honorofKingIcon"))
        gamesList?.append(GameTypeModel(id: "104", name: "DOTA 2".localized, image: "Dota2Icon"))
        gamesList?.append(GameTypeModel(id: "105", name: "Heroes Of Warcraft".localized, image: "WarcraftIcon"))
        gamesList?.append(GameTypeModel(id: "106", name: "Hero Storm".localized, image: "HeroStormIcon"))
        gamesList?.append(GameTypeModel(id: "107", name: "Overwatch".localized, image: "OverwatchIcon"))
        gamesList?.append(GameTypeModel(id: "108", name: "Starcraft".localized, image: "StarcraftIcon"))
        gamesList?.append(GameTypeModel(id: "109", name: "Starcraft 2".localized, image: "Starcraft2Icon"))
        gamesList?.append(GameTypeModel(id: "110", name: "Rocket League".localized, image: "RocketLeagueIcon"))
        gamesList?.append(GameTypeModel(id: "111", name: "Warcraft 3".localized, image: "Warcraft3Icon"))
    }
    
    func after(_ string: String, date: Date = Date()) -> Bool {
        let locale = Locale(identifier: "en_US_POSIX")

        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
     //   dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let inDate = dateFormatter.date(from: string) else {
            return false
        }
        var calendar = Calendar.current
        calendar.locale = locale
        return inDate > calendar.startOfDay(for: date)
    }
    
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gamesList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeTitleCollectionVC", for: indexPath) as! HomeTitleCollectionVC
        cell.titleLable.text = gamesList![indexPath.row].name
        cell.imgCategory.image = UIImage(named: gamesList![indexPath.row].image)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 121)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        Utility.showProgress()
            if indexPath.row == 0{
               // isAllGames = true
                viewmodel.getAllEsportsMatches(page: "1")
            }else{
              //  isAllGames = false
                viewmodel.getEsportsMatchesFor(esportsType: gamesList![indexPath.row].id)
            }
    }
    
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearch {
            return 1
        }else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            return viewmodel.esportsSearchListing?.count ?? 0
        }else{
            if section == 0 {
                if liveList.count > 3 {
                    return 4
                }else if liveList.count == 0{
                    return 1
                }
                else{
                    return   liveList.count
                }
            } else if section == 1 {
                if upComingList.count > 3 {
                    return 4
                }else if upComingList.count == 0{
                    return 1
                }else {
                    return   upComingList.count
                }
            }
            else{
                if otherList.count == 0{
                    return 1
                }else {
                    return otherList.count
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSearch {
            if viewmodel.esportsSearchListing?.count ?? 0 == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "NoMatchesTableVC", for: indexPath) as! NoMatchesTableVC
                
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMatchesItemTableVC") as! HomeMatchesItemTableVC
                cell.bgView.backgroundColor =  Colors.PrimarySubtitle()
                if viewmodel.esportsSearchListing?.count ?? 0 > 0 {
                    cell.configureCell(data: (viewmodel.esportsSearchListing?[indexPath.row])!)
                }
                return cell
            }
            
        }else{
            if indexPath.section == 0 {
                if liveList.count == 0 {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NoMatchesTableVC", for: indexPath) as! NoMatchesTableVC
                    
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMatchesItemTableVC") as! HomeMatchesItemTableVC
                    cell.bgView.backgroundColor =  Colors.PrimarySubtitle()
                    if liveList.count > 0 {
                        cell.configureCell(data: liveList[indexPath.row])
                    }
                    return cell
                }
            }
            else if indexPath.section == 1 {
                
                if upComingList.count == 0 {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NoMatchesTableVC", for: indexPath) as! NoMatchesTableVC
                    
                    return cell
                }else{
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMatchesItemTableVC") as! HomeMatchesItemTableVC
                    cell.bgView.backgroundColor =  Colors.SecondarySubtitle()
                    cell.configureCell(data: upComingList[indexPath.row])
                    return cell
                }
            }
            else {
                
                if otherList.count == 0 {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NoMatchesTableVC", for: indexPath) as! NoMatchesTableVC
                    
                    return cell
                }else{
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMatchesItemTableVC") as! HomeMatchesItemTableVC
                    cell.bgView.backgroundColor =  Colors.ThirdSubtitle()
                    if otherList.count > 0 {
                        cell.configureCell(data: otherList[indexPath.row])
                    }
                    return cell
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Live Matches".localized
        }
        if section == 1 {
            return "Upcoming Matches".localized
        }
        else {
            return "Completed Matches".localized
        }
            
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
       if let headerView = view as? UITableViewHeaderFooterView {
           headerView.contentView.backgroundColor = .white
           headerView.backgroundView?.backgroundColor = .black
           headerView.textLabel?.textColor = Colors.primaryColor()
       }
   }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "MatchDetailsViewController") as! MatchDetailsViewController

            if indexPath.section == 0 {
                vc.homeTeamLogoString = (liveList[indexPath.row].homeTeamLogo ?? "")
                vc.awayTeamLogoString = (liveList[indexPath.row].awayTeamLogo ?? "")
                if Utility.getCurrentLang() == "cn"{
                    vc.leagueName = liveList[indexPath.row].league?.cnName
                }else{
                    vc.leagueName = liveList[indexPath.row].league?.enName
                }
                vc.matchId = liveList[indexPath.row].id
                vc.leagueLogo = liveList[indexPath.row].league?.logoUrl


            }else if indexPath.section == 1 {
                vc.homeTeamLogoString = (upComingList[indexPath.row].homeTeamLogo ?? "")
                vc.awayTeamLogoString = (upComingList[indexPath.row].awayTeamLogo ?? "")
                if Utility.getCurrentLang() == "cn"{
                    vc.leagueName = upComingList[indexPath.row].league?.cnName
                }else{
                    vc.leagueName = upComingList[indexPath.row].league?.enName
                }
                vc.matchId = upComingList[indexPath.row].id
                vc.leagueLogo = upComingList[indexPath.row].league?.logoUrl
            }else{
                vc.homeTeamLogoString = (otherList[indexPath.row].homeTeamLogo ?? "")
                vc.awayTeamLogoString = (otherList[indexPath.row].awayTeamLogo ?? "")
                if Utility.getCurrentLang() == "cn"{
                    vc.leagueName = otherList[indexPath.row].league?.cnName
                }else{
                    vc.leagueName = otherList[indexPath.row].league?.enName
                }
                vc.matchId = otherList[indexPath.row].id
                vc.leagueLogo = otherList[indexPath.row].league?.logoUrl
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
          //  self.openVC(storyBoard: "Main", identifier: "MatchDetailsViewController")
        }
        
       
    
    
}


extension HomeViewController:EsportsViewModelDelegate{
    func didFinishFetchMatchDetail() {
        
    }
    
    func didFinishEsportsLeaguesFetch() {
        //self.tableView.reloadData()
    }
    
    
    func didFinishEsportsListFetch() {
        
      //  let b : Double  = NSDate().timeIntervalSince1970
        
        if let matches = viewmodel.esportsListing {
            liveList.removeAll()
            upComingList.removeAll()
            otherList.removeAll()
            
            
            
            for data in matches{
                
                let dateArr = (data.matchTime ?? "").components(separatedBy: " ")
                
            //    let a : Double =  Double((data.updateTimestamp ?? "0")) ?? 0
                
                if after(dateArr[0]) {
                    upComingList.append(data)
                }
                
                else {  if (data.statusCode ?? "")  != "0"{
                    
                    if liveList.count == 4 {
                        otherList.append(data)
                    }else{
                        liveList.append(data)
                    }
                }else{
                    otherList.append(data)
                }
                }
            }
            self.tableView.reloadData()
       }
    }
}

extension HomeViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trim() != ""{
            doSearch(searchText: searchText)
        }else{
            isSearch = false
            tableView.reloadData()
        }
    }
    
    func doSearch(searchText:String){
        viewmodel.esportsSearchListing?.removeAll()
        self.viewmodel.esportsSearchListing = self.viewmodel.esportsListing?.filter{
            
            ($0.homeTeamName?.lowercased().contains(searchText.lowercased()) ?? false) || ($0.awayTeamName?.lowercased().contains(searchText.lowercased()) ?? false)
            || ($0.league?.enName?.lowercased().contains(searchText.lowercased()) ?? false)
        }
        isSearch = true
        tableView.reloadData()
        
    }
}

//
//  PrductListingViewController.swift
//  Lucky Sports
//
//  Created by Qoo on 10/05/2023.
//

import UIKit

class PrductListingViewController: UIViewController {
    
    
    
    @IBOutlet var listingCollectionView: UICollectionView!
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    var viewModel=SportsProductListingViewModel()
    var mappingArr: [Mapping]?
    var isSearch = false
    var data: [DataSportsListing]?
 //   var cell: VerticalCollectionTableViewCell?
    var enablePagination=false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.registerCell(identifier: "HomeTitleCollectionVC")
        listingCollectionView.registerCell(identifier: "ProductItemCollectionVC")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        listingCollectionView.delegate = self
        listingCollectionView.dataSource = self
        
        
        
        viewModel.delegate=self
        viewModel.getProducts(pageNumber: 1)
        viewModel.getProducts(random: true, count: 20)
        Utility.showProgress()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar(name: "Store".localized)
    }

}
extension PrductListingViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == listingCollectionView {
            return viewModel.randomProductList?.data?.count ?? 0
        }else{
            return viewModel.productsList?.data?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == listingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductItemCollectionVC", for: indexPath) as! ProductItemCollectionVC
            cell.configureCell(data: viewModel.randomProductList?.data?[indexPath.row])
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeTitleCollectionVC", for: indexPath) as! HomeTitleCollectionVC
            cell.configureCell(data: viewModel.productsList?.data?[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == listingCollectionView {
            let width = (UIScreen.main.bounds.size.width - 50) / 2
            return CGSize(width: width , height: 250)
        }else{
            return CGSize(width: 110, height: 121)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        if collectionView == listingCollectionView {
            vc.productID = viewModel.randomProductList?.data?[indexPath.row].id?.string ?? "0"
        }else{
            vc.productID = viewModel.productsList?.data?[indexPath.row].id?.string ?? "0"
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension PrductListingViewController:SportsProductListingViewModelDelegate{

    
    func didFinishGettingDetail() {
        
    }
    
    func didFinishFetchListing() {
        collectionView.reloadData()
     
     //   enablePagination=true
    }
    
    func didFinishFetchRandom() {
        listingCollectionView.reloadData()
    }
    
    
}

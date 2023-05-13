//
//  ProductDetailsViewController.swift
//  Lucky Sports
//
//  Created by Qoo on 10/05/2023. 
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet var titleLable: UILabel!
    @IBOutlet var collectionViewTags: UICollectionView!
    @IBOutlet var desCriptionLable: UILabel!
    @IBOutlet var imgUpDown: UIImageView!
    @IBOutlet var priceLable: UILabel!
    @IBOutlet var collectionViewListing: UICollectionView!
    @IBOutlet var imgMain: UIImageView!
    
    var selectedIndex=0
    var viewmodel=SportsProductListingViewModel()
    var specTableViewDefaultHeight:CGFloat = 0
    
    var productID:String?
    var currentIndex:Int=0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setBackButton()
       // setupNavBar(name: "Shop".localized)
        
       
        viewmodel.getProductDetail(id: productID!)
        viewmodel.delegate=self
        
        collectionViewListing.registerCell(identifier: "ItemsListCollectionVC")
        collectionViewListing.registerCell(identifier: "ProductTagsCollectionVC")
        
        collectionViewListing.delegate = self
        collectionViewListing.dataSource = self
        
        collectionViewTags.delegate = self
        collectionViewTags.dataSource = self

    }
    

}

extension ProductDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewListing {
            return self.viewmodel.productDetail?.data?.productPhoto?.count ?? 0
        }else{
            return self.viewmodel.productDetail?.data?.tag?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionViewListing {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsListCollectionVC", for: indexPath) as! ItemsListCollectionVC
            cell.imgProduct.setImage(with: BaseUrl.getBaseUrl(apiType: .APIPRODUCTS) + (viewmodel.productDetail?.data?.productPhoto?[indexPath.row].coverPath ?? ""), placeholder: Utility.getPlaceHolder())
        return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductTagsCollectionVC", for: indexPath) as! ProductTagsCollectionVC
            cell.titleLable.text =  self.viewmodel.productDetail?.data?.tag?[indexPath.row].title
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewListing {
            return CGSize(width: 70, height: 74)
        }else{
            return CGSize(width: 10, height: 25)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imgMain.setImage(with: BaseUrl.getBaseUrl(apiType: .APIPRODUCTS) + (viewmodel.productDetail?.data?.productPhoto?[indexPath.row].coverPath ?? ""), placeholder: Utility.getPlaceHolder())
    }
    
}


extension ProductDetailsViewController : SportsProductListingViewModelDelegate{
    func didFinishFetchListing() {
        
        
        
    }
    
    func didFinishFetchRandom() {
        
    }
    
    func didFinishGettingDetail() {
        
        
       // viewmodel.getProductsByTag(tagID: viewmodel.productDetail?.data?.tag?[self.selectedIndex].id?.string ?? "1")
        if viewmodel.productDetail?.data?.productPhoto?.count ?? 0 > 0 {
            collectionViewTags.reloadData()
            collectionViewListing.reloadData()
            collectionViewListing.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
            imgMain.setImage(with: BaseUrl.getBaseUrl(apiType: .APIPRODUCTS) + (viewmodel.productDetail?.data?.productPhoto?[0].coverPath ?? ""), placeholder: Utility.getPlaceHolder())
            titleLable.text = viewmodel.productDetail?.data?.title
            desCriptionLable.text = viewmodel.productDetail?.data?.description
            priceLable.text = (viewmodel.productDetail?.data?.price ?? "0") + "¥"
        }
    }
}

//
//  ProductItemCollectionVC.swift
//  Lucky Sports
//
//  Created by Qoo on 10/05/2023.
//

import UIKit

class ProductItemCollectionVC: UICollectionViewCell {
    
    @IBOutlet var priceIndicator: UILabel!
    @IBOutlet var myTags: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var productImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(data:DataSportsListing?){
        productImage.setImage(with: BaseUrl.getBaseUrl(apiType: .APIPRODUCTS) + (data?.coverPath ?? "0"), placeholder: Utility.getPlaceHolder())
        title.text=data?.title
        myTags.text=data?.keywords
        priceIndicator.text =  "Price: ".localized + (data?.price ?? "0") + "¥"

    }

}

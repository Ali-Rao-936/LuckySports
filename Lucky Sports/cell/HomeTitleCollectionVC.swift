//
//  HomeTitleCollectionVC.swift
//  Lucky Sports
//
//  Created by Qoo on 08/05/2023.
//

import UIKit

class HomeTitleCollectionVC: UICollectionViewCell {

    @IBOutlet var imgCategory: UIImageView!
    @IBOutlet var bgView: UIView!
    @IBOutlet var titleLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                titleLable.textColor = .white
                bgView.backgroundColor = Colors.primaryColor()
            }else{
                titleLable.textColor = .black
                bgView.backgroundColor = Colors.PrimarySubtitle()
            }
        }
    }

    
    func configureCell(data:DataSportsListing?){
        imgCategory.setImage(with: BaseUrl.getBaseUrl(apiType: .APIPRODUCTS) + (data?.coverPath ?? "0"), placeholder: Utility.getPlaceHolder())
        titleLable.text=data?.title
    }
}

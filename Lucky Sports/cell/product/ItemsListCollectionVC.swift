//
//  ItemsListCollectionVC.swift
//  Lucky Sports
//
//  Created by Qoo on 10/05/2023.
//

import UIKit

class ItemsListCollectionVC: UICollectionViewCell {

    @IBOutlet var bgView: UIView!
    @IBOutlet var imgProduct: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override var isSelected: Bool{
        didSet{
            if isSelected{
                bgView.borderColor = Colors.LineColor()
            }else{
                bgView.borderColor = .systemGray
            }
        }
    }
}

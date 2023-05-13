//
//  SportsProductListingViewModel.swift
//  Lucky Sports
//
//  Created by Qoo on 12/05/2023.
//

import Foundation

protocol SportsProductListingViewModelDelegate{
    func didFinishFetchListing()
    func didFinishFetchRandom()
    func didFinishGettingDetail()
}

class SportsProductListingViewModel{
    var delegate:SportsProductListingViewModelDelegate?
    var productsList:SportsListingBase?
    var randomProductList:SportsListingRandom?
    var productsPageNumber=0
    var productDetail:SportsProductDetail?
    
    func getProducts(pageNumber:Int){
        SportsProductAPI().getProducts(pageNumber: pageNumber, completion: {response in
            if self.productsList == nil{
                self.productsList=response
            }else{
                self.productsList?.data?.append(contentsOf: response.data ?? [])
            }
       
            self.delegate?.didFinishFetchListing()
        }, failed: {error in
            Utility.showErrorSnackView(message: error)
        })
    }
    
    func getProducts(random:Bool,count:Int){
        SportsProductAPI().getProductsRandom(limit:count, completion: {response in
            self.randomProductList=response
            self.delegate?.didFinishFetchRandom()
        }, failed: { error in
            Utility.showErrorSnackView(message: error)
            
        })
    }
    
    func getProductDetail(id:String){
        SportsProductAPI().getProductDetail(id: id,completion:{response in
            self.productDetail=response
            self.delegate?.didFinishGettingDetail()
        },failed: { error in
            Utility.showErrorSnackView(message: error)
        })
    }
    func getProductsByTag(tagID:String){
        SportsProductAPI().getProductsByTag(tagId: tagID, completion: {response in
            self.productsList=response
            self.delegate?.didFinishFetchListing()
        }, failed: {error in
            Utility.showErrorSnackView(message: error)
        })
    }
}

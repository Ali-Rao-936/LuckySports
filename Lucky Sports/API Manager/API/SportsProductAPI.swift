//
//  SportsProductAPI.swift
//  Lucky Sports
//
//  Created by Qoo on 12/05/2023.
//

import Foundation

class SportsProductAPI:WebService{

    func getProducts(pageNumber:Int,completion : @escaping(SportsListingBase) -> Void,failed:@escaping(String)->Void){
       //https://xn--8868-3m6f282x.com/api/v1
        ///product-list/:platform/:locale/:page
        var lang=Utility.getCurrentLang()
        if Utility.getCurrentLang() == "zh" {
            lang="cn"
        }else{
            lang="en"
        }
        let url = BaseUrl.getBaseUrl(apiType: .APIPRODUCTS) + EndPoints.allProducts.rawValue + "mobile/" + lang + "/" + pageNumber.string
        get(url: url, params: nil, completion: { result in
            let response=SportsListingBase(result!)
            completion(response)
        }, failed: failed)
    }
    
    func getProductsRandom(limit:Int,completion:@escaping(SportsListingRandom) -> Void, failed:@escaping(String) -> Void){
        var lang=Utility.getCurrentLang()
        if Utility.getCurrentLang() == "zh" {
            lang="cn"
        }else{
            lang="en"
        }
        let url = BaseUrl.getBaseUrl(apiType: .APIPRODUCTS) + EndPoints.randomProducts.rawValue + "mobile/" + lang + "/" + limit.string
        get(url: url, params: nil, completion: {result in
            let response=SportsListingRandom(result!)
            completion(response)
        }, failed: failed)
    }
    func getProductDetail(id:String,completion:@escaping(SportsProductDetail) -> Void, failed:@escaping(String) -> Void){
        var lang=Utility.getCurrentLang()
        if Utility.getCurrentLang() == "zh" {
            lang="cn"
        }else{
            lang="en"
        }
        let url = BaseUrl.getBaseUrl(apiType: .APIPRODUCTS) + EndPoints.detailProduct.rawValue + "mobile/" + lang + "/" + id
        get(url: url, params: nil, completion: {json in
            let response=SportsProductDetail(json!)
            completion(response)
        }, failed: failed)
    }
    func getProductsByTag(tagId:String,completion:@escaping(SportsListingBase) -> Void, failed:@escaping(String) -> Void){
        var lang=Utility.getCurrentLang()
        if Utility.getCurrentLang() == "zh" {
            lang="cn"
        }else{
            lang="en"
        }
        let url = BaseUrl.getBaseUrl(apiType: .APIPRODUCTS) + EndPoints.productsByTag.rawValue + "mobile/" + lang + "/" + tagId + "/1"
        get(url: url, params: nil, completion: { result in
            let response=SportsListingBase(result!)
            completion(response)
        }, failed: failed)
    }
    
}

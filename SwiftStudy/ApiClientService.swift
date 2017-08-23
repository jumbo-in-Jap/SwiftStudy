//
//  HttpService.swift
//  SwiftStudy
//
//  Created by 小原丈生 on 2017/08/22.
//  Copyright © 2017年 takeokunn. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

struct ApiClientService {
 
    func fetchQiitaItems(success: @escaping (_ data: [AnyObject])-> Void, fail: @escaping (_ error: Error?)-> Void) {
        let url: String = "https://qiita.com/api/v2/items/e49a673afd9a3ecb81a8/comments"
        Alamofire.request(url).responseJSON { response in
            if response.result.isSuccess {
                guard let value = response.result.value else {
                    return
                }
                let json = JSON(value)
                success([json as AnyObject])
            }else{
                fail(response.result.error)
            }
        }
    }
}

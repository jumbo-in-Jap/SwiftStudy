//
//  MainViewModel.swift
//  SwiftStudy
//
//  Created by 小原丈生 on 2017/08/22.
//  Copyright © 2017年 takeokunn. All rights reserved.
//

import Foundation
import RxSwift

class MainViewModel {

    var items = Variable<[AnyObject]>([])
    var isFetching = Variable<Bool>(false)

    private let disposeBag = DisposeBag()
    
    init() {
        
    }
}

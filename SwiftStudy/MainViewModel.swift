//
//  MainViewModel.swift
//  SwiftStudy
//
//  Created by 小原丈生 on 2017/08/22.
//  Copyright © 2017年 takeokunn. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

class MainViewModel {

    var items = Variable<[JSON]>([])
    var isFetching = Variable<Bool>(false)

    private let disposeBag = DisposeBag()

    init() {

    }
}

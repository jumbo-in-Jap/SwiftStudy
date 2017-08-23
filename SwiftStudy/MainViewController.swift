//
//  MainViewController.swift
//  SwiftStudy
//
//  Created by 小原丈生 on 2017/08/22.
//  Copyright © 2017年 takeokunn. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    var dataList = ["青山","阿部","加藤","川島","神田","佐藤","坂田","田中"]
    
    let viewModel = MainViewModel()
    let dispose = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!

    @IBAction func onClick() {
        self.viewModel.isFetching.value = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MainViewController {

    func bind() {
        self.viewModel
            .isFetching
            .asObservable()
            .subscribe(onNext: { (isFetching) in
                if isFetching {
                    let client = ApiClientService()
                    client.fetchQiitaItems(
                        success: { (data: [AnyObject]) in
                            self.viewModel.items.value = data
                            self.viewModel.isFetching.value = false
                        },
                        fail: { (error: Error?) in
                            self.viewModel.isFetching.value = false
                            print(error!)
                        }
                    )
                }
            })
            .addDisposableTo(dispose)

        self.viewModel
            .items
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "TestCell")) {
                (index, _, cell) in
                cell.textLabel?.text = "hoge"
            }
            .addDisposableTo(dispose)
    }
}

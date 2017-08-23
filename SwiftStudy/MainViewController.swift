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
    
     let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Repository>>()

    @IBAction func onClick() {
        self.viewModel.isFetching.value = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        
        dataSource.configureCell = { (_, tv, ip, viewModel: MainViewModel) in
            let cell = tv.dequeueReusableCell(withIdentifier: "TestCell")!
            cell.textLabel?.text = viewModel.items.value
            return cell
        }
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
            .drive(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(dispose)
    }
}

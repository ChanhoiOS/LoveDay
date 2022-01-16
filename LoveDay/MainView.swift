//
//  MainView.swift
//  LoveDay
//
//  Created by 이찬호 on 2022/01/08.
//

import UIKit
import Then
import RxSwift
import RxCocoa

class MainView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dataFetchBtn: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    private let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRx()

    }
    
    func configureRx() {
        self.viewModel.input.getDate.onNext(())
        
        self.viewModel.output.setDate
            .subscribe(onNext: { [weak self] dateCount in
                self?.countLabel.text = "\(dateCount)"
            }).disposed(by: disposeBag)
    }

    
    

}

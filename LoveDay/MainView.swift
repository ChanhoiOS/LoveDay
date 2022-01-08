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
    
    private let disposeBag = DisposeBag()
    private let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()

    }
    
    func configureUI() {
        self.configureButton()
    }
    
    func configureButton(){
        self.dataFetchBtn.rx.tap
            .bind(to: self.viewModel.input.fetchAction)
            .disposed(by: self.disposeBag)
    }

}

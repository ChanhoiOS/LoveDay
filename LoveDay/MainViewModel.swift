//
//  MainViewModel.swift
//  LoveDay
//
//  Created by 이찬호 on 2022/01/08.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire

protocol MainViewModelType {
    associatedtype Input
    associatedtype Output
}

class MainViewModel {
    
    var input: Input
    var output: Output
    let disposebag = DisposeBag()
    
    let calendar = Calendar.current
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    var daysCount:Int = 0

    struct Input {
        var getDate: PublishSubject<Void>
       
    }
    
    struct Output {
        var setDate: BehaviorSubject<Int>
    }
    
    init() {
        self.input = Input(getDate: PublishSubject<Void>())
        self.output = Output(setDate: BehaviorSubject<Int>(value: 0))
        
        self.input.getDate
            .bind(onNext: { [weak self] _ in
                self?.getDateInfo()
            }).disposed(by: disposebag)
        
     
    }
    
    func getDateInfo() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDate = dateFormatter.date(from: "2020-11-14")
        daysCount = days(from: startDate!)
        
        self.output.setDate.onNext(daysCount)
        
        //let hundred = calendar.date(byAdding: .day, value: 100, to: startDate!)
    }
    
    func days(from date: Date) -> Int {
        return calendar.dateComponents([.day], from: date, to: currentDate).day! + 1
    }
    
    
}

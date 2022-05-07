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

class MainViewModel: MainViewModelType {
    var input: Input
    var output: Output
    let disposebag = DisposeBag()
    
    let calendar = Calendar.current
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    var daysCount:Int = 0
    var specialCheck = [String]()

    struct Input {
        var getDate: PublishSubject<Void>
        var getSpecial: PublishSubject<Void>
    }
    
    struct Output {
        var setDate: BehaviorSubject<Int>
        var specialDay: BehaviorSubject<[String]>
    }
    
    init() {
        self.input = Input(getDate: PublishSubject<Void>(),getSpecial: PublishSubject<Void>())
        self.output = Output(setDate: BehaviorSubject<Int>(value: 0),specialDay: BehaviorSubject<[String]>(value: [""]))
        self.input.getDate
            .bind(onNext: { [weak self] _ in
                self?.getDateInfo()
            }).disposed(by: disposebag)
        self.input.getSpecial
            .bind(onNext: { [weak self] _ in
                self?.getSpecialInfo()
            }).disposed(by: disposebag)
    }
    
    func getDateInfo() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDate = dateFormatter.date(from: "2020-11-14")
        daysCount = days(from: startDate!)
        
        self.output.setDate.onNext(daysCount)
    }
    
    func getSpecialInfo() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDate = dateFormatter.date(from: "2020-11-14")
        
        for i in 0..<1001 {
            if i % 100 == 0 {
                let specialInt = calendar.date(byAdding: .day, value: i, to: startDate!)
                let specialStr = dateFormatter.string(from: specialInt!)
                specialCheck.append(specialStr)
            } else if i % 365 == 0 {
                let specialInt = calendar.date(byAdding: .day, value: i, to: startDate!)
                let specialStr = dateFormatter.string(from: specialInt!)
                specialCheck.append(specialStr)
            }
        }
        self.output.specialDay.onNext(specialCheck)
    }
    
    func days(from date: Date) -> Int {
        return calendar.dateComponents([.day], from: date, to: currentDate).day! + 1
    }
    
}

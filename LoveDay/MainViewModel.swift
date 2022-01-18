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
    var specialInt = [String]()

    struct Input {
        var getDate: PublishSubject<Void>
       
    }
    
    struct Output {
        var setDate: BehaviorSubject<Int>
        var specialDay: BehaviorSubject<[String]>
    }
    
    init() {
        self.input = Input(getDate: PublishSubject<Void>())
        self.output = Output(setDate: BehaviorSubject<Int>(value: 0),specialDay: BehaviorSubject<[String]>(value: ["100, 200"]))
        
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
        
        let hundred = calendar.date(byAdding: .day, value: 100, to: startDate!)
        let hundredTwo = calendar.date(byAdding: .day, value: 200, to: startDate!)
        let hundredThree = calendar.date(byAdding: .day, value: 300, to: startDate!)
        let oneYear = calendar.date(byAdding: .day, value: 365, to: startDate!)
        let hundredFour = calendar.date(byAdding: .day, value: 400, to: startDate!)
        let hundredFive = calendar.date(byAdding: .day, value: 500, to: startDate!)
        let hundredSix = calendar.date(byAdding: .day, value: 600, to: startDate!)
        let hundredSeven = calendar.date(byAdding: .day, value: 700, to: startDate!)
        let twoYear = calendar.date(byAdding: .day, value: 730, to: startDate!)
        let hundredEight = calendar.date(byAdding: .day, value: 800, to: startDate!)
        let hundredNine = calendar.date(byAdding: .day, value: 900, to: startDate!)
        let thousand = calendar.date(byAdding: .day, value: 1000, to: startDate!)
        
        let hunderedStr = dateFormatter.string(from: hundred!)
        let hunderedTwoStr = dateFormatter.string(from: hundredTwo!)
        let hunderedThreeStr = dateFormatter.string(from: hundredThree!)
        let hunderedOneYear = dateFormatter.string(from: oneYear!)
        let hunderedFourStr = dateFormatter.string(from: hundredFour!)
        let hunderedFiveStr = dateFormatter.string(from: hundredFive!)
        let hunderedSixStr = dateFormatter.string(from: hundredSix!)
        let hunderedSevenStr = dateFormatter.string(from: hundredSeven!)
        let twoYearStr = dateFormatter.string(from: twoYear!)
        let hundredEightStr = dateFormatter.string(from: hundredEight!)
        let hundredNineStr = dateFormatter.string(from: hundredNine!)
        let thousandStr = dateFormatter.string(from: thousand!)
        
        
        self.specialInt.append(hunderedStr)
        self.specialInt.append(hunderedTwoStr)
        self.specialInt.append(hunderedThreeStr)
        self.specialInt.append(hunderedOneYear)
        self.specialInt.append(hunderedFourStr)
        self.specialInt.append(hunderedFiveStr)
        self.specialInt.append(hunderedSixStr)
        self.specialInt.append(hunderedSevenStr)
        self.specialInt.append(twoYearStr)
        self.specialInt.append(hundredEightStr)
        self.specialInt.append(hundredNineStr)
        self.specialInt.append(thousandStr)
        
        self.output.specialDay.onNext(specialInt)
        
        
    }
    
    func days(from date: Date) -> Int {
        return calendar.dateComponents([.day], from: date, to: currentDate).day! + 1
    }
    
    
}

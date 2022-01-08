//
//  MainViewModel.swift
//  LoveDay
//
//  Created by 이찬호 on 2022/01/08.
//

import Foundation
import RxCocoa
import RxSwift

class MainViewModel {
    
    struct Input {
        var fetchAction: PublishRelay<Void>
    }
    
    let input: Input
    private let disposeBag = DisposeBag()
    
    init() {
        self.input = Input(fetchAction: PublishRelay<Void>())
        
        self.input.fetchAction
            .bind(
                onNext: { [weak self] in
                    print("여긴?")
                }
            )
            .disposed(by: self.disposeBag)
        
    }
    
}

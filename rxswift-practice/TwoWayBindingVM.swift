//
//  TwoWayBindingVM.swift
//  rxswift-practice
//
//  Created by 最上聖也 on 2017/07/13.
//  Copyright © 2017年 SeiyaMogami. All rights reserved.
//

import Foundation
import RxSwift

class TwoWayBindingVM {
    
    private let disposeBag = DisposeBag()
    
    // 成功する方のVM
    var sMessage: Variable<String>
    var isSuccessSaveButtonEnabled: Observable<Bool> {
        return sMessage.asObservable().map { $0.characters.count > 0 }
    }
    
    // 失敗する方のVM
    var fMessage: Variable<String>
    var isFailSaveButtonEnabled: Observable<Bool> {
        return fMessage.asObservable().map { $0.characters.count > 0 }
    }
    
    init() {
        sMessage = Variable("")
        
        fMessage = Variable("")
        
    }
}

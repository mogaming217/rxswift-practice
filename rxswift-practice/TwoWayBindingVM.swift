//
//  TwoWayBindingVM.swift
//  rxswift-practice
//
//  Created by 最上聖也 on 2017/07/13.
//  Copyright © 2017年 SeiyaMogami. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class TwoWayBindingVM {
    
    private let disposeBag = DisposeBag()
    
    // 成功する方のVM
    var sId: Variable<String>
    var sMessage: Variable<String>
    var isSuccessSaveButtonEnabled: Observable<Bool> {
        return Observable<Bool>.combineLatest(sId.asObservable(), sMessage.asObservable()) { id, message in
            guard id.characters.count > 0, message.characters.count > 0 else {
                return false
            }
            
            return true
        }
    }
    
    // 失敗する方のVM
    var fId: Variable<String>
    var fMessage: Variable<String>
    
    init() {
        sId = Variable("")
        sMessage = Variable("")
        
        fId = Variable("")
        fMessage = Variable("")
        
        sId.asObservable().debug()
            .subscribe(onNext: { [weak self] id in
                let realm = try! Realm()
                if let result = realm.object(ofType: MessageRealm.self, forPrimaryKey: id) {
                    print(result)
                    self?.sMessage.value = result.message
                }
                
            })
            .disposed(by: disposeBag)
        
    }
    
    func saveSuccessMessage() {
        let realm = try! Realm()
        let message = MessageRealm()
        message.id = sId.value
        message.message = sMessage.value
        
        try! realm.write {
            realm.add(message, update: true)
        }
    }
}

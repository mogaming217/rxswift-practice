//
//  TwoWayBindingVC.swift
//  rxswift-practice
//
//  Created by 最上聖也 on 2017/07/13.
//  Copyright © 2017年 SeiyaMogami. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TwoWayBindingVC: UIViewController {
    
    @IBOutlet weak var successIdField: UITextField!
    @IBOutlet weak var successStringField: UITextField!
    @IBOutlet weak var successSaveButton: UIButton!
    
    @IBOutlet weak var failIdField: UITextField!
    @IBOutlet weak var failStringField: UITextField!
    @IBOutlet weak var failSaveButton: UIButton!
    
    private let viewModel = TwoWayBindingVM()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindSuccess()
        // IDを決め打ちする
        successIdField.text = "123"
        successIdField.sendActions(for: .valueChanged)
    }
    
    private func bindSuccess() {
        successIdField.rx.text.orEmpty
            .bind(to: viewModel.sId)
            .disposed(by: disposeBag)
        
        successStringField.rx.text.orEmpty
            .bind(to: viewModel.sMessage)
            .disposed(by: disposeBag)
        
        viewModel.sMessage.asObservable()
            .bind(to: successStringField.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.isSuccessSaveButtonEnabled
            .bind(to: successSaveButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        successSaveButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.saveSuccessMessage()
            })
            .disposed(by: disposeBag)
    }
}

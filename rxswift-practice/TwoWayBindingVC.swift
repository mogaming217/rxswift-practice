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
    
    @IBOutlet weak var successMessageField: UITextField!
    @IBOutlet weak var successSaveButton: UIButton!
    @IBOutlet weak var successMessageLabel: UILabel!
    
    @IBOutlet weak var failMessageField: UITextField!
    @IBOutlet weak var failSaveButton: UIButton!
    @IBOutlet weak var failMessageLabel: UILabel!
    
    private let viewModel = TwoWayBindingVM()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindSuccess()
        bindFail()
        
        // メッセージをコードから代入する
        successMessageField.text = "こんにちは"
        successMessageField.sendActions(for: .valueChanged)
        
        failMessageField.text = "こんにちは"
    }
    
    private func bindSuccess() {
        successMessageField.rx.text.orEmpty
            .bind(to: viewModel.sMessage)
            .disposed(by: disposeBag)
        
        viewModel.sMessage.asObservable()
            .bind(to: successMessageField.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.isSuccessSaveButtonEnabled
            .bind(to: successSaveButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func bindFail() {
        failMessageField.rx.text.orEmpty
            .bind(to: viewModel.fMessage)
            .disposed(by: disposeBag)
        
        viewModel.fMessage.asObservable()
            .bind(to: failMessageField.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.isFailSaveButtonEnabled
            .bind(to: failSaveButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

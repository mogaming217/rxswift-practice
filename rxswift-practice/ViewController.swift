//
//  ViewController.swift
//  rxswift-practice
//
//  Created by 最上聖也 on 2017/06/04.
//  Copyright © 2017年 SeiyaMogami. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var secondField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // orEmptyで空文字やnilはObserve対象外
        let firstTextFieldObservable = firstTextField.rx.text.orEmpty.asObservable()
        
        firstTextFieldObservable
            // 指定した秒数以下のものはObserveしないらしい
            .throttle(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: { text in
                if text.characters.count >= 5 {
                    print(text)
                }
            })
            .addDisposableTo(disposeBag)
        
        let secondFieldObservable = secondField.rx.text.orEmpty.asObservable()
        secondFieldObservable
            .bindTo(secondLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        // 2つのテキストフィールドに何かしら入力されていたらボタン有効化
        Observable.combineLatest(firstTextFieldObservable, secondFieldObservable) { str1, str2 in
            return str1.characters.count > 0 && str2.characters.count > 0
        }.bindTo(button.rx.isEnabled)
        .addDisposableTo(disposeBag)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


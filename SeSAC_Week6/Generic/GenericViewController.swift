//
//  GenericViewController.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/08/24.
//

import UIKit
import SnapKit

class GenericViewController: UIViewController {

    
    let sampleLabel = UILabel()
    let sampleButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "은서"
        
        view.backgroundColor = .purple
        view.addSubview(sampleLabel)
        sampleLabel.backgroundColor = .yellow
        sampleLabel.text = "제네릭 테스트"
        configureBordere(view: sampleLabel)
        sampleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(100)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(50)
        }
        
        view.addSubview(sampleButton)
        sampleButton.backgroundColor = .orange
        configureBordere(view: sampleButton)
        sampleButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(100)
            make.top.equalTo(sampleLabel.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        
//        let generic1 = sum(a: 9.88, b: 123.6421)
//        let generic2 = sum(a: 88, b: 41)
        
        let intValue = sumInt(a: 371, b: 1923)
        print(intValue)
        
        let doubleValue = sumDouble(a: 2.132, b: 4.49)
        print(doubleValue)
        
    }
    
}

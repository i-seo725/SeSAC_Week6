//
//  BlackRadiusTextField.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/08/24.
//

import UIKit

class BlackRadiusTextField: UITextField {
    
    //인터페이스 빌더를 사용하지 않고, UIView를 상속 받은 Custom Class를 코드로 구성할 때 사용되는 초기화 구문
    //코드베이스
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //NSCdoing
    //XIB -> NIB 변환 과정에서 객체 생성 시 필요한 init 구문
    //인터페이스 빌더에서 생성된 뷰들이 초기화될 때 실행되는 구문
    //스토리보드
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        borderStyle = .none
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        textColor = .black
        textAlignment = .center
        font = .boldSystemFont(ofSize: 15)
    }
}


protocol ExampleProtocol {
    init(name: String)
}

class Mobile: ExampleProtocol {
    //required: 프로토콜에서 생성된 경우 사용하는 키워드 / override: 부모 클래스에서 상속 받은 경우 사용하는 키워드
    //둘 다 사용할 수도 있음, 슈퍼 클래스가 프로토콜을 채택해서 쓴 메서드를 자식이 쓸 때
    //Required Initializer
    
    required init(name: String) {
    }
    
    
}

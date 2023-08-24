//
//  JoinTextField.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/08/24.
//

import UIKit

class JoinTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextField() {
        backgroundColor = .systemBrown
        textColor = .white
        borderStyle = .none
        layer.cornerRadius = 8
        textAlignment = .center
        font = .systemFont(ofSize: 13)
    }
    
}

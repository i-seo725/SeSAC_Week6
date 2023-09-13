//
//  PosterImageView.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/08/25.
//

import UIKit

class PosterImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        print(frame.width, frame)
        backgroundColor = .yellow
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        clipsToBounds = true
    }
    
    //업데이트가 필요하다 판단되면 스스로 여러 번 호출
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
        print("동글동글", frame)
        
    }
    
    
}


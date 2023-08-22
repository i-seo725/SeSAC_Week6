//
//  FirstExampleViewController.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/08/22.
//

import UIKit
import SnapKit

class FirstExampleViewController: UIViewController {

    let emptyImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    lazy var titleTextField = designTextField("제목을 입력해주세요")
    lazy var dateTextField = designTextField("날짜를 입력해주세요")
    let emptyView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(emptyImageView)
        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.horizontalEdges.equalTo(view).inset(30)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.3)
        }
        
        view.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.topMargin.equalTo(emptyImageView.snp.bottom).offset(30)
            make.width.equalTo(emptyImageView.snp.width)
            make.leading.equalTo(emptyImageView.snp.leading)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.07)
        }
        
        view.addSubview(dateTextField)
        dateTextField.snp.makeConstraints { make in
            make.topMargin.equalTo(titleTextField.snp.bottom).offset(30)
            make.leading.equalTo(titleTextField.snp.leading)
            make.height.equalTo(titleTextField.snp.height)
            make.width.equalTo(titleTextField.snp.width)
        }
        
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.topMargin.equalTo(dateTextField.snp.bottom).offset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view).inset(30)
        }
        
        
    }
    
    func designTextField(_ placeholder: String) -> UITextField {
        let view = UITextField()
        view.borderStyle = .line
        view.placeholder = placeholder
        view.textAlignment = .center
        return view
    }
    
}

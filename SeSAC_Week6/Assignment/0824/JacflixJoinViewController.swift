//
//  JacflixJoinViewController.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/08/24.
//

import UIKit
import SnapKit

class JacflixJoinViewController: UIViewController {

    let titleLabel = {
        let view = UILabel()
        view.text = "JACKFLIX"
        view.textAlignment = .center
        view.textColor = .systemRed
        view.font = .boldSystemFont(ofSize: 23)
        return view
    }()
    let emailTextField = {
        let view = JoinTextField()
        view.placeholder = "이메일 주소 또는 전화번호"
        return view
    }()
    let passwordTextField = {
        let view = JoinTextField()
        view.placeholder = "비밀번호"
        view.isSecureTextEntry = true
        return view
    }()
    let nicknameTextField = {
        let view = JoinTextField()
        view.placeholder = "닉네임"
        return view
    }()
    let locationTextField = {
        let view = JoinTextField()
        view.placeholder = "위치"
        return view
    }()
    let codeTextField = {
        let view = JoinTextField()
        view.placeholder = "추천 코드 입력"
        return view
    }()
    let joinButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.setTitle("회원가입", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.titleLabel?.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    let addDetailButton = {
        let view = UIButton()
        view.setTitleColor(UIColor.white, for: .normal)
        view.setTitle("추가 정보 입력", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 13)
        return view
    }()
    let toggle = {
        let view = UISwitch()
        view.isOn = true
        view.onTintColor = .systemRed
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let views = [joinButton, addDetailButton, toggle, emailTextField, passwordTextField, nicknameTextField, locationTextField, codeTextField, titleLabel]
        for i in views {
            view.addSubview(i)
        }

        setConstraints()
    }

    func setConstraints() {
       
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(36)
            make.top.equalTo(titleLabel.snp.bottom).offset(110)
        }

        nicknameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(36)
            make.top.equalTo(emailTextField.snp.bottom).offset(12)
        }

        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(emailTextField.snp.height)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(12)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(emailTextField.snp.height)
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(emailTextField.snp.height)
            make.top.equalTo(locationTextField.snp.bottom).offset(12)
        }
        
        joinButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(50)
            make.top.equalTo(codeTextField.snp.bottom).offset(12)
        }
        
        addDetailButton.snp.makeConstraints { make in
            make.leading.equalTo(joinButton)
            make.top.equalTo(joinButton.snp.bottom).offset(18)
        }
        
        toggle.snp.makeConstraints { make in
            make.top.equalTo(addDetailButton)
            make.trailing.equalTo(joinButton.snp.trailing)
        }
        
        
        
    }

}

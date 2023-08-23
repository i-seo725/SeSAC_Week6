//
//  ViewController.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/08/21.
//

import UIKit

//객체 얹기, 레이아웃 잡기, 아웃렛 연결하기, 속성 조절하기 -> 프레임 기반 레이아웃
//AutoResizingMask, AutoLayout -> 스토리보드 대응
//둘이 같이 사용 불가, 오토레이아웃 잡으면 스토리보드에서 오토리사이징은 사라짐
//NSLayoutConstraints : 코드로 오토레이아웃 설정, 코드베이스 대응
    //1) isActive 프로퍼티를 통해 활성화
    //2) addConstraints
//NSLayoutAnchor

class ViewController: UIViewController {

    //1. 뷰 객체 프로퍼티 선언(클래스 인스턴스 생성)
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2. 명시적으로 루트뷰에 추가
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        
        //AutoResizingMask 끄기
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        //3. 크기와 위치 정의 (레이아웃 잡기), 프레임 기반 레이아웃
        //x축 y축에서 각각 50, 80만큼 띄우고 넓이 높이 잡기
        emailTextField.frame = CGRect(x: 50, y: 80, width: UIScreen.main.bounds.width - 100, height: 50)
        
        //4. 속성 조절
        emailTextField.backgroundColor = .cyan
        emailTextField.keyboardType = .numberPad
        emailTextField.isSecureTextEntry = true
        emailTextField.placeholder = "닉네임을 입력하세요"
        
        //3. 크기, 위치 조절 - isActive 방식
//        NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50).isActive = true //레이아웃 활성화
//        NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -50).isActive = true
//        NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60).isActive = true
//        NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1, constant: 50).isActive = true
        
        //addConstraints 방식, 한번에 제약조건 추가
        let leading = NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50)
        let trailing = NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -50)
        let height = NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
        let top = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1, constant: 50)
        
        view.addConstraints([leading, trailing, height, top])
        
        passwordTextField.backgroundColor = .green
        setLayoutAnchor()
        
    }


    @objc func signButtonClicked() {
//        let vc = SecondExampleViewController()   // 스토리보드가 없어서 뷰컨트롤러 인스턴스 만들어서 present하면 됨
//        vc.modalPresentationStyle = .fullScreen
        let vc = LocationViewController()
        let nav = UINavigationController(rootViewController: vc)
        //제목 바 달고 프리젠트 가능
        present(nav, animated: true)
    }
    
    func setLayoutAnchor() {
        view.addSubview(signButton)
        signButton.translatesAutoresizingMaskIntoConstraints = false
        
        signButton.backgroundColor = .magenta
        signButton.addTarget(self, action: #selector(signButtonClicked), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            signButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signButton.widthAnchor.constraint(equalToConstant: 300),
            signButton.heightAnchor.constraint(equalToConstant: 50),
            signButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor) //view.bottomAnchor) -> 맨 밑에 붙어버림
        ])
    }
    
    
}


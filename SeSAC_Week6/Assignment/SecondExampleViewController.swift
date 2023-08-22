//
//  SecondExampleViewController.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/08/22.
//

import UIKit
import SnapKit

class SecondExampleViewController: UIViewController {
    
    let backgroundImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemIndigo
        return view
    }()
    let xButton = designButton(systemName: "xmark", border: false)
    let iconView = UIView()
    let firstIconButton = designButton(systemName: "gift", border: true)
    let secondIconButton = designButton(systemName: "arrow.up.left.and.arrow.down.right", border: true)
    let thirdIconButton = designButton(systemName: "gearshape", border: true)
    
    let profileView = UIView()
    let profileImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .systemPink
        return view
    }()
    let nameLabel = {
        let view = UILabel()
        view.text = "은서"
        view.textColor = .white
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 16)
        return view
    }()
    let statusMessageLabel = designLabel("상태메시지입니다")
    
    let bottomView = UIView()
    let chatMyselfView = UIView()
    let chatButton = designButton(systemName: "message.fill", border: false)
    let chatLabel = designLabel("나와의 채팅")
    
    let editProfileView = UIView()
    let editProfileIconButton = designButton(systemName: "pencil", border: false)
    let editProfileLabel = designLabel("프로필 편집")
    
    let kakaoStoryView = UIView()
    let kakaoStoryIconButton = designButton(systemName: "quote.closing", border: false)
    let kakaoStoryLabel = designLabel("카카오스토리")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        
        for item in [iconView, profileView, bottomView] {
            item.backgroundColor = .systemYellow
            item.layer.borderColor = UIColor.systemMint.cgColor
            item.layer.borderWidth = 1
        }
        
        for item in [chatMyselfView, editProfileView, kakaoStoryView] {
            item.backgroundColor = .systemOrange
        }
        
        setBackgroundConstraints()
        setProfileConstraints()
        setBottomViewConstraints()
        setIconConstraints()
    }
    
    static func designButton(systemName: String, border: Bool) -> UIButton {
        let view = UIButton()
        view.tintColor = .white
        view.setTitle("", for: .normal)
        view.setImage(UIImage(systemName: systemName), for: .normal)
        
        if border {
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 1
            view.layer.cornerRadius = 20
        }
        
        return view
    }
    static func designLabel(_ text: String) -> UILabel {
        let view = UILabel()
        view.text = text
        view.textColor = .white
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 15)
        return view
    }
    
    func addView() {
        view.addSubview(backgroundImageView)
        view.addSubview(xButton)
        view.addSubview(iconView)
        iconView.addSubview(firstIconButton)
        iconView.addSubview(secondIconButton)
        iconView.addSubview(thirdIconButton)
        
        bottomView.addSubview(editProfileView)
        editProfileView.addSubview(editProfileLabel)
        editProfileView.addSubview(editProfileIconButton)
        
        view.addSubview(bottomView)
        bottomView.addSubview(chatMyselfView)
        chatMyselfView.addSubview(chatButton)
        chatMyselfView.addSubview(chatLabel)
        
        bottomView.addSubview(kakaoStoryView)
        kakaoStoryView.addSubview(kakaoStoryLabel)
        kakaoStoryView.addSubview(kakaoStoryIconButton)
        
        view.addSubview(profileView)
        profileView.addSubview(profileImageView)
        profileView.addSubview(nameLabel)
        profileView.addSubview(statusMessageLabel)
    }
    func setBackgroundConstraints() {
        //배경이랑 뷰 제약조건 잡기
        backgroundImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view)
            make.verticalEdges.equalTo(view)
        }
        
        xButton.snp.makeConstraints { make in
            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leadingMargin.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.size.equalTo(50)
        }
        
        iconView.snp.makeConstraints { make in
            make.top.equalTo(xButton.snp.top)
            make.trailingMargin.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(50)
            make.leading.equalTo(xButton.snp.trailing)
        }
        
        bottomView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.2)
        }
        
        profileView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(0)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.23)
            make.bottomMargin.equalTo(bottomView.snp.top)
        }
        
        editProfileView.snp.makeConstraints { make in
            make.center.equalTo(bottomView)
            make.size.equalTo(80)
        }
        
        chatMyselfView.snp.makeConstraints { make in
            make.trailing.equalTo(editProfileView).inset(90)
            make.centerY.equalTo(bottomView)
            make.size.equalTo(80)
        }
        
        kakaoStoryView.snp.makeConstraints { make in
            make.leading.equalTo(editProfileView).inset(90)
            make.centerY.equalTo(bottomView)
            make.size.equalTo(80)
        }
    }
    func setProfileConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(profileView)
            make.height.equalTo(profileView).multipliedBy(0.55)
            make.width.equalTo(profileImageView.snp.height)
            make.centerY.equalTo(profileView).multipliedBy(0.7)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(profileView)
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
        }
        
        statusMessageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(profileView)
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
        }
    }
    func setBottomViewConstraints() {
        //나와의 채팅
        chatButton.snp.makeConstraints { make in
            make.centerY.equalTo(chatMyselfView).multipliedBy(0.8)
            make.centerX.equalTo(chatMyselfView)
//            make.height.equalTo(chatMyselfView).multipliedBy(0.9)
//            make.width.equalTo(chatButton.snp.height)
        }
        
        chatLabel.snp.makeConstraints { make in
            make.centerX.equalTo(chatMyselfView)
            make.top.equalTo(chatButton.snp.bottom).offset(4)
        }
        
        //프로필 편집
        editProfileIconButton.snp.makeConstraints { make in
            make.centerY.equalTo(editProfileView).multipliedBy(0.8)
            make.centerX.equalTo(editProfileView)
        }
        
        editProfileLabel.snp.makeConstraints { make in
            make.centerX.equalTo(editProfileView)
            make.top.equalTo(editProfileIconButton.snp.bottom).offset(4)
        }
        
        
        //카카오스토리
        kakaoStoryIconButton.snp.makeConstraints { make in
            make.centerY.equalTo(kakaoStoryView).multipliedBy(0.8)
            make.centerX.equalTo(kakaoStoryView)
        }
        
        kakaoStoryLabel.snp.makeConstraints { make in
            make.centerX.equalTo(kakaoStoryView)
            make.top.equalTo(kakaoStoryIconButton.snp.bottom).offset(4)
        }
    }
    func setIconConstraints() {
        thirdIconButton.snp.makeConstraints { make in
            make.centerY.equalTo(iconView)
            make.height.equalTo(iconView).multipliedBy(0.7)
            make.width.equalTo(thirdIconButton.snp.height)
            make.trailing.equalTo(iconView).inset(14)
        }
        
        secondIconButton.snp.makeConstraints { make in
            make.centerY.equalTo(iconView)
            make.height.equalTo(iconView).multipliedBy(0.7)
            make.width.equalTo(secondIconButton.snp.height)
            make.trailing.equalTo(thirdIconButton).inset(50)
        }
        
        firstIconButton.snp.makeConstraints { make in
            make.centerY.equalTo(iconView)
            make.height.equalTo(iconView).multipliedBy(0.7)
            make.width.equalTo(firstIconButton.snp.height)
            make.trailing.equalTo(secondIconButton).inset(50)
        }
    }
    
}


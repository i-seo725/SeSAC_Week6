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
    
    let editProfileIconButton = designButton(systemName: "pencil", border: false)
    let editProfileLabel = designLabel("프로필 편집")
    
    let kakaoStoryIconButton = designButton(systemName: "quote.closing", border: false)
    let kakaoStoryLabel = designLabel("카카오스토리")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
    
    
    
    
}

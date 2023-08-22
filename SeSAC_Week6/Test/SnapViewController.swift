//
//  SnapViewController.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/08/22.
//

import UIKit
import SnapKit

//RTL : Right to Left, Leading/Trailing : 아랍어의 경우 오왼이 바뀌어서 대응을 위해 right/left 대신 leading/trailing 사용

class SnapViewController: UIViewController {

    let yellowView = UIView()
    let whiteView = UIView()
    let purpleView = UIView()
    let mintView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        view.addSubview(yellowView)
        yellowView.backgroundColor = .systemYellow
        yellowView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(150)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(whiteView)
        whiteView.backgroundColor = .white
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            
//            make.leading.equalTo(view.safeAreaLayoutGuide)
//            make.trailing.equalTo(view.safeAreaLayoutGuide)
            
//            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)  //leading & trailing 동시에 주기
            
            make.height.equalTo(200)
        }
        
        view.addSubview(purpleView)
        purpleView.backgroundColor = .systemPurple
        purpleView.snp.makeConstraints { make in
//            make.centerX.centerY.equalTo(view)  //똑같으면 한 번에 쓸 수 있음
            make.center.equalTo(view)   //centerX & centerY 합쳐서 center 사용 가능
//            make.width.height.equalTo(200)
            make.size.equalTo(200)  //위 코드랑 똑같음(width&height 똑같으면 size 사용 가능)
        }
        
//        view.addSubview(mintView)   //추가하는 순서에 따라 가려질 수 있음
        purpleView.addSubview(mintView)
        mintView.backgroundColor = .systemMint
        mintView.snp.makeConstraints { make in
//            make.size.equalTo(150)
//            make.leading.top.equalToSuperview() //superview : 속한 뷰, yellowView에 들어가면 superview = yellowView
            
//            make.leading.top.trailing.bottom.equalToSuperview()
//            make.edges.equalToSuperview()   //위랑 같은 코드
//            make.edges.equalTo(purpleView).inset(50)    //안쪽으로 50씩 들어가게 하기
            make.edges.equalToSuperview().offset(50) //50씩 더 가기
        }
        
    }

}

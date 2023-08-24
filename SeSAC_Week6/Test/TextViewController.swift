//
//  TextViewController.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/08/22.
//

import UIKit
import SnapKit

class TextViewController: UIViewController {

    //클로저를 통해 객체 만들면서 디자인까지 하기
    let photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .orange
        view.contentMode = .scaleAspectFill
        return view
    }()
    let titleTextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.placeholder = "제목을 입력해주세요"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    //1. imagePicker 등록하기
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        view.addSubview(photoImageView)
//        view.addSubview(titleTextField)
        
        //뷰 객체를 하나씩 추가하지 않고 반복문으로 추가하기
//        for item in [photoImageView, titleTextField] {
//            view.addSubview(item)
//        }
        
        //forEach문, 매개변수명 안 쓸 수 있음
        [photoImageView, titleTextField].forEach {
            view.addSubview($0)
        }
        
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        //2. 사용 가능한지 확인(Available)
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("갤러리 사용 불가, 사용자에게 토스트/얼럿")
            return
        }

        //어떤 스타일의 뷰를 띄워줄 건지 결정, 사용이 아닌 읽기만 할 때는 권한 요청 필요 없음
        picker.delegate = self
        picker.sourceType = .camera
        //사진 찍고 크롭, 확대 등 수정
        picker.allowsEditing = true
        
//        let picker = UIColorPickerViewController()//UIFontPickerViewController()
        
        present(picker, animated: true)
    }
    
    
    
    
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
//            make.horizontalEdges.top.equalToSuperview()
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view).multipliedBy(0.3)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)  //offset : 떨어져라 / 이미지뷰 기준으로 레이아웃을 잡기 때문에 이미지뷰 레이아웃 코드 뒤에 이 코드가 있어야함
            make.leadingMargin.equalTo(20)  //make.leading.equalTo(view).inset(20)이랑 똑같음
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
    
}

extension TextViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
        print(#function)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //originalImage로 하면 편집 전 원본 사진이 들어감, 90도 회전해서 들어가는 게 디폴트
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.photoImageView.image = image
            dismiss(animated: true)
        }
    }
}

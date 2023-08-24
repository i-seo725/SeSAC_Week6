//
//  Extension+UIViewController.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/08/24.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present //네비게이션 없이 present
        case presentNavigation //네비게이션 임베드 된 present
        case presentFullNavigation //네비게이션 임베드 된 fullscreen present
        case push
    }
    
    /*
     "은서" >  String 타입
     String > String.type 타입 / String.self : 매개변수로 넣거나 사용하거나 표현할 때
     */
    
    //T.Type 말고 T만 쓰면 인스턴스가 들어옴 ()
    func transition<T: UIViewController>(viewController: T.Type, storyboard: String, style: TransitionStyle) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: String(describing: viewController)) as? T else { return }
        
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    //Type Parameter의 T : 타입의 종류는 알려주지 않지만, 같은 타입이 들어갈 것 암시, 플레이스 홀더와 같은 역할
    //UpperCased의 U도 사용
    //Type Constraints : 타입의 제약 조건, Class 제약/Protocol 제약
    func configureBordere<T: UIView>(view: T) {
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }
    
    
    
    //덧셈이 가능한 프로토콜(AdditiveArithmetic)을 채택한 요소만 매개변수로 받을 수 있도록 제약조건 설정
    //Generic: 타입에 유연하게 대응하기 위한 요소
    //코드 중복과 재사용에 대응하기 좋아 추상적인 표현 가능
    func sum<T: AdditiveArithmetic>(a: T, b: T) -> T {
        return a + b
    }
    
    
    func sumInt(a: Int, b: Int) -> Int {
        return a + b
    }
    
    func sumDouble(a: Double, b: Double) -> Double {
        return a + b
    }
    
    func sumFloat(a: Float, b: Float) -> Float {
        return a + b
    }
    
}

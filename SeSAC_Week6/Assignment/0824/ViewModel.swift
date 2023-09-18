//
//  ViewModel.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/09/13.
//

import Foundation

class jackflixViewModel {
    
    var email: Observable<String?> = Observable("")
    var nickname: Observable<String?> = Observable("")
    var pw: Observable<String?> = Observable("")
    var location: Observable<String?> = Observable("")
    var code: Observable<String?> = Observable("")
    var result: Observable<String?> = Observable("")
    var check = Observable([false, false, false, false, false])
    
    func checking() -> Bool {
        let value = check.value.filter {
            $0 == true
        }
      
        if value.count == 5 {
            return true
        } else {
            return false
        }
    }

    
    func validEmail(text: String? = nil) -> Bool {
        guard let text else { return false }
        if text.contains("@") && text.contains(".") {
            result.value = ""
            check.value[0] = true
            return true
        } else {
            result.value = "이메일 형식에 맞춰 입력해주세요"
            check.value[0] = false
            return false
        }
    }
    
    func validNickname(text: String? = nil) -> Bool {
        guard let text else { return false }
        if text.contains("@") || text.contains("#") || text.contains("*") || text.contains(".") {
            result.value = "닉네임에 특수문자('@','#','*','.')는 들어갈 수 없습니다"
            check.value[1] = false
            return false
        } else {
            result.value = ""
            check.value[1] = true
            return true
        }
    }
    
    func validPw(text: String? = nil) -> Bool {
        guard let text else { return false }
        if text.count >= 6 && text.count <= 10 {
            result.value = ""
            check.value[2] = true
            return true
        } else {
            result.value = "비밀번호는 6~10자리로 설정해주세요"
            check.value[2] = false
            return false
        }
    }
    
    func validLocation(text: String? = nil) -> Bool {
        guard let text else { return false }
        if text.isEmpty {
            result.value = "위치를 입력해주세요"
            check.value[3] = false
            return false
        } else {
            result.value = ""
            check.value[3] = true
            return true
        }
    }
    
    func validCode(text: String? = nil) -> Bool {
        guard let text else { return false }
        guard text.count == 6 else {
            result.value = "추천코드는 6자리입니다"
            check.value[4] = false
            return false
        }
        guard let codeNum = Int(text) else {
            result.value = "추천코드는 숫자만 입력할 수 있습니다"
            check.value[4] = false
            return false
        }
        result.value = ""
        check.value[4] = true
        return true
    }
    
}

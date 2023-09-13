//
//  ViewModel.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/09/13.
//

import Foundation

class jackflixViewModel {
    
    var email = Observable("")
    var nickname = Observable("")
    var pw = Observable("")

    var validationEmail = Observable(true)
    var validationNickname = Observable(true)
    var validationPw = Observable(true)
    
    func validEmail() {
        validationEmail.value = email.value.isEmpty
    }
    
    func validNickname() {
        validationNickname.value = nickname.value.isEmpty
    }
    
    func validPw() {
        validationPw.value = pw.value.isEmpty
    }
}

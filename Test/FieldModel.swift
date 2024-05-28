//
//  FieldModel.swift
//  Test
//
//  Created by Igor Manakov on 26.05.2024.
//

import SwiftUI

protocol FieldValidatorProtocol {
    func validate(_ value: String, with value2: String?) -> String?
}

enum FieldType: FieldValidatorProtocol {
    case nickname
    case email
    case password
    case passwordAgain
    
    func validate(_ value: String, with value2: String? = nil) -> String? {
        switch self {
        case .nickname:
            nicknameValidate(value: value)
        case .email:
            emailValidate(value: value)
        case .password:
            passwordValidate(value: value)
        case .passwordAgain:
            passwordAgainValidate(value, with: value2 ?? "")
        }
    }
    
    private func nicknameValidate(value: String) -> String? {
        guard !value.isEmpty else {
            return "Пожалуйста, введите имя пользователя"
        }
        
        let nicknameRegEx = "^[a-zA-Z]\\w*$"
        let nicknamePred = NSPredicate(format: "SELF MATCHES %@", nicknameRegEx)
        return nicknamePred.evaluate(with: value) ? nil : "Имя пользователя должно начинаться с латинской буквы"
    }
    
    private func emailValidate(value: String) -> String? {
        guard !value.isEmpty else {
            return "Пожалуйста, введите почтовый адрес"
        }
        
        let emailRegEx = "^[A-Z0-9a-z._%+_]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}$"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: value) ? nil : "Пожалуйста, введите корректный почтовый адрес"
    }
    
    private func passwordValidate(value: String) -> String? {
        guard !value.isEmpty else {
            return "Пожалуйста, введите пароль"
        }
        
//        let passwordRegEx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^*-]).{8,}$"
//        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
//        return passwordPred.evaluate(with: value) ? nil : "Пароль должен содержать: минимум 8 символов, 1 заглавную латинскую букву, 1 строчную латинскую букву, 1 цифру и 1 спецсимвол"
        return nil
    }
    
    private func passwordAgainValidate(_ value: String, with value2: String) -> String? {
        guard !value.isEmpty else {
            return "Пожалуйста, введите пароль"
        }
        
        return value == value2 ? nil : "Повторный пароль должен совпадать с предыдущим"
    }
}

struct FieldModel {
    var label: String
    var placeholder: String
    var value: String
    var error: String?
    var fieldType: FieldType
    
    init(label: String, 
         placeholder: String = "",
         value: String = "", 
         error: String? = nil,
         fieldType: FieldType) {
        self.label = label
        self.placeholder = placeholder
        self.value = value
        self.error = error
        self.fieldType = fieldType
    }
    
    var isValid: Bool {
        !value.isEmpty && error == nil
    }
    
    mutating func onSubmitError(_ value2: String? = nil) {
        error = fieldType.validate(value, with: value2)
    }
}

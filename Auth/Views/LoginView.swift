//
//  ContentView.swift
//  Test
//
//  Created by Igor Manakov on 26.05.2024.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @Binding var isButtonEnabled: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                CommonTextField(fieldModel: $viewModel.nicknameField)
                    .onChange(of: viewModel.nicknameField.value) { oldValue, newValue in
                        print(oldValue, newValue)
                        viewModel.nicknameField.onSubmitError()
                        isButtonEnabled = viewModel.isAllValid
                    }
                CommonTextField(fieldModel: $viewModel.passwordField)
                    .onChange(of: viewModel.passwordField.value) {
                        viewModel.passwordField.onSubmitError()
                        isButtonEnabled = viewModel.isAllValid
                    }
            }
            .padding()
        }
        .scrollBounceBehavior(.basedOnSize)
        .scrollDismissesKeyboard(.interactively)
    }
}

class LoginViewModel: ObservableObject {
    @Published var nicknameField: FieldModel = .init(label: "Имя пользователя", placeholder: "Введите имя", fieldType: .nickname)
    @Published var passwordField: FieldModel = .init(label: "Пароль", placeholder: "Введите пароль", fieldType: .password)
    var isAllValid: Bool {
        nicknameField.isValid && passwordField.isValid
    }
}

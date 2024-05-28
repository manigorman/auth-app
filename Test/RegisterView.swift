//
//  RegisterView.swift
//  Test
//
//  Created by Igor Manakov on 26.05.2024.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: RegisterViewModel
    @Binding var isButtonEnabled: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                CommonTextField(fieldModel: $viewModel.nicknameField)
                    .onChange(of: viewModel.nicknameField.value) {
                        viewModel.nicknameField.onSubmitError()
                        isButtonEnabled = viewModel.isAllValid
                    }
                CommonTextField(fieldModel: $viewModel.emailField)
                    .onChange(of: viewModel.emailField.value) {
                        viewModel.emailField.onSubmitError()
                        isButtonEnabled = viewModel.isAllValid
                    }
                CommonTextField(fieldModel: $viewModel.passwordField)
                    .onChange(of: viewModel.passwordField.value) {
                        viewModel.passwordField.onSubmitError()
                        isButtonEnabled = viewModel.isAllValid
                    }
                CommonTextField(fieldModel: $viewModel.passwordAgainField)
                    .onChange(of: viewModel.passwordAgainField.value) {
                        viewModel.passwordAgainField.onSubmitError(viewModel.passwordField.value)
                        isButtonEnabled = viewModel.isAllValid
                    }
            }
            .padding()
        }
        .scrollBounceBehavior(.basedOnSize)
        .scrollDismissesKeyboard(.interactively)
    }
}

class RegisterViewModel: ObservableObject {
    @Published var nicknameField: FieldModel = .init(label: "Имя пользователя", placeholder: "Введите имя", fieldType: .nickname)
    @Published var emailField: FieldModel = .init(label: "Адрес эл. почты", placeholder: "Введите адрес", fieldType: .email)
    @Published var passwordField: FieldModel = .init(label: "Пароль", placeholder: "Введите пароль", fieldType: .password)
    @Published var passwordAgainField: FieldModel = .init(label: "Подтверждение пароля", placeholder: "Повторите пароль", fieldType: .passwordAgain)
    var isAllValid: Bool {
        nicknameField.isValid
        && emailField.isValid
        && passwordField.isValid
        && passwordAgainField.isValid
    }
}

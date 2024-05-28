//
//  CommonTextField.swift
//  Test
//
//  Created by Igor Manakov on 26.05.2024.
//

import SwiftUI

struct CommonTextField: View {
    var fieldModel: Binding<FieldModel>
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(fieldModel.label.wrappedValue)
                .font(.system(size: 13))
                .multilineTextAlignment(.leading)
                .padding([.horizontal], 0)
            
            if fieldModel.fieldType.wrappedValue == .password || fieldModel.fieldType.wrappedValue == .passwordAgain {
                SecureField(fieldModel.placeholder.wrappedValue, text: fieldModel.value)
                    .padding(8)
                    .background(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(fieldModel.wrappedValue.error == nil ? Color.secondary : Color.red, lineWidth: 0.5)
                    )
            } else {
                TextField(fieldModel.placeholder.wrappedValue, text: fieldModel.value)
                    .padding(8)
                    .background(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(fieldModel.wrappedValue.error == nil ? Color.secondary : Color.red, lineWidth: 0.5)
                    )
            }
            
            if let error = fieldModel.error.wrappedValue {
                Text(error)
                    .foregroundColor(.red)
                    .font(.system(size: 13))
                    .multilineTextAlignment(.leading)
                    .padding([.horizontal], 0)
            }
        }
    }
}

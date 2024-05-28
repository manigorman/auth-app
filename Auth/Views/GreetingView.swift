//
//  GreetingView.swift
//  Test
//
//  Created by Igor Manakov on 27.05.2024.
//

import SwiftUI

struct GreetingView: View {
    var body: some View {
        ZStack {
            Image("welcome")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Добро пожаловать!")
                    .font(.system(size: 32, weight: .bold))
                    .multilineTextAlignment(.leading)
                
                Text("Авторизация прошла успешно. Теперь ты можешь делать что угодно")
                    .font(.system(size: 17, weight: .regular))
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding(20)
        }
    }
}

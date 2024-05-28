//
//  MainView.swift
//  Test
//
//  Created by Igor Manakov on 26.05.2024.
//

import SwiftUI

struct MainView: View {
    @State private var screen = 0
    @State var isButtonEnabled = false
    @State var isLoading = false
    @ObservedObject var loginViewModel: LoginViewModel = .init()
    @ObservedObject var registerViewModel: RegisterViewModel = .init()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $screen) {
                    Text("Авторизация").tag(0)
                    Text("Регистрация").tag(1)
                }
                .pickerStyle(.segmented)
                .frame(height: 20)
                .padding([.vertical], 8)
                .padding(.horizontal)
                
                if screen == 0 {
                    LoginView(viewModel: loginViewModel, isButtonEnabled: $isButtonEnabled)
                } else {
                    RegisterView(viewModel: registerViewModel, isButtonEnabled: $isButtonEnabled)
                }
                
                Spacer()
                
                Button {
                    isLoading.toggle()
                } label: {
                    Text(screen == 0 ? "Войти" : "Зарегистрироваться")
                        .frame(maxWidth: .infinity, minHeight: 30)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
                .padding([.bottom], 8)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .disabled(!isButtonEnabled)
                .alert(isPresented: $isLoading) {
                    Alert(title: Text("Ошибка"), message: Text("Имя пользователя уже занято, попробуйте другое"), dismissButton: .default(Text("ОК")))
                }
            }
            .navigationTitle(screen == 0 ? "Авторизация" : "Регистрация")
            .background(Color.secondary.opacity(0.1))
        }
        .overlay {
//            if isLoading {
//                Loader()
//            }
        }
    }
}

struct Loader: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            
            ProgressView()
                .controlSize(.large)
                .frame(width: 40, height: 40)
                .tint(.white)
                .cornerRadius(10)
        }
    }
}

//
//  SignUpView.swift
//  MyPokemon

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authService:AuthService
    
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    @Binding var isSignUpPresented: Bool
    @State private var isErrorPresented = false

    let gradient = Gradient(stops: [
        .init(color: Color(red: 1.0, green: 0.6, blue: 0.2), location: 0.0),  // オレンジ
        .init(color: Color(red: 1.0, green: 0.4, blue: 0.4), location: 1.0)   // 赤）
    ])
    
    private func isInputInvalid() -> Bool {
        return name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
               email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
               password.trimmingCharacters(in: .whitespacesAndNewlines).count < 6
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack{
                Text("アカウント登録")
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .foregroundColor(Color.white)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 3, y: 3)
                
                TextField(
                    text: $name,
                    prompt: Text("名前")
                ){
                    
                }
                .font(.system(size: 20))
                .padding(12)
                .padding(.leading,8)
                .background(Color.white)
                .border(Color.white.opacity(0.6), width: 2)
                .cornerRadius(10)
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .shadow(color: .black.opacity(0.4), radius: 2, x: 3, y: 3)
                .keyboardType(.default)
                
                
                TextField(
                    text: $email,
                    prompt: Text("メールアドレス")
                ){
                    
                }
                .font(.system(size: 20))
                .padding(12)
                .padding(.leading,8)
                .background(Color.white)
                .border(Color.white.opacity(0.6), width: 2)
                .cornerRadius(10)
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
                .shadow(color: .black.opacity(0.4), radius: 2, x: 3, y: 3)
                .keyboardType(.emailAddress)
                
                
                SecureField(
                    text: $password,
                    prompt: Text("パスワード(6文字以上)")
                ) {
                }
                .font(.system(size: 20))
                .padding(12)
                .padding(.leading,8)
                .background(Color.white)
                .border(Color.white.opacity(0.6), width: 2)
                .cornerRadius(10)
                .padding(.horizontal, 24)
                .padding(.bottom, 80)
                .shadow(color: .black.opacity(0.4), radius: 2, x: 3, y: 3)
                .keyboardType(.alphabet)
                
                CustomWideButton(
                    label: "登録する",
                    fontColor: Color.blue,
                    backgroundColor: Color.white,
                    width: 300,
                    height: 36,
                    isDisabled: isInputInvalid(),
                    action: {
                        Task {
                            isSignUpPresented = await !authService.signUp(name: name, email: email, password: password)
                            if authService.errorMessage != nil {
                                isErrorPresented = true
                            }
                        }
                    }
                )
            }
        }
        .overlay(alignment: .topTrailing){
            HStack{
                Spacer()
                
                Button(action: {
                    isSignUpPresented = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30,alignment: .trailing)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                        .padding()
                }
            }
        }
        .alert("エラー",isPresented: $isErrorPresented){
            Button("OK",role: .cancel){
                authService.errorMessage = nil
            }
        } message: {
            Text(authService.errorMessage ?? "")
        }
    }
}

#Preview {
    @Previewable @State var isSignUpPresented: Bool = true
    SignUpView(isSignUpPresented: $isSignUpPresented)
        .environmentObject(AuthService())
}

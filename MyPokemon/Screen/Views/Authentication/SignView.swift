//
//  SignView.swift
//  Mypokemon

import SwiftUI

struct SignView: View {
    @State var isSignInPresented: Bool = false
    @State var isSignUpPresented: Bool = false
    
    let gradient = Gradient(stops: [
        .init(color: Color(red: 1.0, green: 0.6, blue: 0.2), location: 0.0),
        .init(color: Color(red: 1.0, green: 0.4, blue: 0.4), location: 1.0)
    ])
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack{
                    
                    Image("PokemonIcon")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .foregroundColor(Color.white)
                        .padding(.bottom,164)
                    
                    
                    CustomWideButton(
                        label: "ログインする",
                        fontColor: Color.blue,
                        backgroundColor: Color.white,
                        width: geometry.size.width * 0.9,
                        height: geometry.size.height * 0.07,
                        isDisabled: false,
                        action: {
                            isSignInPresented  = true
                            
                        }
                    )
                    
                    Button(action:{
                        isSignUpPresented = true
                    },label: {
                        Text("アカウントを作成する")
                            .font(.headline)
                            .foregroundColor(Color.white)
                    })
                    .padding(.top,28)
                }
            }
        }
        .fullScreenCover(isPresented: $isSignInPresented){
            SignInView(isSignInPresented: $isSignInPresented)
        }
        .fullScreenCover(isPresented: $isSignUpPresented){
            SignUpView(isSignUpPresented: $isSignUpPresented)
        }
    }
}

#Preview {
    SignView()
}

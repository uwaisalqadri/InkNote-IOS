//
//  HomeView.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            Text("Hello")
                .navigationBarItems(leading: menuButton)
        }
    }
}


extension HomeView {
    
    
    var menuButton: some View {
        VStack {
            Spacer(minLength: 45)
            HStack {
                Button(action: {
                    print("Button menu")
                }, label: {
                    Image("MenuIconLight")
                        .foregroundColor(.black)
                        .frame(width: 41, height: 41, alignment: .center)
                })
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                        .shadow(color: .black, radius: 2, x: 0, y: 4)
                        .foregroundColor(.white)
                )
                
                Text("InkNote")
                    .font(.custom("Poppins-Bold", size: 30))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//
//  HomeView.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import SwiftUI

struct HomeView: View {
    
    @State var show = false
    
    let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 20, alignment: .center)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    menuButton
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                        ForEach(1..<10) {_ in
                            NoteRow()
                        }
                    }.padding()
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ExpandableFab(show: $show)
                    }
                    .padding([.leading, .trailing, .bottom], 30)
                }
            }
            .navigationBarHidden(true)
        }
    }
}


extension HomeView {
    
    
    var menuButton: some View {
        VStack {
            Spacer(minLength: 35)
            HStack {
                Button(action: {
                    print("Button menu")
                }) {
                    Image("MenuIconLight")
                        .frame(width: 41, height: 41, alignment: .center)
                }
                .background (
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(radius: 3, x: 0, y: 4)
                    }
                )
                Text("InkNote")
                    .font(.custom("Poppins-Bold", size: 30))
                
                Spacer()
                
            }.padding(.leading, 20)
        }
    }
}

struct ExpandableFab: View {
    
    @Binding var show: Bool
    
    var body: some  View {
        VStack {
            if self.show {
                NavigationLink(destination: WriteView()) {
                    Image("WriteIcon")
                        .frame(width: 10, height: 10)
                        .padding(22)
                }
                .background(Color(red: 0.003, green: 0.85, blue: 0.774))
                .foregroundColor(.black)
                .clipShape(Circle())
                .shadow(radius: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.black, lineWidth: 2)
                        .foregroundColor(.white)
                )
                
                Button(action: {
                    // insert link
                }) {
                    Image("LinkIcon")
                        .frame(width: 10, height: 10)
                        .padding(22)
                }
                .background(Color(red: 0.003, green: 0.85, blue: 0.774))
                .foregroundColor(.black)
                .clipShape(Circle())
                .shadow(radius: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.black, lineWidth: 2)
                        .foregroundColor(.white)
                )
                
                Button(action: {
                    // get image
                }) {
                    Image("ImageIcon")
                        .frame(width: 10, height: 10)
                        .padding(22)
                }
                .background(Color(red: 0.003, green: 0.85, blue: 0.774))
                .foregroundColor(.black)
                .clipShape(Circle())
                .shadow(radius: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.black, lineWidth: 2)
                        .foregroundColor(.white)
                )
            }
            
            Button(action: {
                self.show.toggle()
            }) {
                Image("AddIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .padding(22)
            }
            .background(Color(red: 0.003, green: 0.85, blue: 0.774))
            .foregroundColor(.black)
            .clipShape(Circle())
            .shadow(radius: 8)
            .rotationEffect(.init(degrees: self.show ? -45 : 0))
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.black, lineWidth: 2)
                    .foregroundColor(.white)
            )
        }.animation(.spring())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

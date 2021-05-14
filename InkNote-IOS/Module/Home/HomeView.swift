//
//  HomeView.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import SwiftUI
import Grid

struct HomeView: View {
    
    @EnvironmentObject var presenter: HomePresenter
    @State var show = false
    
    
    let style = StaggeredGridStyle(.vertical, tracks: .min(150), spacing: 10)
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    menuButton
                    Grid(self.presenter.notes, id: \.id) { note in
                        presenter.toWriteView(for: note.id, isEdit: false) {
                            NoteRow(note: note, presenter: presenter)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding()
                }.gridStyle(self.style)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ExpandableFab(show: $show, presenter: self.presenter)
                    }
                    .padding([.leading, .trailing, .bottom], 30)
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                presenter.getNotes()
            }
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
    @ObservedObject var presenter: HomePresenter
    
    var body: some  View {
        VStack {
            if self.show {
                self.presenter.toWriteView(for: 0, isEdit: true) {
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
                    .frame(width: 20, height: 20)
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
        }.animation(.interactiveSpring())
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

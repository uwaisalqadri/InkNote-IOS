//
//  WriteView.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import SwiftUI
import Combine

struct WriteView: View {
    
    let idNote: Int
    @ObservedObject var viewModel: WriteViewModel
    @State var isEditable: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    TextField("Title", text: $viewModel.note.title)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .disabled(!isEditable)
                        .padding(.leading, 20)
                        .font(.custom("Poppins-SemiBold", size: 23))
                }.onAppear {
                    print("id to detail \(idNote)")
                    if idNote != 0 {
                        viewModel.getNoteDetail(idNote: idNote)
                    }
                }
                
                HStack {
                    TextEditor(text: $viewModel.note.desc)
                        .disabled(!isEditable)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding([.leading, .trailing], 17)
                        .padding(.top)
                        .font(.custom("Poppins-Medium", size: 20))
                }
                
                Spacer()
                
                HStack {
                    Button(action: {
                        print("Undo")
                    }) {
                        Image(systemName: "backward.fill")
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {
                        print("Redo")
                    }) {
                        Image(systemName: "forward.fill")
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                    }
                }.padding(.bottom, 20)
            }
            .navigationBarItems(
                leading: leadingItem,
                trailing: trailingItem
            )
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func limitText(_ upper: Int) {
        if viewModel.note.title.count > upper {
            viewModel.note.title = String(viewModel.note.title.prefix(upper))
        }
    }
}

extension WriteView {
    
    var leadingItem: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .padding([.leading, .trailing], 20)
                .padding([.top, .bottom], 17)
                .foregroundColor(.black)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(radius: 3, x: 0, y: 4)
        )
    }
    
    var trailingItem: some View {
        Button(action: {
            isEditable = true
        }) {
            if isEditable {
                Button(action: {
                    if idNote == 0 {
                        viewModel.note.id = Note().autoIncrementId()
                    }
                    print("note id: \(viewModel.note.id)")
                    print("detail: \(viewModel.note)")
                    self.presentationMode.wrappedValue.dismiss()
                    viewModel.saveNote(from: viewModel.note)
                }) {
                    Image(systemName: "checkmark")
                        .padding()
                        .foregroundColor(.black)
                }
            } else {
                Image(systemName: "highlighter")
                    .padding()
                    .foregroundColor(.black)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(radius: 3, x: 0, y: 4)
        )
    }
}

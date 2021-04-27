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
                    if isEditable {
                        TextField("Title", text: $viewModel.note.title)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding(.leading, 20)
                            .font(.custom("Poppins-SemiBold", size: 30))
                            .onReceive(Just(viewModel.note.title), perform: { _ in
                                limitText(10)
                            })
                    } else {
                        Text(viewModel.note.title)
                            .frame(height: 5)
                            .padding(.leading, 20)
                            .font(.custom("Poppins-SemiBold", size: 30))
                    }
                }.onAppear {
                    if idNote != 0 {
                        print("id to detail \(idNote)")
                        viewModel.getNoteDetail(idNote: idNote)
                    }
                }
                
                HStack {
                    MultilineTextField(txt: $viewModel.note.desc, isEdit: $isEditable, placeholder: "Description")
                        .padding([.leading, .trailing], 17)
                        .padding(.top)
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
            isEditable.toggle()
        }) {
            if isEditable {
                Button(action: {
                    viewModel.note.id = (idNote == 0) ? Note().autoIncrementId() : idNote
                    print(viewModel.note.id)
                    viewModel.saveNote(from: viewModel.note)
                    self.presentationMode.wrappedValue.dismiss()
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
            
            // else "checkmark"
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(radius: 3, x: 0, y: 4)
        )
    }
}

//struct WriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        WriteView()
//    }
//}

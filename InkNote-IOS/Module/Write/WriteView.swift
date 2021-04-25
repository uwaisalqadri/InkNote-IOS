//
//  WriteView.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import SwiftUI

struct WriteView: View {
    
    @ObservedObject var viewModel: WriteViewModel
    @State var isEditable = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Title", text: $viewModel.note.title)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .frame(height: 5)
                        .padding(.leading, 20)
                        .padding(.bottom, 8)
                        .font(.custom("Poppins-SemiBold", size: 30))
                }
                
                HStack {
                    MultilineTextField(txt: $viewModel.note.desc, isEdit: $isEditable, placeholder: "Description")
                        .padding([.leading, .trailing], 17)
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
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    viewModel.note.date = dateFormatter.string(from: Date())
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

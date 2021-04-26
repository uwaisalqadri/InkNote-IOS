//
//  WriteView.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import SwiftUI

struct WriteView: View {
    
    @ObservedObject var viewModel: WriteViewModel
    @State var isEditable: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    if isEditable {
                        TextField("Title", text: $viewModel.note.title)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .frame(height: 5)
                            .padding(.leading, 20)
                            .padding(.bottom, 8)
                            .font(.custom("Poppins-SemiBold", size: 30))
                    } else {
                        Text(viewModel.note.title)
                            .frame(height: 5)
                            .padding(.leading, 20)
                            .padding(.bottom, 8)
                            .font(.custom("Poppins-SemiBold", size: 30))
                    }
                }.onAppear {
                    viewModel.getNoteDetail(idNote: 0)
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
                    dateFormatter.dateFormat = DateFormat.completeFormat
                    viewModel.note.id = Note().autoIncrementId()
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

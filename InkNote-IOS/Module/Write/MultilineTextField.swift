//
//  MultilineTextField.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 25/04/21.
//

import Foundation
import SwiftUI


struct MultilineTextField: UIViewRepresentable {
    
    @Binding var txt: String
    @Binding var isEdit: Bool
    var placeholder: String
    
    func makeCoordinator() -> MultilineTextField.Coordinator {
        return MultilineTextField.Coordinator(parent1: self)
    }
    
    
    func makeUIView(context: Context) -> UITextView {
        let text = UITextView()
        text.isEditable = isEdit
        text.isUserInteractionEnabled = true
        text.isScrollEnabled = true
        text.text = placeholder
        text.textColor = .gray
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        text.font = UIFont(name: "Poppins-Medium", size: 20)
        text.delegate = context.coordinator
        return text
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: MultilineTextField
        
        init(parent1: MultilineTextField) {
            self.parent = parent1
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.txt = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .label
        }
    }
}

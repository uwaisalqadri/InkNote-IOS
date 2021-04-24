//
//  WriteView.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import SwiftUI

struct WriteView: View {
    
    @StateObject var viewModel = WriteViewModel()
    
    var body: some View {
        VStack {
            TextField("Title", text: $viewModel.title)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(height: 5)
                .padding(.leading, 20)
            
            TextField("Description", text: $viewModel.description)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(height: 5)
                .padding(.leading, 20)
        }
    }
}

struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        WriteView()
    }
}

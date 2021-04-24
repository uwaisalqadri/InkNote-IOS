//
//  NoteRow.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import SwiftUI

struct NoteRow: View {
    
    // let note: Note
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Pergi ke pasar membeli sayur")
                .font(.custom("Poppins-SemiBold", size: 20))
            Text("Senin, 12 agustus 2021")
                .font(.custom("Poppins-Medium", size: 12))
            Text("Membeli makanan kucing dan peralatan lainnya, Membeli makanan kucing dan peralatan lainnya, Membeli makanan kucing dan peralatan lainnya")
                .font(.custom("Poppins-Medium", size: 15))
                .padding(.top, 10)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white)
                .shadow(radius: 10)
        )
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        NoteRow().previewLayout(.sizeThatFits)
    }
}

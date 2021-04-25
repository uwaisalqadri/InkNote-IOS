//
//  NoteRow.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import SwiftUI

struct NoteRow: View {
    
    let note: Note
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(note.title)
                .font(.custom("Poppins-SemiBold", size: 20))
            Text(note.date)
                .font(.custom("Poppins-Medium", size: 12))
            Text(note.desc)
                .font(.custom("Poppins-Medium", size: 15))
                .padding(.top, 10)
        }
        .padding()
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white)
                    .shadow(radius: 3, x: 0, y: 4)
            }
        )
    }
}

//struct NoteRow_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteRow().previewLayout(.sizeThatFits)
//    }
//}

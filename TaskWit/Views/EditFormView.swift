//
//  EditFormView.swift
//  TaskWit
//
//  Created by Ancel Dev account on 17/11/23.
//

import SwiftUI

struct EditFormView: View {
    @Environment(\.dismiss) private var dismiss
    var item: TaskWit
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.notes)
            Button("Bye") {
                dismiss()
            }
        }
    }
}

#Preview {
    EditFormView(item: TaskWit.test)

}

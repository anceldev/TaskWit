////
////  TaskRow.swift
////  TaskWit
////
////  Created by Ancel Dev account on 17/11/23.
////
//
//import SwiftUI
//
//struct TaskRow: View {
//    
//    var item: TaskWit
//    
//    var colorItem: Color {
//        item.state.colorState
//    }
//    var body: some View {
//        HStack {
//            HStack{
//                VStack(alignment: .leading){
//                    Text(item.title)
//                        .font(.callout)
//                        .bold()
//                        .foregroundStyle(.white)
//                    Text(item.notes)
//                        .font(.caption)
//                        .foregroundStyle(.grayApp)
//                    Spacer()
//                }
//                Spacer()
//                VStack(alignment: .trailing){
//                    Text(" \(item.deadline.formatted(.dateTime.day().month().year())) ")
//                        .foregroundStyle(.white)
//                        .font(.caption)
//                        .padding(3)
//                        .overlay {
//                            Capsule()
//                                .stroke(colorItem, lineWidth: 1)
//                        }
//                    Spacer()
//                    Button {
//                        print("Edit task...")
//                    } label: {
//                        Image(systemName: "pencil")
//                            .foregroundStyle(.grayApp)
//                            .font(.title2)
//                    }
//                }
//            }
//        }
//        .padding(20)
//        .background(.blackGrayApp)
//        .clipShape(RoundedRectangle(cornerRadius: 15))
//    }
//}
//
//#Preview {
//    TaskRow(item: TaskWit.test)
//}

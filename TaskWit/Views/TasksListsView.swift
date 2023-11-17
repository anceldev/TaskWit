//
//  TasksList.swift
//  TaskWit
//
//  Created by Ancel Dev account on 8/11/23.
//
import UIKit
import SwiftUI

struct TasksListsView: View {
    
    @State var viewModel = TasksViewModel()
    @State private var showNewTaskForm = false
    
    @State private var selectedTab: Tab?
    
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blackApp
                VStack(spacing: 15) {
                    CustomTabBar()
                    if viewModel.tasks.isEmpty {
                        VStack {
                            Spacer()
                            Text("No items to display.\nPlease press\n\"+\"\nto add new items")
                                .font(.title)
                                .foregroundStyle(.white)
                                .padding(20)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        
                    }else {
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 0) {
                                ListView(viewModel: viewModel, stateTasks: .pending)
                                    .id(Tab.todo)
                                    .containerRelativeFrame(.horizontal)
                                ListView(viewModel: viewModel, stateTasks: .overdue)
                                    .id(Tab.overdue)
                                    .containerRelativeFrame(.horizontal)
                                ListView(viewModel: viewModel, stateTasks: .completed)
                                    .id(Tab.completed)
                                    .containerRelativeFrame(.horizontal)
                            }
                            
                        }
                        .scrollPosition(id: $selectedTab)
                        .scrollIndicators(.hidden)
                        .scrollTargetBehavior(.paging)
                        .scrollClipDisabled()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(.blackApp)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {
                            showNewTaskForm.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .frame(width: 50, height: 50)
                                .background(.yellowApp)
                                .clipShape(Circle())
                                .foregroundStyle(.white)
                                .font(.title3)
                        })
                    }
                }
            }
            .sheet(isPresented: $showNewTaskForm, content: {
                NewTaskForm(viewModel: viewModel)
            })
        }
        .task {
            await viewModel.loadTasks()
        }
    }
    @ViewBuilder
    func CustomTabBar() -> some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                HStack(spacing: 10) {
                    Image(systemName: "circlebadge.fill")
                        .foregroundStyle(tab.colorTab)
                    Text(tab.rawValue)
                        .font(.callout).bold()
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .contentShape(.capsule)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selectedTab = tab
                    }
                }
            }
        }
        .padding(.horizontal, 15)
    }
}

#Preview {
    TasksListsView()
}

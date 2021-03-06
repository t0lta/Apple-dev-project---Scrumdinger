//
//  DetailView.swift
//  scrumdinger learning
//
//  Created by sammy on 7/16/21.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    @State private var data: DailyScrum.Data = DailyScrum.Data()
    @State private var isPresented = false
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label("Start meeting", systemImage: "timer")
                    .font(.headline)
                        .foregroundColor(.accentColor)
                }
            }
            HStack {
                Label("Meeting Length", systemImage: "clock")
                Spacer()
                Text("\(scrum.lengthInMinutes)")
            }
            HStack {
                Label("Card Color", systemImage: "paintpalette")
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(scrum.color)
            }
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees, id: \.self) {attendee in
                    Label(attendee, systemImage: "person")
                        .accessibilityLabel(Text("Person"))
                        .accessibilityValue(Text(attendee))
                }
            }
        }
        .navigationBarItems(trailing: Button("Edit") {
            isPresented = true
            data = scrum.data
        })
        .navigationTitle(scrum.title)
        .listStyle(InsetGroupedListStyle())
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                EditView(scrumData: $data)
                    .navigationTitle(scrum.title)
                .navigationBarItems(leading: Button("Cancel") {
                    isPresented = false
                }, trailing: Button("Done") {
                    isPresented = false
                    scrum.update(from: data)
                })
            }
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: .constant(DailyScrum.data[0]))
        }
    }
}

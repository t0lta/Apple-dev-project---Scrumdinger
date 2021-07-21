//
//  EditView.swift
//  scrumdinger learning
//
//  Created by sammy on 7/16/21.
//

import SwiftUI

struct EditView: View {
    @Binding var scrumData: DailyScrum.Data
    @State var newAttendee: String = ""
    var body: some View {
        List {
            Section(header: Text("Meeting info")) {
                TextField("Meeting Title", text: $scrumData.title)
            }
        HStack {
            Slider(value: $scrumData.lengthInMinutes, in: 5...30, step: 1.0) {
                Text("length")
            }
            Spacer()
            Text("\(scrumData.lengthInMinutes)")
        }
            ColorPicker("Color", selection: $scrumData.color)
            Section(header: Text("Attendees")) {
                ForEach(scrumData.attendees, id: \.self) { attendee in
                    Text(attendee)
                }
                .onDelete { indices in
                    scrumData.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New attendeee", text: $newAttendee)
                    Button(action: {
                        withAnimation {
                            scrumData.attendees.append(newAttendee)
                            newAttendee = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newAttendee.isEmpty)
                }
            }
                
        }
        .listStyle((InsetGroupedListStyle()))
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(scrumData: .constant(DailyScrum.data[0].data))
    }
}

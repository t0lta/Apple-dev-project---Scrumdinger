//
//  MeetingHeaderView.swift
//  scrumdinger learning
//
//  Created by sammy on 7/19/21.
//

import SwiftUI

struct MeetingHeaderView: View {
    let scrumColor: Color
    var secondsElasped: Int
    var secondsRemaining: Int
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    private var minutesRemainingMetric: String {
        minutesRemaining == 1 ? "minute" : "minutes"
    }
    private var progress: Double {
        guard secondsRemaining > 0 else {return 1}
        let totalSeconds = Double(secondsElasped + secondsRemaining)
        return Double(secondsElasped) / totalSeconds
    }
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(scrumColor: scrumColor))
        HStack {
            VStack(alignment: .leading) {
                Text("Bung-time")
                    .font(.caption)
        Label("\(secondsElasped)", systemImage: "hourglass.bottomhalf.fill")
    }
    
            Spacer()
        VStack(alignment: .trailing) {
                    Text("Remaining")
                        .font(.caption)
                HStack {
                    Text("\(secondsRemaining)")
                    Image(systemName: "hourglass.tophalf.fill")
                }
            }
        }
    }
        .accessibilityElement(children: .ignore)
        .padding([.top, .leading, .trailing])
}
}

struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(scrumColor: DailyScrum.data[0].color, secondsElasped: 60, secondsRemaining: 160)
            .previewLayout(.sizeThatFits)
    }
}

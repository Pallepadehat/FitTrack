import SwiftUI

struct WeekDateSelector: View {
    @Binding var selectedDate: Date
    // Closure to determine status for a given date.
    var statusForDate: (Date) -> DayStatus
    
    @State private var currentWeekIndex: Int = 0
    
    var body: some View {
        TabView(selection: $currentWeekIndex) {
            ForEach(-100...100, id: \.self) { index in
                WeekView(
                    weekOffset: index,
                    selectedDate: $selectedDate,
                    statusForDate: statusForDate
                )
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 80)
        .onLongPressGesture {
            withAnimation {
                currentWeekIndex = 0
                selectedDate = Date()
            }
        }
    }
}

enum DayStatus {
    case completed
    case incomplete
    case future
}

struct WeekView: View {
    let weekOffset: Int
    @Binding var selectedDate: Date
    let statusForDate: (Date) -> DayStatus
    
    private var weekDates: [Date] {
        let calendar = Calendar.current
        let today = Date()
        // Start of *current* week (e.g. Sunday or Monday based on locale)
        guard let startOfCurrentWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
            return []
        }
        
        // Offset by 'n' weeks
        guard let startOfVisibleWeek = calendar.date(byAdding: .weekOfYear, value: weekOffset, to: startOfCurrentWeek) else {
            return []
        }
        
        return (0..<7).compactMap { dayIndex in
            calendar.date(byAdding: .day, value: dayIndex, to: startOfVisibleWeek)
        }
    }
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(weekDates, id: \.self) { date in
                DayView(
                    date: date,
                    isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate),
                    status: statusForDate(date)
                )
                .onTapGesture {
                    withAnimation(.spring()) {
                        selectedDate = date
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct DayView: View {
    let date: Date
    let isSelected: Bool
    let status: DayStatus
    
    private var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }
    
    // Formatters
    private var dayNumber: String {
        let f = DateFormatter()
        f.dateFormat = "d"
        return f.string(from: date)
    }
    
    private var dayName: String {
        let f = DateFormatter()
        f.dateFormat = "E"
        return f.string(from: date)
    }
    
    var body: some View {
        VStack(spacing: 5) {
            // Day Name (Mon, Tue...): Gray text
            Text(dayName)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.gray)
            
            ZStack {
                // The Circle Indicator
                circleView
                    .frame(width: 33, height: 33)
                
                // The Day Number
                Text(dayNumber)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(textColor)
            }
        }
        .frame(width: 45) // Fixed container width
        .padding(.vertical, 12)
        .background(
            ZStack {
                if isSelected {
                    // Selection: White Rounded Rectangle with Shadow
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y:0)
                        .frame(width: 50, height: 75)
                        
                }
            }
        )
    }
    
    @ViewBuilder
    private var circleView: some View {
        switch status {
        case .completed:
            // "when complete it is green"
            Circle()
                .fill(Color.green)
            
        case .future:
            // "upcoming next day it will be gryed out and solid circle"
            Circle()
                .fill(Color.gray.opacity(0.2))
            
        case .incomplete:
            // "on the day it is solid" -> Today
            // "on the other days... dotted" -> Past
            if isToday {
                 // Solid Ring
                Circle()
                    .stroke(Color.primary.opacity(0.4), lineWidth: 2)
            } else {
                // Dotted Ring
                Circle()
                    .stroke(Color.gray.opacity(0.4), style: StrokeStyle(lineWidth: 2, dash: [4, 4]))
            }
        }
    }
    
    private var textColor: Color {
        switch status {
        case .completed:
            return .white
        case .future:
            return .gray
        case .incomplete:
            return .primary
        }
    }
}

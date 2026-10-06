import SwiftUI

// Data models
struct HourlyForecast: Identifiable {
    let id = UUID()
    let time: String
    let iconName: String
    let temp: String
    var isSunset: Bool = false
}

struct DailyForecast: Identifiable {
    let id = UUID()
    let day: String
    let iconName: String
    let lowTemp: String
    let highTemp: String
    let gradientColors: [Color]
}

struct ContentView: View {
    // Hourly weather data
    let hourlyData: [HourlyForecast] = [
        HourlyForecast(time: "Now", iconName: "sun.max.fill", temp: "72°"),
        HourlyForecast(time: "5PM", iconName: "sun.max.fill", temp: "72°"),
        HourlyForecast(time: "6PM", iconName: "sun.max.fill", temp: "70°"),
        HourlyForecast(time: "6:52PM", iconName: "sunset.fill", temp: "Sunset", isSunset: true),
        HourlyForecast(time: "7PM", iconName: "moon.stars.fill", temp: "66°")
    ]
    
    // 5-day weather data
    let dailyData: [DailyForecast] = [
        DailyForecast(day: "Today", iconName: "sun.max.fill", lowTemp: "54°", highTemp: "72°", gradientColors: [.green, .yellow]),
        DailyForecast(day: "Wed", iconName: "sun.max.fill", lowTemp: "50°", highTemp: "75°", gradientColors: [.cyan, .yellow]),
        DailyForecast(day: "Thu", iconName: "sun.max.fill", lowTemp: "55°", highTemp: "82°", gradientColors: [.yellow, .orange]),
        DailyForecast(day: "Fri", iconName: "cloud.fill", lowTemp: "60°", highTemp: "74°", gradientColors: [.orange, .yellow]),
        DailyForecast(day: "Sat", iconName: "cloud.rain.fill", lowTemp: "57°", highTemp: "72°", gradientColors: [.yellow, .green])
    ]
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color.blue.opacity(0.8), Color.cyan.opacity(0.5)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Header
                    HeaderView(location: "Chapel Hill", currentTemp: "72°", condition: "Sunny", high: "72°", low: "54°")
                        .padding(.top, 20)
                    
                    // Hourly section
                    HourlyForecastCard(hourlyData: hourlyData)
                        .padding(.horizontal, 20)
                    
                    // Daily section
                    DailyForecastCard(dailyData: dailyData)
                        .padding(.horizontal, 20)
                }
            }
            
            // Bottom dock
            VStack {
                Spacer()
                BottomDockView()
            }
        }
        .foregroundStyle(.white)
    }
}

// Subviews

struct HeaderView: View {
    let location: String
    let currentTemp: String
    let condition: String
    let high: String
    let low: String
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 4) {
                Image(systemName: "location.fill")
                    .font(.caption)
                Text("HOME")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle(.white.opacity(0.8))
            
            Text(location)
                .font(.largeTitle)
                .fontWeight(.medium)
            
            Text(currentTemp)
                .font(.system(size: 80, weight: .thin))
            
            Text(condition)
                .font(.title3)
                .fontWeight(.semibold)
            
            HStack(spacing: 8) {
                Text("H:\(high)")
                Text("L:\(low)")
            }
            .font(.subheadline)
            .fontWeight(.semibold)
        }
    }
}

struct HourlyForecastCard: View {
    let hourlyData: [HourlyForecast]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Conditions Temperature (°F)")
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.white.opacity(0.8))
            
            Divider()
                .background(.white.opacity(0.3))
            
            HStack(spacing: 0) {
                ForEach(hourlyData) { item in
                    VStack(spacing: 12) {
                        Text(item.time)
                            .font(.subheadline)
                            .bold()
                        
                        Image(systemName: item.iconName)
                            .renderingMode(.original)
                            .font(.title2)
                        
                        Text(item.temp)
                            .font(.subheadline)
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct DailyForecastCard: View {
    let dailyData: [DailyForecast]
    
    var body: some View {
        VStack(spacing: 14) {
            ForEach(dailyData) { item in
                HStack {
                    Text(item.day)
                        .font(.body)
                        .bold()
                        .frame(width: 60, alignment: .leading)
                    
                    Image(systemName: item.iconName)
                        .renderingMode(.original)
                        .font(.title3)
                        .frame(width: 30)
                    
                    Spacer()
                    
                    Text(item.lowTemp)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.7))
                        .frame(width: 35)
                    
                    // Temp bar
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: item.gradientColors,
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(height: 5)
                        .padding(.horizontal, 8)
                    
                    Text(item.highTemp)
                        .font(.subheadline)
                        .bold()
                        .frame(width: 35)
                }
                
                if item.id != dailyData.last?.id {
                    Divider()
                        .background(.white.opacity(0.2))
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct BottomDockView: View {
    var body: some View {
        HStack(spacing: 35) {
            Image(systemName: "map")
            Spacer()
            HStack(spacing: 8) {
                Image(systemName: "location.fill")
                    .font(.caption2)
                Circle().frame(width: 6, height: 6).opacity(0.5)
                Circle().frame(width: 6, height: 6).opacity(0.5)
                Circle().frame(width: 6, height: 6).opacity(0.5)
            }
            Spacer()
            Image(systemName: "list.bullet")
        }
        .font(.title3)
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .padding(.horizontal, 40)
        .padding(.bottom, 10)
    }
}

#Preview {
    ContentView()
}

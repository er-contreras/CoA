pub const Goal = struct {
    goal: []const u8,
    priority_type: []const u8,
    current_page: []const u8,
    time_spent_today: []const u8,
    last_date_worked: []const u8,
    days_since_last: []const u8,
    day_started: []const u8,
    status_bar: []const u8,
};

// fn createGoal(
//     goal: []const u8,
//     priority_type: []const u8,
//     current_page: []const u8,
//     time_spent_today: []const u8,
//     last_date_worked: []const u8,
//     days_since_last: []const u8,
//     day_started: []const u8,
//     status_bar: []const u8,
// ) Goal {
//     return .{
//         .goal = goal,
//         .priority_type = priority_type,
//         .current_page = current_page,
//         .time_spent_today = time_spent_today,
//         .last_date_worked = last_date_worked,
//         .days_since_last = days_since_last,
//         .day_started = day_started,
//         .status_bar = status_bar,
//     };
// }

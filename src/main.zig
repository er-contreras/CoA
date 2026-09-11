const std = @import("std");
const print = std.debug.print;

const options = [_][]const u8{ "Add", "Remove", "Update", "Exit" };

const Goal = struct {
    goal: []const u8,
    priority_type: []const u8,
    current_page: []const u8,
    time_spent_today: []const u8,
    last_date_worked: []const u8,
    days_since_last: []const u8,
    day_started: []const u8,
};

fn createGoal(
    goal: []const u8,
    priority_type: []const u8,
    current_page: []const u8,
    time_spent_today: []const u8,
    last_date_worked: []const u8,
    days_since_last: []const u8,
    day_started: []const u8,
) Goal {
    return .{
        .goal = goal,
        .priority_type = priority_type,
        .current_page = current_page,
        .time_spent_today = time_spent_today,
        .last_date_worked = last_date_worked,
        .days_since_last = days_since_last,
        .day_started = day_started,
    };
}

const goals = [_]Goal{
    createGoal("Meditation", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
    createGoal("Zig project", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
    createGoal("Computer Systems a Programmer Perspective", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
    createGoal("Think in Systems by Danna", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
    createGoal("CLRS", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
    createGoal("AI Engineering by Chip Huyen", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
    createGoal("Network Programming with C by Lewis Van Winckle", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
    createGoal("Design Data Intensive Application", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
    createGoal("Apply for Jobs", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
    createGoal("Bycle", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
};

fn printGoalCards() void {
    print("\n", .{});

    const goals = .{
        createGoal("Meditation", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
        createGoal("Zig project", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
        createGoal("Computer Systems a Programmer Perspective", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
        createGoal("Think in Systems by Danna", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
        createGoal("CLRS", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
        createGoal("AI Engineering by Chip Huyen", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
        createGoal("Network Programming with C by Lewis Van Winckle", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
        createGoal("Design Data Intensive Application", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
        createGoal("Apply for Jobs", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
        createGoal("Bycle", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026"),
    };

    inline for (goals) |goal| {
        print(
            "\x1b[31mGoal\x1b[0m: {s}\n | Priority Type: {s}\n | Current Page: {s}\n | Time Spent Today: {s}\n | Last Day Worked: {s}\n | Days Since Last: {s}\n | Day Started: {s}\n",
            .{goal.goal, goal.priority_type, goal.current_page, goal.time_spent_today, goal.last_date_worked, goal.days_since_last, goal.day_started}
            );
    }

}

pub fn main(init: std.process.Init) !void {
    print("Welcome Erick to Course of Action\n\n", .{});

    const stdin_file = std.Io.File.stdin();
    var input_buffer: [1024]u8 = undefined;
    var file_reader = stdin_file.reader(init.io, &input_buffer);
    const reader = &file_reader.interface;

    var boolean = true;
    while (boolean) {
        print("\x1b[36mChoose an option\x1b[0m\n", .{});
        for (options, 0..) |option, i| {
            print("{d}. {s} a task | ", .{ i + 1, option });
        }

        print("\n", .{});

        printGoalCards();

        if (try reader.takeDelimiter('\n')) |line| {
            const number: u8 = std.fmt.parseInt(u8, line, 10) catch |err| switch (err) {
                error.InvalidCharacter => {
                    print("Received a non-numeric character!\n", .{});
                    continue;
                },
                error.Overflow => {
                    print("Number too large!\n", .{});
                    continue;
                },
            };

            switch (number) {
                1 => print("Adding task...\n", .{}),
                2 => print("Removing task...\n", .{}),
                3 => print("Updating task...\n", .{}),
                4 => boolean = false,
                else => print("Unexpected number try again\n", .{}),
            }
        }
    }
}

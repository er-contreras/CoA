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
    status_bar: []const u8,
};

fn createGoal(
    goal: []const u8,
    priority_type: []const u8,
    current_page: []const u8,
    time_spent_today: []const u8,
    last_date_worked: []const u8,
    days_since_last: []const u8,
    day_started: []const u8,
    status_bar: []const u8,
) Goal {
    return .{
        .goal = goal,
        .priority_type = priority_type,
        .current_page = current_page,
        .time_spent_today = time_spent_today,
        .last_date_worked = last_date_worked,
        .days_since_last = days_since_last,
        .day_started = day_started,
        .status_bar = status_bar,
    };
}

const goals = [_]Goal{
    createGoal("Meditation", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026", "\x1b[42m           \x1b[0m"),
    createGoal("Zig project", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026", "\x1b[43m           \x1b[0m"),
    createGoal("Computer Systems a Programmer Perspective", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026", "\x1b[41m           \x1b[0m"),
    createGoal("Think in Systems by Danna", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026", "\x1b[42m           \x1b[0m"),
    createGoal("CLRS", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026", "\x1b[42m           \x1b[0m"),
    createGoal("AI Engineering by Chip Huyen", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026", "\x1b[42m           \x1b[0m"),
    createGoal("Network Programming with C by Lewis Van Winckle", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026", "\x1b[43m           \x1b[0m"),
    createGoal("Design Data Intensive Application", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026", "\x1b[41m           \x1b[0m"),
    createGoal("Apply for Jobs", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026", "\x1b[42m           \x1b[0m"),
    createGoal("Bycle", "Highest", "-", "50mins", "09/09/2026", "0", "28/08/2026", "\x1b[42m           \x1b[0m"),
};

fn getTerminalWidth() u16 {
    var ws: std.posix.winsize = undefined;
    const stdout_fd = std.Io.File.stdout().handle;

    const err = std.posix.system.ioctl(stdout_fd, std.posix.T.IOCGWINSZ, @intFromPtr(&ws));

    if (err == 0 and ws.col > 0) {
        return ws.col;
    }

    return 80;
}

fn printGoals() void {
    print("\n", .{});

    print(
        "\x1b[31m\x1b[1m\x1b[4m{s: <10}{s: >20}{s: >20}{s: >20}{s: >20}{s: >20}{s: >20}{s: >20}\x1b\x1b\x1b[0m",
        .{
            "Goals:",
            "Priority Type:",
            "Current Page:",
            "Time Spent Today:",
            "Last Day Worked:",
            "Days Since Last:",
            "Day Started:",
            "Status Bar:",
        },
    );
    print("\n", .{});

    for (goals) |g| {
        print(
            "{s: <20}{s: <20}{s: <20}{s: <20}{s: <20}{s: <20}{s: <20}{s: <20}",
            .{
                truncate(g.goal, 15),
                g.priority_type,
                g.current_page,
                g.time_spent_today,
                g.last_date_worked,
                g.days_since_last,
                g.day_started,
                g.status_bar,
            },
        );
        print("\n", .{});
    }
}

fn truncate(s: []const u8, max_len: usize) []const u8 {
    if (s.len > max_len) {
        return s[0..max_len];
    } else {
        return s;
    }
}

pub fn main(init: std.process.Init) !void {
    print("Welcome Erick to Course of Action\n", .{});
    print("{s}\n", .{std.posix.uname().machine});

    const stdin_file = std.Io.File.stdin();
    var input_buffer: [1024]u8 = undefined;
    var file_reader = stdin_file.reader(init.io, &input_buffer);
    const reader = &file_reader.interface;

    var boolean = true;
    while (boolean) {
        print("\x1b[36mChoose an option\x1b[0m\n", .{});
        print("\x1b[2J\x1b[H", .{});
        for (options, 0..) |option, i| {
            print("{d}. {s} a task | ", .{ i + 1, option });
        }

        print("\n", .{});

        printGoals();

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

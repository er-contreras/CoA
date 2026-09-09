const std = @import("std");
const print = std.debug.print;

const options = [_][]const u8{ "Add", "Remove", "Update", "Exit" };

const goals = [_][]const u8{
    "Meditation",
    "Thinking In Systems",
    "Computer Systems",
    "Network Programming In C",
    "Introduction to Algorithms",
    "AI Engineering",
    "Course of Action",
    "Bycle",
    "Design Data Intensive Application",
};

const headers = [_][]const u8{
    "Goal/Task",
    "Priority Type",
    "Current Page",
    "Time Spent Today",
    "Last Date Worked",
    "Days Since Last",
    "Day Started",
};

fn add_task() !void {
    print("Adding task...\n", .{});
}

fn list_all_task() void {
    print("\n", .{});

    for (headers) |header| {
        print("\x1b[30;47m{s}\x1b[0m | ", .{header});
    }

    print("\n", .{});

    for (goals) |goal| {
        print("{s} | \n", .{goal});
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
        print("Choose an option\n", .{});
        for (options, 0..) |option, i| {
            print("{d}. {s} a task | ", .{ i + 1, option });
        }

        print("\n", .{});

        list_all_task();

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
                1 => try add_task(),
                2 => print("Removing task...\n", .{}),
                3 => print("Updating task...\n", .{}),
                4 => boolean = false,
                else => print("Unexpected number try again\n", .{}),
            }
        }
    }
}

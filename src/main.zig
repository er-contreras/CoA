const std = @import("std");
const print = std.debug.print;
const options = [_][]const u8{ "Add", "Remove", "Update", "Exit" };

pub fn main(init: std.process.Init) !void {
    print("Welcome Erick to Course of Action\n\n", .{});

    const stdin_file = std.Io.File.stdin();
    var input_buffer: [1024]u8 = undefined;
    var file_reader = stdin_file.reader(init.io, &input_buffer);
    const reader = &file_reader.interface;

    print("Choose an option\n", .{});
    for (options, 0..) |option, i| {
        print("{d}. {s} a task\n", .{i + 1, option});
    }

    std.debug.print("Add a task and hit enter: \n", .{});

    var boolean = true;
    while (boolean) {
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

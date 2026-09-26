const std = @import("std");
const print = std.debug.print;

const print_goals = @import("print_goals.zig");

const options = [_][]const u8{ "Add", "Remove", "Update", "Exit" };

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer _ = arena.deinit();
    const allocator = arena.allocator();

    const stdin_file = std.Io.File.stdin();
    var input_buffer: [1024]u8 = undefined;
    var file_reader = stdin_file.reader(init.io, &input_buffer);
    const reader = &file_reader.interface;

    var boolean = true;
    while (boolean) {
        print("{s}{s}{s}{s}{s}", .{
            "\x1b[2J\x1b[H",
            "\x1b[?1049h",
            "Welcome Erick to Course of Action\n",
            std.posix.uname().machine,
            "\x1b[36m\nChoose an Option\x1b[0m\n",
        });

        for (options, 0..) |option, i| {
            print("{d}. {s} a task | ", .{ i + 1, option });
        }

        print("\n", .{});

        try print_goals.printGoals(io, allocator);

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
    // End alt buffer
    print("\x1b[?1049l", .{});
}

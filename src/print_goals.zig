const std = @import("std");
const print = std.debug.print;

const goal_struct = @import("goal_struct.zig");

pub fn printGoals(io: std.Io, allocator: std.mem.Allocator) !void {
    const max_bytes = 10 * 1024 * 1024; //10KB limit
    const file_contents = try std.Io.Dir.cwd().readFileAlloc(io, "src/data.json", allocator, .limited(max_bytes));
    defer allocator.free(file_contents);

    const parsed = try std.json.parseFromSlice([]goal_struct.Goal, allocator, file_contents, .{
        .ignore_unknown_fields = true,
    });
    defer parsed.deinit();

    const goals = parsed.value;

    print("\n", .{});

    print(
        "\x1b[31m\x1b[1m\x1b[4m{s: <10}{s: >20}{s: >20}{s: >20}{s: >20}{s: >20}{s: >20}{s: >20}\x1b\x1b\x1b[0m",
        .{
            "Goals",
            "Priority Type",
            "Current Page",
            "Time Spent Today",
            "Last Day Worked",
            "Days Since Last",
            "Day Started",
            "Status Bar",
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

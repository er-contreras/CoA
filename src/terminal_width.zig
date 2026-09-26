const std = @import("std");

fn getTerminalWidth() u16 {
    var ws: std.posix.winsize = undefined;
    const stdout_fd = std.Io.File.stdout().handle;

    const err = std.posix.system.ioctl(stdout_fd, std.posix.T.IOCGWINSZ, @intFromPtr(&ws));

    if (err == 0 and ws.col > 0) {
        return ws.col;
    }

    return 80;
}

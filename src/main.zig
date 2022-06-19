const c = @import("3ds/c.zig");
const system = @import("3ds/system.zig");

export fn main(_: c_int, _: [*]const [*:0]const u8) void {
    c.gfxInitDefault();
    defer c.gfxExit();
    _ = c.consoleInit(c.GFX_TOP, null);

    _ = c.printf("Hello, Zig");
    while (c.aptMainLoop()) {
        system.gspWaitForVBlank(); // TODO: This should be c.gspWaitForVBlank();
        c.gfxSwapBuffers();
    }
}

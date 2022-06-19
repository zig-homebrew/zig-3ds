const c = @import("c.zig");

extern fn gspWaitForEvent(id: c.GSPGPU_Event, nextEvent: bool) void; // TODO: This should be removed
pub fn gspWaitForVBlank() void {
    gspWaitForEvent(c.GSPGPU_EVENT_VBlank0, true);
}

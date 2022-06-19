const std = @import("std");
const builtin = @import("builtin");

const emulator = "citra";
const flags = .{"-lctru"};
const devkitpro = "/opt/devkitpro";

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();

    const obj = b.addObject("zig-3ds", "src/main.zig");
    obj.setOutputDir("zig-out");
    obj.linkLibC();
    obj.setLibCFile(std.build.FileSource{ .path = "libc.txt" });
    obj.addIncludeDir(devkitpro ++ "/libctru/include");
    obj.addIncludeDir(devkitpro ++ "/portlibs/3ds/include");
    obj.setTarget(.{
        .cpu_arch = .arm,
        .os_tag = .freestanding,
        .abi = .eabihf,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.mpcore },
    });
    obj.setBuildMode(mode);

    const extension = if (builtin.target.os.tag == .windows) ".exe" else "";
    const elf = b.addSystemCommand(&(.{
        devkitpro ++ "/devkitARM/bin/arm-none-eabi-gcc" ++ extension,
        "-g",
        "-march=armv6k",
        "-mtune=mpcore",
        "-mfloat-abi=hard",
        "-mtp=soft",
        "-Wl,-Map,zig-out/zig-3ds.map",
        "-specs=" ++ devkitpro ++ "/devkitARM/arm-none-eabi/lib/3dsx.specs",
        "zig-out/zig-3ds.o",
        "-L" ++ devkitpro ++ "/libctru/lib",
        "-L" ++ devkitpro ++ "/portlibs/3ds/lib",
    } ++ flags ++ .{
        "-o",
        "zig-out/zig-3ds.elf",
    }));

    const dsx = b.addSystemCommand(&.{
        devkitpro ++ "/tools/bin/3dsxtool" ++ extension,
        "zig-out/zig-3ds.elf",
        "zig-out/zig-3ds.3dsx",
    });
    dsx.stdout_action = .ignore;

    b.default_step.dependOn(&dsx.step);
    dsx.step.dependOn(&elf.step);
    elf.step.dependOn(&obj.step);

    const run_step = b.step("run", "Run in Citra");
    const citra = b.addSystemCommand(&.{ emulator, "zig-out/zig-3ds.3dsx" });
    run_step.dependOn(&dsx.step);
    run_step.dependOn(&citra.step);
}

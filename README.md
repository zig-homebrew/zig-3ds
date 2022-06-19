# zig-3ds

Currently doesn't work because of following issue:

```
zig/zig-homebrew/zig-3ds via ↯ v0.9.1 ❯ zig build
/opt/devkitpro/devkitARM/bin/../lib/gcc/arm-none-eabi/12.1.0/../../../../arm-none-eabi/bin/ld:
cannot find 3dsx_crt0.o: No such file or directory
collect2: error: ld returned 1 exit status
The following command exited with error code 1 (expected 0):
cd /home/odd/source/zig/zig-homebrew/zig-3ds && /opt/devkitpro/devkitARM/bin/arm-none-eabi-gcc
-g -march=armv6k -mtune=mpcore -mfloat-abi=soft -mtp=soft -Wl,-Map,zig-out/zig-3ds.map
-specs=/opt/devkitpro/devkitARM/arm-none-eabi/lib/3dsx.specs zig-out/zig-3ds.o
-L/opt/devkitpro/libctru/lib -L/opt/devkitpro/portlibs/3ds/lib -lctru -o
zig-out/zig-3ds.elf
```

## Getting started

- [zig](https://ziglang.org/download/)
- [devkitPro](https://devkitpro.org/wiki/Getting_Started)

```
pacman -S 3ds-dev
git clone https://github.com/zig-homebrew/zig-3ds
cd zig-3ds/
zig build # then run zig-out/zig-3ds.3dsx with citra
```

## Resources

- [3ds-examples](https://github.com/devkitPro/3ds-examples)
- [libctru repository](https://github.com/devkitPro/libctru)
- [libctru documentation](https://libctru.devkitpro.org/files.html)

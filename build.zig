const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardOptimizeOption(.{});

    const tracy_client = b.addStaticLibrary(.{
        .name = "tracy",
        .target = target,
        .optimize = mode,
    });
    tracy_client.linkLibCpp();
    tracy_client.force_pic = true;
    tracy_client.addCSourceFiles(&.{
        "tracy/public/TracyClient.cpp",
    }, &.{
        "-DTRACY_ENABLE"
    });

    b.installArtifact(tracy_client);
}

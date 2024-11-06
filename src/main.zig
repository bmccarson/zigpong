// raylib-zig (c) Nikolas Wipper 2023
const std = @import("std");
const rl = @import("raylib");

const settings = @import("settings.zig");
const ball = @import("ball.zig").Ball;

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = settings.SCREEN_WIDTH;
    const screenHeight = settings.SCREEN_HEIGHT;

    rl.initWindow(screenWidth, screenHeight, "Zig Pong");
    defer rl.closeWindow(); // Close window and OpenGL context

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second

    var game_ball = ball.init(0, 0, 32, 4);
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        const dt = rl.getFrameTime();

        game_ball.update(dt);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.black);

        game_ball.draw();

        //----------------------------------------------------------------------------------
    }
}

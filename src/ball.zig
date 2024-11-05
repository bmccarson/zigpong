const rl = @import("raylib");
const rlm = @import("raylib").math;

const settings = @import("settings.zig");

pub const Ball = struct {
    size: rl.Vector2,
    position: rl.Vector2,
    direction: rl.Vector2,

    pub fn init(pos_X: f32, pos_Y: f32, size: f32, direction: f32) Ball {
        return Ball{
            .size = rl.Vector2.init(size, size),
            .position = rl.Vector2.init(pos_X, pos_Y),
            .direction = rl.Vector2.init(direction, direction),
        };
    }

    pub fn draw(self: *Ball) void {
        rl.drawRectangleV(self.position, self.size, rl.Color.white);
    }

    pub fn update(self: *Ball) void {
        self.position = rlm.vector2Add(self.position, self.direction);

        if (self.position.y <= 0 or self.position.y + self.size.y >= settings.SCREEN_HEIGHT) {
            self.direction.y *= -1;
        }

        if (self.position.x <= 0 or self.position.x + self.size.x >= settings.SCREEN_WIDTH) {
            self.direction.x *= -1;
        }
    }
};

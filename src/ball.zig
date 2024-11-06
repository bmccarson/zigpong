const rl = @import("raylib");
const rlm = @import("raylib").math;

const settings = @import("settings.zig");

pub const Ball = struct {
    size: rl.Vector2,
    position: rl.Vector2,
    direction: rl.Vector2,
    speed: f32,

    pub fn init(pos_X: f32, pos_Y: f32, size: f32, direction: f32) Ball {
        return Ball{
            .size = rl.Vector2.init(size, size),
            .position = rl.Vector2.init(pos_X, pos_Y),
            .direction = rl.Vector2.init(direction, direction),
            .speed = settings.BALL_SPEED,
        };
    }

    pub fn draw(self: *Ball) void {
        rl.drawRectangleV(self.position, self.size, rl.Color.white);
    }

    pub fn update(self: *Ball, dt: f32) void {
        self.position.x += self.direction.x * self.speed * dt;
        self.position.y += self.direction.y * self.speed * dt;
        self.wall_collision();
    }

    fn wall_collision(self: *Ball) void {
        if (self.position.y <= 0) {
            self.position.y = 0;
            self.direction.y *= -1;
        }
        if (self.position.y + self.size.y >= settings.SCREEN_HEIGHT) {
            self.position.y = settings.SCREEN_HEIGHT - self.size.y;
            self.direction.y *= -1;
        }

        if (self.position.x <= 0 or self.position.x >= settings.SCREEN_WIDTH) {
            self.reset();
        }
    }

    fn reset(self: *Ball) void {
        if (self.position.x <= 0 or self.position.x + self.size.x >= settings.SCREEN_WIDTH) {
            self.position.x = (settings.SCREEN_WIDTH / 2) - (self.size.x / 2);
            self.position.y = (settings.SCREEN_HEIGHT / 2) - (self.size.y / 2);
        }
    }
};

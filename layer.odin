package main

import rl "vendor:raylib"

layer :: struct {
	texture:  rl.Texture2D,
	position: rl.Vector2,
	rotation: f32,
	scale:    f32,
	color:    rl.Color,
}

layers := make([]layer, 128)

draw_layers :: proc() {
	for i in layers {
		rl.DrawTextureEx(i.texture, i.position, i.rotation, i.scale, i.color)
	}
}

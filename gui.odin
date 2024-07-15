package main

import "core:fmt"
import "core:math"
import "core:strconv"
import "core:strings"
import rl "vendor:raylib"
import "vendor:raylib/rlgl"

button :: struct {
	x:      i32,
	y:      i32,
	radius: f32,
}

on_off_btn := button{270, 250, 20}
increase_temp_btn := button{320, 250, 20}
decrease_temp_btn := button{320, 300, 20}

is_button_pressed :: proc(btn: button) -> bool {
	return(
		rl.IsMouseButtonPressed(.LEFT) &&
		rl.CheckCollisionPointCircle(
			rl.GetMousePosition(),
			{auto_cast btn.x, auto_cast btn.y},
			btn.radius,
		) \
	)
}

buf: [8]byte

draw_on_off_btn :: proc() {
	rl.DrawCircle(
		on_off_btn.x,
		on_off_btn.y,
		on_off_btn.radius,
		on_off ? {180, 50, 50, 255} : {50, 180, 50, 255},
	)
	rl.DrawRing(
		{auto_cast on_off_btn.x, auto_cast on_off_btn.y},
		8,
		12,
		-45,
		225,
		180,
		{255, 255, 255, 255},
	)
	rl.DrawRectangleRounded(
		{auto_cast on_off_btn.x - 2, auto_cast on_off_btn.y - 12, 4, 13},
		1,
		8,
		{255, 255, 255, 255},
	)
}

draw_increase_temp_btn :: proc() {
	rl.DrawCircle(
		increase_temp_btn.x,
		increase_temp_btn.y,
		increase_temp_btn.radius,
		rl.CheckCollisionPointCircle(
			rl.GetMousePosition(),
			{auto_cast increase_temp_btn.x, auto_cast increase_temp_btn.y},
			20,
		) &&
		rl.IsMouseButtonDown(.LEFT) \
		? {200, 200, 200, 255} \
		: {150, 150, 150, 255},
	)
	rl.DrawTriangle(
		{auto_cast increase_temp_btn.x, auto_cast increase_temp_btn.y - 9},
		{auto_cast increase_temp_btn.x - 8, auto_cast increase_temp_btn.y + 6},
		{auto_cast increase_temp_btn.x + 8, auto_cast increase_temp_btn.y + 6},
		{255, 255, 255, 255},
	)
}

draw_decrease_temp_btn :: proc() {
	rl.DrawCircle(
		decrease_temp_btn.x,
		decrease_temp_btn.y,
		decrease_temp_btn.radius,
		rl.CheckCollisionPointCircle(
			rl.GetMousePosition(),
			{auto_cast decrease_temp_btn.x, auto_cast decrease_temp_btn.y},
			20,
		) &&
		rl.IsMouseButtonDown(.LEFT) \
		? {200, 200, 200, 255} \
		: {150, 150, 150, 255},
	)
	rl.DrawTriangle(
		{auto_cast decrease_temp_btn.x, auto_cast decrease_temp_btn.y + 9},
		{auto_cast decrease_temp_btn.x + 8, auto_cast decrease_temp_btn.y - 6},
		{auto_cast decrease_temp_btn.x - 8, auto_cast decrease_temp_btn.y - 6},
		{255, 255, 255, 255},
	)
}

draw_temp :: proc() {
	if on_off {
		rl.DrawText(
			strings.clone_to_cstring(strconv.itoa(buf[:], temp)),
			530,
			50,
			24,
			{180, 180, 180, 255},
		)
	}
}

draw_wind_symbol :: proc() {
	rlgl.PushMatrix()
	rlgl.Translatef(170, 170, 0)
	rlgl.Rotatef(45, 0, 0, 1)
	rl.DrawRectangleRounded({-5, -7, 10, 40}, 5, 8, {255, 255, 255, auto_cast (128 * volume)})
	rlgl.PopMatrix()

	rlgl.PushMatrix()
	rlgl.Translatef(320, 170, 0)
	rlgl.Rotatef(0, 0, 0, 1)
	rl.DrawRectangleRounded({-5, -7, 10, 40}, 5, 8, {255, 255, 255, auto_cast (128 * volume)})
	rlgl.PopMatrix()

	rlgl.PushMatrix()
	rlgl.Translatef(470, 170, 0)
	rlgl.Rotatef(-45, 0, 0, 1)
	rl.DrawRectangleRounded({-5, -7, 10, 40}, 5, 8, {255, 255, 255, auto_cast (128 * volume)})
	rlgl.PopMatrix()
}

draw_light :: proc() {
	rl.DrawCircle(569, 133, 2, on_off ? {255, 255, 0, 255} : {180, 180, 180, 255})
}

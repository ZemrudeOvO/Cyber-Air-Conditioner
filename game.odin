package main

import "core:fmt"
import "core:os"
import "core:path/filepath"
import "core:strconv"
import "core:strings"
import rl "vendor:raylib"

_ready :: proc() {
	load_sound()

	data_ac := #load("/images/AC.png")
	img_ac := rl.LoadImageFromMemory(".png", raw_data(data_ac[:]), auto_cast len(data_ac[:]))
	tex_ac := rl.LoadTextureFromImage(img_ac)

	scale: f32 = 0.15

	layers[0] = {
		tex_ac,
		{(auto_cast rl.GetScreenWidth() - (scale * f32(tex_ac.width))) / 2, 20},
		0,
		0.15,
		{255, 255, 255, 255},
	}
}

_update :: proc() {
	if is_button_pressed(on_off_btn) {
		on_off = !on_off
	}

	if is_button_pressed(increase_temp_btn) && on_off {
		temp += 1
		temp = clamp(temp, 16, 30)
		rl.PlaySound(di)
		fmt.println(temp)
	}

	if is_button_pressed(decrease_temp_btn) && on_off {
		temp -= 1
		temp = clamp(temp, 16, 30)
		rl.PlaySound(di)
		fmt.println(temp)
	}

	if is_button_pressed(fan_swap_btn) {
		is_swap = !is_swap
	}

	fan_swap()
	play_sound()
}

_draw :: proc() {
	rl.BeginDrawing()
	defer rl.EndDrawing()
	rl.ClearBackground({0, 0, 0, 255})

	draw_layers()

	draw_on_off_btn()
	draw_increase_temp_btn()
	draw_decrease_temp_btn()
	draw_fan_swap_btn()
	draw_temp()
	draw_wind_symbol()

}

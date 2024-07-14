package main

import "core:fmt"
import "core:os"
import "core:path/filepath"
import "core:strconv"
import "core:strings"
import rl "vendor:raylib"

_ready :: proc() {
	load_sound()

	ac := rl.LoadImage(abs_path("/images/AC.png"))
	tex_ac := rl.LoadTextureFromImage(ac)
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
		rl.PlaySound(di)
		fmt.println(on_off)
	}

	if is_button_pressed(increase_temp_btn) && on_off {
		temp += 1
		rl.PlaySound(di)
		fmt.println(temp)
	}

	if is_button_pressed(decrease_temp_btn) && on_off {
		temp -= 1
		rl.PlaySound(di)
		fmt.println(temp)
	}
}

_draw :: proc() {
	rl.BeginDrawing()
	defer rl.EndDrawing()
	rl.ClearBackground({0, 0, 0, 255})

	draw_layers()

	draw_on_off_btn()
	draw_increase_temp_btn()
	draw_decrease_temp_btn()
	draw_temp()
	draw_wind_symbol()

}

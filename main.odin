package main

import rl "vendor:raylib"

main :: proc() {
	rl.SetTraceLogLevel(.WARNING)
	rl.InitWindow(640, 360, "air-conditioner")
	defer rl.CloseWindow()
	rl.InitAudioDevice()
	defer rl.CloseAudioDevice()

	rl.SetTargetFPS(60)

	_ready()

	for !rl.WindowShouldClose() {
		_update()
		_draw()
	}

	delete(layers)
}

package main

import rl "vendor:raylib"

di: rl.Sound
work, fan: rl.Music

instant_sound: rl.Music

load_sound :: proc() {
	work = rl.LoadMusicStream(abs_path("/audios/ac-work.mp3"))
	fan = rl.LoadMusicStream(abs_path("/audios/air-extractor-fan.mp3"))
	di = rl.LoadSound(abs_path("/audios/di.mp3"))
}

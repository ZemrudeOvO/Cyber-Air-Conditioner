package main

import "core:fmt"
import rl "vendor:raylib"

fan: rl.Music

di: rl.Sound

volume: f32 = 0
volume_delta: f32

load_sound :: proc() {
	data_di := #load("audios/di.mp3")
	wav_di := rl.LoadWaveFromMemory(".mp3", raw_data(data_di[:]), auto_cast len(data_di[:]))
	di = rl.LoadSoundFromWave(wav_di)

	data_fan := #load("audios/fan.mp3")
	fan = rl.LoadMusicStreamFromMemory(".mp3", raw_data(data_fan[:]), auto_cast len(data_fan[:]))
}

play_sound :: proc() {
	if is_button_pressed(on_off_btn) {
		rl.PlaySound(di)
		if on_off {
			rl.PlayMusicStream(fan)
			volume_delta = 0.01
		} else {
			volume_delta = -0.01
		}
	}
	volume += volume_delta
	volume = clamp(volume, 0, 1)
	if volume != 0 && volume != 1 {
		rl.SetMusicVolume(fan, volume)
	}

	if rl.GetMusicTimePlayed(fan) > rl.GetMusicTimeLength(fan) - 2 {
		rl.SeekMusicStream(fan, 2)
	}
	rl.UpdateMusicStream(fan)
}

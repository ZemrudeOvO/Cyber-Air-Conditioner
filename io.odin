package main

import "core:os"
import "core:path/filepath"
import "core:strings"

abs_path :: proc(relative_path: string) -> cstring {
	return strings.clone_to_cstring(
		strings.concatenate([]string{filepath.dir(os.args[0]), relative_path}),
	)
}

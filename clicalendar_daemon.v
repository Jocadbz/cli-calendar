module main

import os
import toml
import time

const (
	nanosecond  = time.Duration(1)
	microsecond = time.Duration(1000 * nanosecond)
	millisecond = time.Duration(1000 * microsecond)
	second      = time.Duration(1000 * millisecond)
	minute      = time.Duration(60 * second)
	hour        = time.Duration(60 * minute)
	infinite    = time.Duration(i64(9223372036854775807))
)



fn main() {
	if os.exists("${os.home_dir()}/.config/cli-calendar/config.toml") == false {
		println("ERROR: It appears you don't have a configuration file.")
		println("Run cli-calendar first to create them.")
	}
	config := toml.parse_file('${os.home_dir()}/.config/cli-calendar/config.toml') or {
		panic(err)
	}
	time_d := config.value('daemon-time').int()
	for {
		toml_reader()
		println("DEBUG: Waiting...")
		time.sleep(time_d * minute)
	}
}


fn toml_reader() {
	files := os.ls('${os.home_dir()}/.config/cli-calendar/events/') or { panic(err) }
	date_command := os.execute("date +%d/%m/%Y")
	if files.len == 0 {
		println("DEBUG: No files.")
	} else {
		println('DEBUG: Events loading...')
		for f in files {
			event := toml.parse_file('${os.home_dir()}/.config/cli-calendar/events/${f}') or {
				panic(err)
			}
			name := event.value('event.name').string()
			date := event.value('event.date').string()
			if date == date_command.output.replace('\n', '') {
				os.system("notify-send 'Calendar Notification' 'Your event, ${name}, ends today!' -i calendar -a Calendar")
			}
		}
	}
}
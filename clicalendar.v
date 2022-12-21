module main

import os
import toml
import cli

fn main() {
	check()
	mut app := cli.Command{
		name: 'cli-calendar'
		description: 'A simple CLI calendar'
		version: '1.0.0'
		execute: fn (cmd cli.Command) ! {
			time()
			return
		}
		commands: [
			cli.Command{
				name: 'create'
				description: 'Creates a event'
				execute: fn (cmd cli.Command) ! {
					create_event()
					return
				}
			},
			cli.Command{
				name: 'remove'
				description: 'Removes a event'
				execute: fn (cmd cli.Command) ! {
					remove_event()
					return
				}
			},
		]
	}
	app.setup()
	app.parse(os.args)
}

fn check() {
	config := '${os.home_dir()}/.config/cli-calendar/'
	if os.exists(config) == false {
		println('Creating config files...')
		os.mkdir_all('${config}/events/') or { panic(err) }
		os.create("${config}/config.toml") or { panic(err) }
		toml := "
daemon-time = 60
"
		os.write_file('${os.home_dir()}/.config/cli-calendar/config.toml', toml) or {
			panic(err)
		}
		println('Done!')
		exit(0)
	}
}

fn time() {
	whoami := os.execute('whoami')
	date_command := os.execute("date +%d/%m/%Y")
	println('Hello ${whoami.output}')
	println("Today is ${date_command.output}")
	files := os.ls('${os.home_dir()}/.config/cli-calendar/events/') or { panic(err) }
	if files.len == 0 {
		println('You have no events.')
	} else {
		println('Here are your events:')
		println('')
		for f in files {
			event := toml.parse_file('${os.home_dir()}/.config/cli-calendar/events/${f}') or {
				panic(err)
			}
			name := event.value('event.name').string()
			date := event.value('event.date').string()
			println('${name}')
			println('Due to: ${date}')
			println('')
		}
	}
}

fn create_event() {
	name := os.execute('zenity --entry --text="Enter the event name"')
	date := os.execute('zenity --calendar --text="Set the event date"')
	name_d := name.output.replace('\n', '')
	date_d := date.output.replace('\n', '')
	toml := "[event]
name = '${name_d}'
date = '${date_d}'
"
	os.write_file("${os.home_dir()}/.config/cli-calendar/events/${name.output.replace('\n', '')}.toml", toml) or {
		panic(err)
	}
}

fn remove_event() {
	event := os.input('Enter the event name: ')
	path := '${os.home_dir()}/.config/cli-calendar/events/${event}.toml'
	if os.exists(path) == true {
		os.rm(path) or { panic(err) }
		println('Event removed.')
	} else {
		println("This event doesn't seem to exist...")
		exit(1)
	}
}

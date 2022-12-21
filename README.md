# CLI Calendar
A simple event manager calendar

### Usage
Run `cli-calendar` to create the config files, if they yet don't exist. You can create and remove them as you wish.
The `cli-calendar_daemon` checks your events and if any of they match the day you are, it sends a notification warning you.

### Configuration
- config.toml
```toml
daemon-time = 60 # The amount of time (in minutes) the daemon takes to check your events again - Default: 60
```

### Using the daemon
Just add `clicalendar_daemon` to your autostart files, or in your window manager config files.
If you want to kill the daemon, you can use `killall` command:
```bash
killall clicalendar_daemon
```

### Dependencies
- GNU date
- GNU whoami
- libnotify

### Installing from source
```bash
# You need the V compiler
git clone https://gitlab.com/Jocadbz/cli-calendar
cd cli-calendar
v .
```


### Inspiration
Gnome calendar fucking sucks.
That's the whole ass reason why I did that. It's heavy, slow, and I prefer CLI anyway.
I could've used `cal` too, but it doesn't support events.

So I created this, a simple cli-based event manager.



*Made in V, btw*
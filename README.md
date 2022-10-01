# CLI Calendar
A simple event manager calendar

### Usage
```
Usage: cli-calendar [flags] [commands]

A simple CLI calendar

Flags:
  -help               Prints help information.
  -version            Prints version information.
  -man                Prints the auto-generated manpage.

Commands:
  create              Creates a event
  remove              Removes a event
  help                Prints help information.
  version             Prints version information.
  man                 Prints the auto-generated manpage.
```


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
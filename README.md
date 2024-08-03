# rsync.yazi

A [yazi](https://yazi-rs.github.io/) plugin for simple rsync use

## Installation

```sh
ya pack -a GianniBYoung/rsync
```

## Usage

Add the binds to your `~/.config/yazi/keymap.toml`

WARNING: Make sure the chosen binding isn't already in use!!

```toml
[[manager.prepend_keymap]]
on   = "R"
run  = "plugin rsync"
desc = "Copy files using rsync"
```

### Advanced Usage (wip)

The following flags are available for use:

- `--rsync-args` supply standard rsync flags
- `--default-destination` set a default remote target (user can optionally be included)

```toml
[[manager.prepend_keymap]]
on   = "R"
run  = "plugin rsync --rsync-args '--no-motd' --default-destination 'user@server.com'"
desc = "Advanced Copy files using rsync"
```

## Troubleshooting

Basic logging information is sent to `~/.local/state/yazi/yazi.log`

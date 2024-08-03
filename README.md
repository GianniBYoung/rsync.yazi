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

### Specify Default Remote Server

```toml
[[manager.prepend_keymap]]
on   = "R"
run  = "plugin rsync --args='user@server.com'"
desc = "Copy files using rsync to default location"
```

## Troubleshooting

Basic logging information is sent to `~/.local/state/yazi/yazi.log`

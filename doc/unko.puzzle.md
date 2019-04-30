# unko.puzzle

sliding block puzzle

## Requirements

- X11
    - XQuartz (macOS)
- xterm

## Additional installation

### Linux

#### With `yum` (RHEL compatible distros)

* Enable epel repository

(skip)

* Install xdotool

```sh
$ sudo yum install xdotool
```

#### With `apt` (Debian base distros)

```sh
$ sudo apt install xdotool
```

### macOS

#### With Homebrew

```sh
$ brew cask install xquartz
$ brew install xdotool
```

## Usage

### Linux

1. Launch xterm.
1. Run `unko.puzzle` on xterm.
1. Enjoy!

### macOS

1. Launch xterm.
    ```sh
    $ PATH=$PATH:/opt/X11/bin xterm &
    ```sh
1. Run `unko.puzzle` on xterm.
    ```sh
    $ unko.puzzle
    ```
1. Enjoy!

## for development

- tile map

```
+-+-+-+
|x|1|2|
+-+-+-+
|3|4|5|
+-+-+-+
|6|7|8|
+-+-+-+
```

- debug

```sh
$ DEBUG_UNKO=true TILES=2 unko.puzzle 2>>/tmp/unko.log
```

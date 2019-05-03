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
    ```
1. Run `unko.puzzle` on xterm.
    ```sh
    $ unko.puzzle
    ```
1. Enjoy!

---

```
Warning: XTEST extension unavailable on '(null)'.
Some functionality may be disabled; See 'man xdotool' for more info.
```

If you received such a message from xdotool, you may be able to resolve it by execute the following commands and restarting XQuartz:

```sh
$ defaults write org.x.X11 enable_test_extensions -boolean true
$ defaults write org.macosforge.xquartz.X11 enable_test_extensions -boolean true
```

See: https://stackoverflow.com/questions/1264210/does-mac-x11-have-the-xtest-extension

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

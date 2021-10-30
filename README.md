# exchange.kak

**exchange.kak** provides a handy command to exchange two selections.


## Installation

### With [plug.kak](https://github.com/andreyorst/plug.kak)

Add this to the `kakrc`:
``` kak
plug "harryoooooooooo/exchange.kak"
```
Then reload the configuration file or restart Kakoune and run `:plug-install`.

### Without plugin manager

This plugin has only one source file. `source`ing it in `kakrc` just works:

``` kak
source "/path/to/exchange.kak/rc/exchange.kak"
```


## Usage

Type `:exchange<ret>` to mark the current selection.
Move to the second selection and type `:exchange<ret>` again -- the two selections exchanged.

To clear the mark, type `:exchange clear<ret>`.

It's recommended to map shortcuts for them with:
``` kak
plug "harryoooooooooo/exchange.kak" config %{
    map global user x ':exchange<ret>'
    map global user <a-x> ':exchange clear<ret>'
}
```
Or at any other place in `kakrc` add:
``` kak
map global user x ':exchange<ret>'
map global user <a-x> ':exchange clear<ret>'
```

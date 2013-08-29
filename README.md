### dzen-pandora

To install, you must first install the greasemonkey/tampermonkey
script which will connect to the ruby server.  If you have one of these plugins installed,
you can install the Pandora hook by
[clicking here](https://github.com/jeremyaburns/dzen-pandora/raw/master/PandoraHook.user.js).

The ruby script acts as a local http server on port 1338 in order to
communicate with the greasemonkey script, and it outputs a dzen formatted
string to stdout.

The clickable buttons on the bar require getting the latest
version of dzen from SVN and building from source:

```shell
svn checkout http://dzen.googlecode.com/svn/trunk/ dzen-source
```

Example usage in *xmonad.hs*:
```haskell
main = do
    _ <- spawn "ruby ~/.xmonad/dzen-pandora/dzen-pandora.rb | dzen2"
    xmonad defaultConfig
```

![Screenshot](https://raw.github.com/jeremyaburns/dzen-pandora/master/screen1.png)

![Screenshot](https://raw.github.com/jeremyaburns/dzen-pandora/master/screen2.png)

TODO:
- Song progress display.
- Support for old versions of dzen by disabling the buttons.
- Better handling of missing Pandora connection.

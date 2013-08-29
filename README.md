### dzen-pandora

To install, you must first install the tampermonkey/greasemonkey
script which will connect to the ruby server.  In chrome + tampermonkey,
you can install it by
[clicking here](https://github.com/jeremyaburns/dzen-pandora/raw/master/PandoraHook.tamper.js).

The ruby script acts as a local http server on port 1338 in order to
communicate with the tampermonkey script, and it outputs a dzen formatted
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


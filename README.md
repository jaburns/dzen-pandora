dzen-pandora
============

Some scripts to create a dzen bar which controls Pandora.

Example usage in *xmonad.hs*
```haskell
main = do
    _ <- spawn "ruby ~/.xmonad/dzen-pandora/dzen-pandora.rb | dzen2"
    xmonad defaultConfig
```


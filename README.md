# Various scripts I use

## Utility Scripts
### change-primary-resolution
Creates a new `xrandr` mode for the specified resolution and sets the primary display to use that mode
```
# Usage: ./change-primary-resolution X Y
#  X: Desired horizontal resolution (multiple of 8)
#  Y: Desired vertical resolution
```

### synchronize-dir
A simplified wrapper for rsync. Lists the files/directories to be changed, and prompts y/n before performing the sync. This is meant for synchronizing my home directory between different virtual machines so the local and remote directory paths must be identical.
`# Usage: ./synchronize-dir directory user@remote_host`


## Installation/Setup Scripts

### set-hostname
Does everything needed to properly change the hostname. Run it as root.
`# Usage: ./set-hostname from to`

### install-software
Installs all the `apt` packages I use. Run it as root.
`# Usage: ./install-software`

### setup-user
Downloads my theme and sets up various tools/packages.
`# Usage: ./setup-user`

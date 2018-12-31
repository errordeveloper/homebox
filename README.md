# homebox: a custom Linux build for NAS and media at home


## Features

- Plex Media Server
- Dropbox
- Transmission
- (todo) other apps and storage management

## Ideas

- run dockerd with SSH auth
- use ZFS to manage disks, allow for testing in dev
- make logs and status easily accessible

## Development

1. Create `metadata.json`:
```JSON
{
  "plex": {
    "entries": {
      "timezone": {
        "perm": "0600",
        "content": "Europe/London"
      },
      "plex_claim": {
        "perm": "0600",
        "content": "<secret>"
      }
    }
  }
}
```

2. `make image`
3. `./run.sh`

We have to use `vmnet` here to allow for access to Plex Media Server.
However, that only makes it accessible on a local bridge, not on the whole
network. So the easiet way to test is to connect via desktop version of the
Plex Media Player, as opposed to a TV or mobile app.

LinuxKit generates new names for each of the VMs, so until we make a call on
weather that needs "fixing", each VM appears like a new server in Plex console.

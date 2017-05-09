This file represents a bash script ( Yes, in nix* the extension is just cosmetic )
that can install a "World of Warcraft" game server in the folder chosen.
The script is designed to install the WoW server on a fresh Ubuntu
system ( Tested on virtualBOX 14.04 LTS OK ). To use this you must put it in a
folder of choice and make it executable using

``` sudo chmod +x config.sh ```

Here are example commands currently available:

```
  ./config.sh start              --> Starts the installed server
  ./config.sh install            --> Installs the sever in the folder chosen
  ./config.sh drop-mangos        --> Removes the mangos database from the SQL server
  ./config.sh purge-mysql-server --> Completely removes the SQL server installed in dependencies
  ./config.sh config             --> Not developed currently. It edits the server configuration
  ./config.sh stats              --> Displays the private server paths used by the installation
```

It will ask you series of questions in the process for proxy, dependencies and so on.
The script is designed to be automatic, so there is no need to change anything manually !!!
After the installation finishes, it will say "Enjoy your DB". Then you must extract the
client maps and vmaps as it's shown here ( search for /maps,vmaps/ on the page )

https://github.com/cmangos/issues/wiki/Installation-Instructions

After you are done with that process ( Which takes very long, so grab you
favorite movie and some popcorn ) you can start it like so:

``` sudo ./config.sh start ```

I made it universal, because I prefer my servers to be in ``` etc/var/srv/.. ``` , but you might
not prefer them there. Currently only the Vanilla, TBC and WoTLK servers are done, the others are
just options that can available in the future

Have fun with my installation script ;)

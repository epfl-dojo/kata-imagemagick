#!/bin/sh

[ -d images/gallery ] || mkdir -p images/gallery

cd images
# curl -o OriginalWarhol.jpg http://quintessentially.com/assets/noted/01_8.jpg
curl -o --progress-bar MarilynMonroe.jpg https://upload.wikimedia.org/wikipedia/commons/4/46/Marilyn_Monroe_in_1952_TFA.jpg

cd gallery
curl -LOJ --progress-bar "https://unsplash.com/photos/96--kK-c5KY/download?force=true"
curl -LOJ --progress-bar "https://unsplash.com/photos/ISqTudqZERQ/download?force=true"
curl -LOJ --progress-bar "https://unsplash.com/photos/tXpD84c8ZwI/download?force=true"
curl -LOJ --progress-bar "https://unsplash.com/photos/iHXO2bccJcw/download?force=true"
curl -LOJ --progress-bar "https://unsplash.com/photos/HOWfdzh1Q0g/download?force=true"
curl -LOJ --progress-bar "https://unsplash.com/photos/rvMXPHXpdeI/download?force=true"
curl -LOJ --progress-bar "https://unsplash.com/photos/QDPnhYAS0xA/download?force=true"
curl -LOJ --progress-bar "https://unsplash.com/photos/KAlqieElnpc/download?force=true"
curl -LOJ --progress-bar "https://unsplash.com/photos/dB8hFMYTT9U/download?force=true"
curl -LOJ --progress-bar "https://unsplash.com/photos/wUa5QIuKnno/download?force=true"
curl -LOJ --progress-bar "https://unsplash.com/photos/h_-JUPC_B6w/download?force=true"


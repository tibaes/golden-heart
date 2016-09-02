#!/bin/bash

aptitude update
aptitude install -y julia

echo -e "#!/bin/bash\njupyter notebook --no-browser --certfile=/root/mycert.pem --keyfile=/root/mykey.key" >> /root/ijulia.sh
chmod +x /root/ijulia.sh

julia -e 'Pkg.add("Images")'
julia -e 'Pkg.add("ImageMagick")'
julia -e 'Pkg.add("IJulia")'
julia -e 'Pkg.build("IJulia")'

docker ps -a | awk '{ print $1,$2 }' | grep eiffel_deliv | awk '{print $1 }' | xargs -I {} echo docker rm {}

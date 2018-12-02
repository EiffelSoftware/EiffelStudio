docker-compose build
docker-compose up
see inside var/deliv-output/ folder for the .tar.bz2 file (and also the PorterPackage.tgz).
Note: if you leave the PorterPackage.tgz, it will be reused by the docker execution.


For 32bits, quite similar:
docker-compose -f docker-compose-32bits.yml build
docker-compose -f docker-compose-32bits.yml up


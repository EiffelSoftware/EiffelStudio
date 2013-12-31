#!/bin/sh

#CONTROLLERS=$(ls controllers/)
CONTROLLERS=(memory.e) 
# CONTROLLERS=(mysql.e) 

for ctrl in ${CONTROLLERS[@]}; do
	rm -r ./framework/EIFGENs
	rm ./framework/controller.e
	cp ./controllers/$ctrl ./framework/controller.e
	
	cd framework
	ec -finalize -config framework.ecf
	cd EIFGENs/framework/F_code
	finish_freezing
	cd ../../..
	./EIFGENs/framework/F_code/framework
	cd ..
done


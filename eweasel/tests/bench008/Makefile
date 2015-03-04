all: main
	./main -i main.in > main.out
	diff main.out main.gold

main: main.e comparator.e parfor_worker.e
	ec -config main.ecf -target main -finalize -c_compile;
	cp EIFGENs/main/F_code/main .


allw: mainw
	./mainw -i main.in > mainw.out
	diff mainw.out main.gold

mainw: main.e comparator.e parfor_worker.e
	ec -config main.ecf -target main -c_compile;
	cp EIFGENs/main/W_code/main mainw

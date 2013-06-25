all: main
	./main -i main.in > main.out
	diff main.out main.gold

main: main.e comparator.e
	ec -config main.ecf -target main -finalize -c_compile;
	cp EIFGENs/main/F_code/main .
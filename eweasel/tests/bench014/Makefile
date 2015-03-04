all: main
	./main -i main.in > main.out
	diff main.out main.gold
	./main -i main2.in > main2.out
	diff main2.out main2.gold
	./main -i main3.in > main3.out
	diff main3.out main3.gold
	./main -i main4.in > main4.out
	diff main4.out main4.gold

main: main.e value3_comparator.e parfor_worker.e
	ec -config main.ecf -target main -finalize -c_compile;
	cp EIFGENs/main/F_code/main .

allw: mainw
	./mainw -i main.in > main.out
	diff main.out main.gold
	./mainw -i main2.in > main2.out
	diff main2.out main2.gold
	./mainw -i main3.in > main3.out
	diff main3.out main3.gold
	./mainw -i main4.in > main4.out
	diff main4.out main4.gold


mainw: main.e value3_comparator.e parfor_worker.e
	ec -config main.ecf -target main -c_compile;
	cp EIFGENs/main/W_code/main mainw


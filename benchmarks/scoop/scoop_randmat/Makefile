SRC =  main.e randmat_parfor_worker.e 

all: main
	./main -i main.in
	./main -i main2.in
	./main -i main3.in
	./main -i main4.in
	./main -i main5.in
	./main -i main5.in -e is_bench 

main: main.e $(SRC)
	ec -config main.ecf -target main -finalize -c_compile;
	cp EIFGENs/main/F_code/main .

mainw: main.e $(SRC)
	ec -config main.ecf -target main -c_compile;
	cp EIFGENs/main/W_code/main mainw


clean:
	@rm -rf EIFGENs

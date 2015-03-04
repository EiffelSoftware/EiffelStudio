all: main
	./main -i main.in
	./main -i main2.in
	./main -i main3.in
	./main -i main4.in
	./main -i main5.in
	./main -i main6.in
#./main -i main7.in

main: main.e reduce2d_worker.e parfor_worker.e
	ec -config main.ecf -target main -finalize -c_compile;
	cp EIFGENs/main/F_code/main .

worktest: mainw
	./mainw -i main.in
	./mainw -i main2.in
	./mainw -i main3.in
	./mainw -i main4.in
	./mainw -i main5.in
	./mainw -i main6.in
#./main -i main7.in

mainw: main.e reduce2d_worker.e parfor_worker.e
	ec -config main.ecf -target main -c_compile;
	cp EIFGENs/main/W_code/main mainw

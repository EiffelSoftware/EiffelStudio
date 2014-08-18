all: application.e
	ecqs mutex.ecf mutex

final: application.e
	ec -config mutex.ecf -target mutex -c_compile -finalize

clean:
	@rm -rf EIFGENs

all: application.e
	ecqs  prodcons.ecf prodcons

stock: application.e
	ec -config prodcons.ecf -target prodcons -c_compile -finalize


clean:
	@rm -rf EIFGENs

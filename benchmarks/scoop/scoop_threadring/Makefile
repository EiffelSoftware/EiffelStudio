.PHONY: all clean

all: application.e threadring_worker.e
	ecqs threadring.ecf threadring

stock: application.e
	ec -config threadring.ecf -target threadring -c_compile -finalize

clean:
	@rm -rf EIFGENs

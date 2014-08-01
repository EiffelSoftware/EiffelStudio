.PHONY: all clean stock

all: application.e chameneos.e
	ecqs chameneos.ecf chameneos

stock:
	ec -config chameneos.ecf -target chameneos -c_compile -finalize

clean:
	@rm -rf EIFGENs

CC = gcc

io_watcher.o: io_watcher.c
	$(CC) -c io_watcher.c -I$(ISE_EIFFEL)/bench/spec/$(ISE_PLATFORM)/include `glib-config --cflags`
	mkdir -p ../spec/$(ISE_PLATFORM)/lib
	mv io_watcher.o ../spec/$(ISE_PLATFORM)/lib

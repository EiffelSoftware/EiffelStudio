class 
	RACE
inherit
	THREAD_CONTROL

create
	make

feature

	io_mutex: MUTEX

	make is
		local
			n, thread_count, nb_loop: INTEGER
			r: RUNNER
		do
			create io_mutex
			io_mutex.lock
			io.putstring ("** Thread race%N** -----------%N")
			io.putstring ("** # of racers: ")
			io.readint
			n := io.lastint
			io.putstring ("** length of race: ")
			io.readint
			nb_loop := io.lastint
			io.put_string ("** Race started! %N")
			io_mutex.unlock

			from
				thread_count := 1
			until
				thread_count > n
			loop
				create r.make (io_mutex, thread_count, nb_loop)
				r.launch
				thread_count := thread_count + 1
			end

			r := void

			io_mutex.lock
			io.put_string("%N** All runners started%N")
			io_mutex.unlock
			join_all
		end

end -- class RACE


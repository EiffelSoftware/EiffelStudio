indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class RACE



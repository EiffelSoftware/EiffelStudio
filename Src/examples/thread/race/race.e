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


--|----------------------------------------------------------------
--| EiffelThread: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


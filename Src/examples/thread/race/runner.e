class 
	RUNNER
inherit
	THREAD

create
	make

feature {NONE} -- Initialization

	make (io_m: MUTEX; i: INTEGER; n: INTEGER) is
		require
			io_m_not_void: io_m /= Void
			valid_i: i > 0
			valid_n: n > 0
		do
			io_mutex := io_m
			id := i
			nb_loop := n
		end


feature {NONE} -- Implementation

	io_mutex: MUTEX

	id, nb_loop: INTEGER

	execute is
		local
			i, cpt: INTEGER
		do
			from
				cpt := 1
			until
				cpt > nb_loop
			loop
				io_mutex.lock
				io.print (cpt)
				io.print ("|")
				from 
					i := 0
				until
					i > cpt
				loop
					print ("-")
					i := i + 1
				end
				io.putint(id)
				io.putstring("%N")
				io_mutex.unlock
				cpt := cpt + 1
			end
		end

end  -- class RUNNER

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
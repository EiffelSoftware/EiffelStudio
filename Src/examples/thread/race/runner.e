note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	RUNNER

inherit
	THREAD
		rename
			make as thread_make
		end

create
	make

feature {NONE} -- Initialization

	make (io_m: MUTEX; i: INTEGER; n: INTEGER)
		require
			io_m_not_void: io_m /= Void
			valid_i: i > 0
			valid_n: n > 0
		do
			thread_make
			io_mutex := io_m
			id := i
			nb_loop := n
		end


feature {NONE} -- Implementation

	io_mutex: MUTEX

	id, nb_loop: INTEGER

	execute
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

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end  -- class RUNNER


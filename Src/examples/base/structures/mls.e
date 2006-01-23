indexing

	description: "Demo class for linked sets. %
		% Only one routine to display the set is added %
		% The generic parameter is INTEGER."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class 
	MLS

inherit
	LINKED_SET [INTEGER] 

create
	make

feature

	display is
		do
			io.set_error_default
			from
				start
			until
				exhausted
			loop
				io.putchar (' ')
				io.putint (item)
				forth
			end
			io.putchar ('%N')
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


end -- class MLS


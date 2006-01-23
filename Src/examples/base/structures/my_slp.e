indexing

	description: "Demo class for SLP_QUEUE %
		% Only one feature added: display"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class MY_SLP 

inherit
	LINKED_PRIORITY_QUEUE [INTEGER]
		rename
			make as lpq_make
		end

create
	make

feature -- Creation

	make is
		do
			io.set_error_default
			lpq_make
		end

feature -- Routine

	display is
		do
			from
				start
			until
				offright
			loop
				io.putint (sorted_list_item.item)
				io.putstring (" ")
				forth
			end
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


end -- class MY_SLP


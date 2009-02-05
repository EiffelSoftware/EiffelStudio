note

	description:
		"Message transmitted in the advanced example."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class MESSAGE

inherit
	LINKED_LIST [STRING]
		redefine
			make
		end

	STORABLE
		undefine
			is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			Precursor
			create client_name.make_empty
			extend ("-> ")
		end

feature

	new: BOOLEAN

	over: BOOLEAN

	client_name: STRING

	set_client_name (s: STRING)
		require
			s_not_void: s /= Void
		do
			client_name := s.twin
		end

	set_over (flag: BOOLEAN)
		do
			over := flag
		end

	set_new (flag: BOOLEAN)
		do
			new := flag
		end

	print_message
			-- Prints the contents of the message to standard output
		do
			from
				start
			until
				after
			loop
				io.putstring (item)
				forth
			end
		end


note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class MESSAGE


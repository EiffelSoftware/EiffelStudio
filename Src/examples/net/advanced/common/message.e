indexing

	description:
		"Message transmitted in the advanced example."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class MESSAGE

inherit

	STORABLE
		undefine
			copy,
			is_equal
		end

	LINKED_LIST [STRING]

create

	make_message

feature

	new: BOOLEAN

	over: BOOLEAN

	client_name: STRING

	make_message is
		do
			make
			extend ("-> ")
		end

	set_client_name (s: STRING) is
		require
			s_not_void: s /= Void
		do
			client_name := s.twin
		end

	set_over (flag: BOOLEAN) is
		do
			over := flag
		end

	set_new (flag: BOOLEAN) is
		do
			new := flag
		end

	print_message is
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


end -- class MESSAGE


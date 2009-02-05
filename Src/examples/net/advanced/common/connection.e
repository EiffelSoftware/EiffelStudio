note

	description:
		"Describe a connection for the advanced example."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class CONNECTION

inherit
	POLL_COMMAND
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (s: IO_MEDIUM)
		do
			Precursor (s)
			create client_name.make_empty
		end

feature

	is_waiting: BOOLEAN

	client_name: STRING

	execute (arg: ANY)
		do
			is_waiting := True
		end

	initialize
		do
			is_waiting := False
		end

	set_client_name (s: STRING)
		require
			s_exists: s /= Void
		do
			client_name := s.twin
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


end -- class CONNECTION


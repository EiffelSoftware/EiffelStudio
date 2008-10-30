indexing

	description:
		"Describe a connection for the advanced example."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class CONNECTION

inherit

	POLL_COMMAND

create

	make

feature

	is_waiting: BOOLEAN

	client_name: STRING

	execute (arg: ANY) is
		do
			is_waiting := True
		end

	initialize is
		do
			is_waiting := False
		end

	set_client_name (s: STRING) is
		require
			s_exists: s /= Void
		do
			client_name := s.twin
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


end -- class CONNECTION


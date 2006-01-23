indexing
	description	: "Implement an help context as a string."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords	: "help"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_SIMPLE_HELP_CONTEXT

inherit
	EV_HELP_CONTEXT
		undefine
			is_equal,
			out,
			copy
		end
	
	STRING

create
	make_from_string
	
create {EV_SIMPLE_HELP_CONTEXT}
	make

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




end -- class EV_SIMPLE_HELP_CONTEXT


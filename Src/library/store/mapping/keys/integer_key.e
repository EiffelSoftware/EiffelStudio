indexing
	description: ""
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "David Solal"
	date: "$ Date: "
	revision: "$ Revision: "

class
	INTEGER_KEY

inherit
	BASIC_KEY
		redefine
			item
		end

create
	make

feature -- Access

	item : INTEGER_REF;

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




end -- class INTEGER_KEY



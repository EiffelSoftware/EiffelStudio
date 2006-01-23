indexing
	
	description: "This class can be used as a%
		%scrollable_element in scrollable_list."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	SCROLLABLE_LIST_STRING_ELEMENT

inherit

	STRING

	SCROLLABLE_LIST_ELEMENT
		undefine
			copy,
			out,
			is_equal
		end

create
	make,
	make_from_string

feature -- Access

	value: STRING is
			-- String to appear in scrollable list box
		do
			Result := Current
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




end -- class SCROLLABLE_LIST_STRING_ELEMENT


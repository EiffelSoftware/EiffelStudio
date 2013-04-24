note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_C_STRING

inherit
	C_STRING
		rename
			set_string as set_with_eiffel_string,
			make_by_pointer as make_from_pointer
		redefine
			set_with_eiffel_string
		end

create
	set_with_eiffel_string, make_from_pointer, share_from_pointer

convert
	set_with_eiffel_string ({STRING_GENERAL, STRING, STRING_32})

feature -- Status setting

	set_with_eiffel_string (a_string: STRING_GENERAL)
			-- Set `string' with `a_string'.
		do
			if managed_data = Void then
				make_empty (0)
			end
			Precursor (a_string)
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




end -- class EV_GTK_C_STRING


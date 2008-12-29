note
	description: "Formatting element that consists of a constant string"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_USERSTRING_ELEMENT

inherit
	I18N_FORMATTING_ELEMENT

create
	make

feature {I18N_FORMAT_STRING_PARSER} -- Initialization

	make (a_string: STRING_32)
			-- set the `user_string'
		do
			user_string := a_string
		end

feature -- Output

	filled (a_date: DATE; a_time: TIME): STRING_32
 			-- Return the `user_string'
 		do
			Result := user_string
 		end

feature {NONE} -- Implementation

	user_string: STRING_32

invariant
	correct_user_string: user_string /= Void

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

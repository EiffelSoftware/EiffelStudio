indexing
	description: "String Manipulator"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	MY_STRING_MANIPULATOR

inherit
	STRING_MANIPULATOR_PROXY
		redefine
			replace_substring_user_precondition
		end

create
	make,
	make_from_other,
	make_from_pointer

feature -- Status Report

	replace_substring_user_precondition (s: STRING; start_pos: INTEGER; end_pos: INTEGER): BOOLEAN is
			-- User-defined preconditions for `replace_substring'.
			-- Uncomment the last line to test precondition violations in the server.
		do
			Result := start_pos <= end_pos and
					start_pos > 0
			-- Result := True
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


end -- MY_STRING_MANIPULATOR


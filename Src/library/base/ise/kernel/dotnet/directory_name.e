
indexing

	description:
		"Directory name abstraction"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DIRECTORY_NAME

inherit
	PATH_NAME

create
	make, make_from_string

create {DIRECTORY_NAME}
	string_make

feature

	is_valid: BOOLEAN is
			-- Is the directory name valid?
		do
			Result := True
		end

feature {NONE} -- Implementation

	new_string (n: INTEGER): like Current is
			-- New instance of current with space for at least `n' characters.
		do
			create Result.string_make (n)
		end
		
indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class DIRECTORY_NAME




indexing

	description:
		"The objects available from the operating system"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class OPERATING_ENVIRONMENT

feature

	Directory_separator: CHARACTER is
			-- Character used to separate subdirectories in a path name on this platform.
			--| To build portable path names, use PATH_NAME and its descendants.
		local
			l_a: PATH
		once
			Result := l_a.directory_separator_char
		end

	Current_directory_name_representation: STRING is "."
			-- Representation of the current directory.

	home_directory_supported: BOOLEAN is False
			-- Is the notion of home directory supported on this platform?

	root_directory_supported: BOOLEAN is True
			-- Is the notion of root directory supported on this platform?

	case_sensitive_path_names: BOOLEAN is False;
			-- Are path names case sensitive?
			
	--| FIXME IEK There seems to be a parsing bug that doesn't allow the file to be saved without
	--| the semi-colon on case_sensitive_path_names.

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



end -- class OPERATING_ENVIRONMENT



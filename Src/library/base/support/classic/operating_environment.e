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
		once
			Result := c_dir_separator
		end

	Current_directory_name_representation: STRING is
			-- Representation of the current directory
		once
			Result := eif_current_dir_representation
		end

	home_directory_supported: BOOLEAN is
			-- Is the notion of home directory supported on this platform?
		external
			"C use %"eif_path_name.h%""
		alias
			"eif_home_dir_supported"
		end

	root_directory_supported: BOOLEAN is
			-- Is the notion of root directory supported on this platform?
		external
			"C use %"eif_path_name.h%""
		alias
			"eif_root_dir_supported"
		end

	case_sensitive_path_names: BOOLEAN is
			-- Are path names case sensitive?
		external
			"C use %"eif_path_name.h%""
		alias
			"eif_case_sensitive_path_names"
		end

feature {NONE} -- Implementation

	c_dir_separator: CHARACTER is
		external
			"C use %"eif_dir.h%""
		alias
			"eif_dir_separator"
		end

	eif_current_dir_representation: STRING is
		external
			"C use %"eif_path_name.h%""
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







end -- class OPERATING_ENVIRONMENT



indexing

	description:
		"The objects available from the operating system"

	status: "See notice at end of class"
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
			"C | %"eif_path_name.h%""
		alias
			"eif_home_dir_supported"
		end

	root_directory_supported: BOOLEAN is
			-- Is the notion of root directory supported on this platform?
		external
			"C | %"eif_path_name.h%""
		alias
			"eif_root_dir_supported"
		end

	case_sensitive_path_names: BOOLEAN is
			-- Are path names case sensitive?
		external
			"C | %"eif_path_name.h%""
		alias
			"eif_case_sensitive_path_names"
		end

feature {NONE} -- Implementation

	c_dir_separator: CHARACTER is
		external
			"C | %"eif_dir.h%""
		alias
			"eif_dir_separator"
		end

	eif_current_dir_representation: STRING is
		external
			"C | %"eif_path_name.h%""
		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class OPERATING_ENVIRONMENT



indexing

	description:
		"The objects available from the operating system";

	status: "See notice at end of class";
	date: "$Date$";
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
			"C | <path_name.h>"
		alias
			"eif_home_dir_supported"
		end

	root_directory_supported: BOOLEAN is
			-- Is the notion of root directory supported on this platform?
		external
			"C | <path_name.h>"
		alias
			"eif_root_dir_supported"
		end

	case_sensitive_path_names: BOOLEAN is
			-- Are path names case sensitive?
		external
			"C | <path_name.h>"
		alias
			"eif_case_sensitive_path_names"
		end

feature {NONE} -- Implementation

	c_dir_separator: CHARACTER is
		external
			"C | <dir.h>"
		alias
			"eif_dir_separator"
		end

	eif_current_dir_representation: STRING is
		external
			"C | <path_name.h>"
		end

end -- class OPERATING_ENVIRONMENT

--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

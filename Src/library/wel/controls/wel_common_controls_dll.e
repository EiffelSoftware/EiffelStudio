indexing
	description: "This class is used to load the common controls dll."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COMMON_CONTROLS_DLL

inherit
	WEL_DLL
		rename
			make as dll_make
		end

create
	make

feature
	make is
			-- Load the common controls DLL.
		do
			make_permanent (common_controls_dll_name)
		end

feature {NONE} -- Implementation

	common_controls_dll_name: STRING is "comctl32.dll"
			-- Name of the common controls DLL

end -- class WEL_COMMON_CONTROLS_DLL

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------


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

creation
	make

feature
	make is
			-- Load the common controls DLL.
		do
			dll_make (common_controls_dll_name)
		end

feature {NONE} -- Implementation

	common_controls_dll_name: STRING is "comctl32.dll"
			-- Name of the common controls DLL

end -- class WEL_COMMON_CONTROLS_DLL


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


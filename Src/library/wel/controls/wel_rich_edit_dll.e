indexing
	description: "This class is used to load the rich edit control %
		%dll. See class WEL_RICH_EDIT."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RICH_EDIT_DLL

inherit
	WEL_DLL
		rename
			make as dll_make
		end

creation
	make

feature
	make is
			-- Load the rich edit DLL.
		do
			dll_make (rich_edit_dll_name)
		end

feature {NONE} -- Implementation

--	rich_edit_dll_name: STRING is "riched20.dll"
	rich_edit_dll_name: STRING is "riched32.dll"
			-- Name of the rich edit DLL
	

end -- class WEL_RICH_EDIT_DLL


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


indexing

	description: "Hkey registry open access mode constants"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	WEL_REGISTRY_ACCESS_MODE

feature -- Access

	Key_query_value: INTEGER is 1
			-- Permission to query subkey data. 

	Key_set_value: INTEGER is 2
			-- Permission to set subkey data. 

	Key_create_sub_key: INTEGER is 4
			-- Permission to create subkeys. 

	Key_enumerate_sub_keys: INTEGER is 8
			-- Permission to enumerate subkeys. 

	Key_notify: INTEGER is 16
			-- Permission for change notification. 

	Key_create_link: INTEGER is 32
			-- Permission to create a symbolic link.

end -- class WEL_REGISTRY_ACCESS_MODE

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


indexing
	description: "Hkey registry open access mode constants"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	WEL_REGISTRY_ACCESS_MODE

feature -- Access

	Key_create_link: INTEGER is
			-- Permission to create a symbolic link.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_CREATE_LINK"
		end
		
	Key_create_sub_key: INTEGER is
			-- Permission to create subkeys.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_CREATE_SUB_KEY"
		end
		
	Key_enumerate_sub_keys: INTEGER is
			-- Permission to enumerate subkeys.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_ENUMERATE_SUB_KEYS"
		end
		
	Key_execute: INTEGER is
			-- Permission for read access.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_EXECUTE"
		end
		
	Key_notify: INTEGER is
			-- Permission for change notification.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_NOTIFY"
		end
		
	Key_query_value: INTEGER is
			-- Permission to query subkey data.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_QUERY_VALUE"
		end
		
	Key_set_value: INTEGER is
			-- Permission to set subkey data.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_SET_VALUE"
		end
		
	Key_all_access: INTEGER is
			-- Combines the KEY_QUERY_VALUE, KEY_ENUMERATE_SUB_KEYS, 
			-- KEY_NOTIFY, KEY_CREATE_SUB_KEY, KEY_CREATE_LINK, and 
			-- KEY_SET_VALUE access rights, plus all the standard 
			-- access rights except SYNCHRONIZE. 
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_ALL_ACCESS"
		end
		
	Key_read: INTEGER is
			-- Combines the STANDARD_RIGHTS_READ, KEY_QUERY_VALUE, 
			-- KEY_ENUMERATE_SUB_KEYS, and KEY_NOTIFY access rights.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_READ"
		end
		
	Key_write: INTEGER is
			-- Combines the STANDARD_RIGHTS_WRITE, KEY_SET_VALUE,
			-- and KEY_CREATE_SUB_KEY access rights.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_WRITE"
		end
		
end -- class WEL_REGISTRY_ACCESS_MODE


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


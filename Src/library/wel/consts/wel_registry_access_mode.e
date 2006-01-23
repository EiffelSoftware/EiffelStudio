indexing
	description: "Hkey registry open access mode constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	WEL_REGISTRY_ACCESS_MODE

feature -- Access

	frozen Key_create_link: INTEGER is
			-- Permission to create a symbolic link.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_CREATE_LINK"
		end
		
	frozen Key_create_sub_key: INTEGER is
			-- Permission to create subkeys.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_CREATE_SUB_KEY"
		end
		
	frozen Key_enumerate_sub_keys: INTEGER is
			-- Permission to enumerate subkeys.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_ENUMERATE_SUB_KEYS"
		end
		
	frozen Key_execute: INTEGER is
			-- Permission for read access.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_EXECUTE"
		end
		
	frozen Key_notify: INTEGER is
			-- Permission for change notification.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_NOTIFY"
		end
		
	frozen Key_query_value: INTEGER is
			-- Permission to query subkey data.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_QUERY_VALUE"
		end
		
	frozen Key_set_value: INTEGER is
			-- Permission to set subkey data.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_SET_VALUE"
		end
		
	frozen Key_all_access: INTEGER is
			-- Combines the KEY_QUERY_VALUE, KEY_ENUMERATE_SUB_KEYS, 
			-- KEY_NOTIFY, KEY_CREATE_SUB_KEY, KEY_CREATE_LINK, and 
			-- KEY_SET_VALUE access rights, plus all the standard 
			-- access rights except SYNCHRONIZE. 
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_ALL_ACCESS"
		end
		
	frozen Key_read: INTEGER is
			-- Combines the STANDARD_RIGHTS_READ, KEY_QUERY_VALUE, 
			-- KEY_ENUMERATE_SUB_KEYS, and KEY_NOTIFY access rights.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_READ"
		end
		
	frozen Key_write: INTEGER is
			-- Combines the STANDARD_RIGHTS_WRITE, KEY_SET_VALUE,
			-- and KEY_CREATE_SUB_KEY access rights.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_WRITE"
		end
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_REGISTRY_ACCESS_MODE


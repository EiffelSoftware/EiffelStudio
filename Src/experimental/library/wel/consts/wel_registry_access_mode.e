note
	description: "Hkey registry open access mode constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_REGISTRY_ACCESS_MODE

feature -- Access

	frozen Key_create_link: INTEGER
			-- Permission to create a symbolic link.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_CREATE_LINK"
		ensure
			is_class: class
		end

	frozen Key_create_sub_key: INTEGER
			-- Permission to create subkeys.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_CREATE_SUB_KEY"
		ensure
			is_class: class
		end

	frozen Key_enumerate_sub_keys: INTEGER
			-- Permission to enumerate subkeys.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_ENUMERATE_SUB_KEYS"
		ensure
			is_class: class
		end

	frozen Key_execute: INTEGER
			-- Permission for read access.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_EXECUTE"
		ensure
			is_class: class
		end

	frozen Key_notify: INTEGER
			-- Permission for change notification.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_NOTIFY"
		ensure
			is_class: class
		end

	frozen Key_query_value: INTEGER
			-- Permission to query subkey data.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_QUERY_VALUE"
		ensure
			is_class: class
		end

	frozen Key_set_value: INTEGER
			-- Permission to set subkey data.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_SET_VALUE"
		ensure
			is_class: class
		end

	frozen Key_all_access: INTEGER
			-- Combines the KEY_QUERY_VALUE, KEY_ENUMERATE_SUB_KEYS,
			-- KEY_NOTIFY, KEY_CREATE_SUB_KEY, KEY_CREATE_LINK, and
			-- KEY_SET_VALUE access rights, plus all the standard
			-- access rights except SYNCHRONIZE.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_ALL_ACCESS"
		ensure
			is_class: class
		end

	frozen Key_read: INTEGER
			-- Combines the STANDARD_RIGHTS_READ, KEY_QUERY_VALUE,
			-- KEY_ENUMERATE_SUB_KEYS, and KEY_NOTIFY access rights.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_READ"
		ensure
			is_class: class
		end

	frozen Key_write: INTEGER
			-- Combines the STANDARD_RIGHTS_WRITE, KEY_SET_VALUE,
			-- and KEY_CREATE_SUB_KEY access rights.
		external
			"C [macro %"wel.h%"]"
		alias
			"KEY_WRITE"
		ensure
			is_class: class
		end

	key_wow64_64key: INTEGER = 0x0100
			-- Access to a 64-bit key from either a 32-bit or 64-bit application.

	key_wow64_32key: INTEGER = 0x0200
			-- Access to a 32-bit key from either a 32-bit or 64-bit application.

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

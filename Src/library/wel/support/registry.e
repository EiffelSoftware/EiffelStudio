indexing

	description: "Registry manager"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	WEL_REGISTRY

inherit
	REGSAM
		export
			{NONE} all
		end
		
	HKEY
		export
			{NONE} all
		end

feature -- Element Change

	create_key (parent_key: INTEGER; key_name: STRING; samDesired: INTEGER) is
			-- See class HKEY for possible `parent_key' value.
			-- Update create_disposition in same time.
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (key_name)
			cwin_reg_create_key (Current, parent_key, wel_string.item, samDesired)
		end

	set_create_disposition_result (value: BOOLEAN) is
		do
			create_disposition := value
		end

	open_key (parent_key: INTEGER; key_name: STRING; access_mode: INTEGER) is
			-- Open subkey `key_name' of `parent_key' according to `access_mode'.
			-- See class HKEY for possible `parent_key' value.
			-- See class REGSAM for `access_mode' value.
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (key_name)
			cwin_reg_open_key (parent_key, wel_string.item, access_mode)
		end

	set_key_value (key: INTEGER; key_name: STRING; value: STRING) is
			-- Change value of `key` to `keyvalue`
			-- See class HKEY for possible `key' value.
		local
			wel_string1, wel_string2: WEL_STRING
		do
			!! wel_string1.make (key_name)
			!! wel_string2.make (value)
			cwin_reg_set_key_value (key, wel_string1.item, wel_string2.item)
		end

	close_key (key: INTEGER) is
			-- Close `key'.
			-- See class HKEY for possible `key' value.
		do
			cwin_reg_close_key (key)
		end
		
feature -- Access

	is_new_key: BOOLEAN is
			-- Is created key new?
		do
			Result := create_disposition
		end

	key_value (key: INTEGER; value_name: STRING): STRING is
			-- Retrieve type and data of `value_name' associated with open `key'. 
			-- See class HKEY for possible `key' value.
		local
			wel_string: WEL_STRING
		do
			!! Result.make (0);
			!! wel_string.make (value_name)
			Result.from_c (cwin_reg_query_value (key, wel_string.item))
		end	
	
feature {NONE} -- Implementation

	create_disposition: BOOLEAN

feature {NONE} -- Externals

	cwin_reg_create_key (ptr: WEL_REGISTRY; parent_key: INTEGER; key_name: POINTER; samDesired: INTEGER) is
		external
			"C"
		end
		
	cwin_reg_open_key (parent_key: INTEGER; key_name: POINTER; access_mode: INTEGER) is
		external
			"C"
		end
		
	cwin_reg_set_key_value (key: INTEGER; keyname: POINTER; keyvalue: POINTER) is
		external
			"C"
		end

	cwin_reg_close_key (key: INTEGER) is
		external
			"C"
		end

	cwin_reg_query_value (key: INTEGER; value_name: POINTER): POINTER is
		external
			"C"
		end

end -- class WEL_REGISTRY

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------

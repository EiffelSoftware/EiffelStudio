indexing

	description: "Registry manager"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	WEL_REGISTRY

inherit
	WEL_REGISTRY_ACCESS_MODE
		export
			{NONE} all
			{ANY} default_pointer
		end
		
	WEL_HKEY
		export
			{NONE} all
		end

feature -- Element Change

	create_key (parent_key: INTEGER; key_name: STRING; sam: INTEGER): INTEGER is
			-- Create `key_name' under `parent_key' according to `sam'.
			-- Return handle to created key or 0 on failure.
			-- See class WEL_HKEY for possible `parent_key' value.
			-- See class WEL_REGISTRY_ACCESS_MODE for possible `sam' value.
			-- Update `is_new_key' in same time.
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (key_name)
			Result := cwin_reg_create_key (Current, parent_key, wel_string.item, sam)
		end

	open_key (parent_key: INTEGER; key_name: STRING; access_mode: INTEGER): INTEGER is
			-- Open subkey `key_name' of `parent_key' according to `access_mode'.
			-- Return handle to created key or 0 on failure.
			-- See class WEL_HKEY for possible `parent_key' value.
			-- See class WEL_REGISTRY_ACCESS_MODE for `access_mode' value.
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (key_name)
			Result := cwin_reg_open_key (parent_key, wel_string.item, access_mode)
		end

	delete_key (parent_key: INTEGER; key_name: STRING): BOOLEAN is
			-- Delete subkey `key_name' of `parent_key'.
			-- Return True if succeeded, False otherwise.
			-- Under Windows 95, all subkeys are deleted.
			-- Under Windows NT, only specified key is deleted;
			-- it should not have subkeys.
		require
			valid_key_name: key_name /= Void
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (key_name)
			Result := cwin_reg_delete_key (parent_key, wel_string.item)
		end

	enumerate_key (key, index: INTEGER): WEL_REGISTRY_KEY is
			-- class WEL_REGISTRY
		local
			registry_key_ptr: POINTER
		do
			registry_key_ptr := cwin_reg_enum_key (key, index)
			if registry_key_ptr /= default_pointer then
				!! Result.make_from_pointer (registry_key_ptr)
			end
		end;

	default_key_value (key: INTEGER; path: STRING): WEL_REGISTRY_KEY_VALUE is
			-- Retrieve value of `value_name' associated with open
			-- `key'.
			-- See class WEL_HKEY for possible `key' value.
			-- Externals
		local
			wel_string: WEL_STRING;
			registry_value_ptr: POINTER
		do
			if path /= Void then
				!! wel_string.make (path);
				registry_value_ptr := cwin_reg_def_query_value (key, wel_string.item)
			else
				registry_value_ptr := cwin_reg_def_query_value (key, default_pointer)
			end;
			if registry_value_ptr /= default_pointer then
				!! Result.make_from_pointer (registry_value_ptr)
			end
		end;

	set_key_value (key: INTEGER; value_name: STRING; value: WEL_REGISTRY_KEY_VALUE) is
			-- Change value defined by `key' and `value_name' to `value'.
			-- See class WEL_HKEY for possible `key' value.
		require
			valid_value: value /= Void and then value.item /= default_pointer
		local
			wel_string: WEL_STRING
		do
			if value_name /= Void then
				!! wel_string.make (value_name)
				cwin_reg_set_key_value (key, wel_string.item, value.item)
			else
				cwin_reg_set_key_value (key, default_pointer, value.item)
			end
		end

	close_key (key: INTEGER) is
			-- Close `key'.
			-- See class WEL_HKEY for possible `key' value.
		do
			cwin_reg_close_key (key)
		end

	set_create_disposition_result (value: BOOLEAN) is
			-- Set `is_new_key' with `value'.
		do
			is_new_key := value
		end
		
feature -- Access

	is_new_key: BOOLEAN
			-- Is created key new?

	key_value (key: INTEGER; value_name: STRING): WEL_REGISTRY_KEY_VALUE is
			-- Retrieve value of `value_name' associated with open 
			-- `key'. 
			-- See class WEL_HKEY for possible `key' value.
		local
			wel_string: WEL_STRING
			a_pointer: POINTER
		do
			!! wel_string.make (value_name)
			a_pointer := cwin_reg_query_value (key, wel_string.item)
			!! Result.make_from_pointer (a_pointer)
		end	

feature {NONE} -- Externals

	cwin_reg_create_key (ptr: WEL_REGISTRY; parent_key: INTEGER; key_name: POINTER; sam: INTEGER): INTEGER is
		external
			"C | %"registry.h%""
		end
		
	cwin_reg_open_key (parent_key: INTEGER; key_name: POINTER; access_mode: INTEGER): INTEGER is
		external
			"C | %"registry.h%""
		end
		
	cwin_reg_delete_key (key: INTEGER; subkey: POINTER): BOOLEAN is
		external
			"C"
		end

	cwin_reg_enum_key (key, index: INTEGER): POINTER is
			-- (export status {NONE})
		external
			"C | %"registry.h%""
		end;

	cwin_reg_set_key_value (key: INTEGER; keyname: POINTER; keyvalue: POINTER) is
		external
			"C | %"registry.h%""
		end

	cwin_reg_close_key (key: INTEGER) is
		external
			"C | %"registry.h%""
		end

	cwin_reg_query_value (key: INTEGER; value_name: POINTER): POINTER is
		external
			"C | %"registry.h%""
		end

	cwin_reg_def_query_value (key: INTEGER; value_name: POINTER): POINTER is
			-- (export status {NONE})
		external
			"C | %"registry.h%""
		end;

end -- class WEL_REGISTRY

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


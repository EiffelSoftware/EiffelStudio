indexing
	description: "Registry manager"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_REGISTRY

inherit
	WEL_REGISTRY_ACCESS_MODE

	WEL_HKEY

	STRING_HANDLER

feature -- Actions

	create_new_key (key_path: STRING_GENERAL) is
				-- Create a new key, with as path 'path'
				-- The path should be like "a\b\c"
				-- Please refer to WEL_HKEY for possible value for a.
		require
			at_least_one_back_slash: key_path /= Void and then key_path.has_code (('\').natural_32_code)
		local
			index_value: POINTER
		do
			index_value := key_from_path (key_path, True, Key_create_sub_key)
			close_key (index_value)
		end

	open_key_with_access (key_path: STRING_GENERAL; acc: INTEGER): POINTER is
				-- Open the key relative to the path 'key_path', with
				-- the access 'acc'.
				-- Return the key reference (default_pointer if the operation failed).
		require
			at_least_one_back_slash: key_path /= Void and then key_path.has_code (('\').natural_32_code)
		do
			Result := key_from_path (key_path, False, acc)
		end

	open_key_value (key_path: STRING_GENERAL; value_name: STRING_GENERAL): WEL_REGISTRY_KEY_VALUE is
				-- Open a key, with as path 'path' and
				-- name 'key_name'.
				-- The path should be like "a\b\c"
				-- Please refer to WEL_HKEY for possible value for a.
				-- Return Void if the operation did not correctly terminate.
		require
			key_name_possible: value_name /= Void
			at_least_one_back_slash: key_path /= Void and then key_path.has_code (('\').natural_32_code)
		local
			index_value: POINTER
		do
			index_value := key_from_path (key_path, False, Key_read)
			if index_value /= default_pointer then
				Result := key_value (index_value, value_name)
				close_key (index_value)
			end
		end

	save_key_value (key_path, value_name: STRING_GENERAL; value: WEL_REGISTRY_KEY_VALUE) is
			-- Set value of key in `key_path' with name `value_name' to `value'.
			-- Create key if needed.
			-- The path should be like "a\b\c"
			-- Please refer to WEL_HKEY for possible value for a.
		require
			at_least_one_back_slash: key_path /= Void and then key_path.has_code (('\').natural_32_code)
			key_name_possible: value_name /= Void
			valid_value: value /= Void
		local
			index_value: POINTER
		do
			index_value := key_from_path (key_path, True, Key_write)
			if index_value /= default_pointer then
				set_key_value (index_value, value_name, value)
				close_key (index_value)
			end
		end

	delete_key_value (key_path, value_name: STRING_GENERAL) is
			-- Delete `key_path' key value `value_name'.
			-- The path should be like "a\b\c"
			-- Please refer to WEL_HKEY for possible value for a.
		require
			at_least_one_back_slash: key_path /= Void and then key_path.has_code (('\').natural_32_code)
			key_name_possible: value_name /= Void
		local
			index_value: POINTER
		do
			index_value := key_from_path (key_path, False, Key_write)
			if index_value /= default_pointer then
				delete_value (index_value, value_name)
				close_key (index_value)
			end
		end

feature -- Status

	last_call_successful: BOOLEAN
			-- Did last call succeed?

feature {NONE} -- Internal Results

	value_keys_list (path: STRING_GENERAL): LIST [STRING_32] is
			-- From a path ( "a\b\c\...\x")
			-- Return a list of string: a,b,c,d,e,...x
		require
			path_possible: path /= Void
		do
			Result := path.as_string_32.split ('\')
		ensure
			value_keys_list_not_void: Result /= Void
		end

	key_from_path (key_path: STRING_GENERAL; generate: BOOLEAN; access: INTEGER): POINTER is
			-- Key at `key_path'.
			-- Create keys if `generate'.
		require
			at_least_one_back_slash: key_path /= Void and then key_path.has_code (('\').natural_32_code)
		local
			node_list: LIST [STRING_GENERAL]
			i: POINTER
			item: STRING_GENERAL
		do
			node_list := value_keys_list (key_path)
			check
				node_list_possible: node_list.count > 0
				first_element_possible: basic_valid_name_for_HKEY (node_list.first)
			end
			node_list.start
			Result := index_value_for_root_keys (node_list.item)
			from
				node_list.forth
			until
				node_list.after or Result = default_pointer
			loop
				item := node_list.item
				if not item.is_empty then
					i := open_key (Result, item, access)
					if i = default_pointer and generate then
						i := create_key (Result, item, access)
					end
					close_key (Result)
					Result := i
				end
				node_list.forth
			end
		end

feature -- Access

	key_from_remote_host (host_name: STRING_GENERAL; root_key: POINTER): POINTER is
			-- Connect the computer designed by its name 'host_name'.
			-- 'Host_name' should be under the format: \\computer_name
			-- 'root_key' is the key from where we want to start the
			-- investigations on the remote machine.
			-- If 'Host_name' is empty, then the local computer is used by default.
		require
			root_key_possible: root_key = HKEY_LOCAL_MACHINE or
							   root_key = HKEY_USERS or
							   root_key = HKEY_PERFORMANCE_DATA
			host_name_possible: host_name /= Void
		local
			s: WEL_STRING
			res: INTEGER
		do
			if not host_name.is_empty then
				create s.make(host_name)
				res := cwin_reg_connect_key (s.item, root_key, $Result)
			else
				res := cwin_reg_connect_key (default_pointer, root_key, $Result)
			end
			last_call_successful := res = Error_success
			if not last_call_successful then
				Result := default_pointer
			end
		end

	enumerate_key (key: POINTER; index: INTEGER): WEL_REGISTRY_KEY is
			-- `index'th subkey of `key',
			-- Void if `key' has less than `index' subkeys.
		require
			key_possible: valid_value_for_hkey (key)
			index_possible: index <= number_of_subkeys (key)
		local
			file_time: WEL_FILE_TIME
			key_name, class_name: WEL_STRING
			key_size, class_size: INTEGER
			res: INTEGER
			done: BOOLEAN
			l_null: POINTER
		do
				-- Get the size of the key and class to be retrieved.
			res := cwin_reg_value_number(key, l_null, l_null, l_null, l_null,
				$key_size, $class_size, l_null, l_null, l_null, l_null, l_null)
			last_call_successful := res = Error_success
			if last_call_successful then
					-- Add +1 for null terminator character
				key_size := key_size + 1
				class_size := class_size + 1
				create key_name.make_empty (key_size)
				create class_name.make_empty (class_size)
				create file_time.make
				res := cwin_reg_enum_key (
					key, index, key_name.item, $key_size,
					l_null, class_name.item, $class_size, file_time.item)
				last_call_successful := res = Error_success
				if last_call_successful then
					create Result.make (key_name.substring (1, key_size),
						class_name.substring (1, class_size), file_time)
				end
			end
		end

	default_key_value (key: POINTER; subkey: STRING_GENERAL): WEL_REGISTRY_KEY_VALUE is
			-- Retrieve value of `subkey' associated with open
			-- `key'.
		obsolete
			"Use `key_value' with an empty string instead, if `subkey' is Void or empty. %
			%Otherwise open manually the subkey represented by `subkey' and then call `key_value' %
			%with an empty string."
		require
			key_possible: valid_value_for_hkey(key)
		local
			l_subkey: WEL_STRING
			l_ext: MANAGED_POINTER
			l_size: INTEGER
		do
			if subkey /= Void then
				last_call_successful := False
				create l_subkey.make (subkey)
				if cwin_reg_query_value (key, l_subkey.item, default_pointer, $l_size) = error_success then
					create l_ext.make (l_size)
					if cwin_reg_query_value (key, l_subkey.item, l_ext.item, $l_size) = error_success then
						last_call_successful := True
						create Result.make_with_data ({WEL_REGISTRY_KEY_VALUE_TYPE}.reg_sz, l_ext)
					end
				end
			else
				Result := key_value (key, "")
			end
		end

feature -- Settings

	set_key_value (key: POINTER; value_name: STRING_GENERAL; value: WEL_REGISTRY_KEY_VALUE) is
			-- Change value defined by `key' and `value_name' to `value'.
	     	-- The key identified by the hKey parameter must have been
			-- opened with KEY_SET_VALUE access
		require
			valid_value: value /= Void
			valid_value_name: value_name /= Void
			key_possible:valid_value_for_hkey(key)
		local
			a: WEL_STRING
			res: INTEGER
		do
			if value_name /= Void then
				create a.make (value_name)
				res := cwin_reg_set_key_value (key, a.item, 0, value.type,
					value.data.item, value.data.count)
			else
				res := cwin_reg_set_key_value (key, default_pointer, 0, value.type,
					value.data.item, value.data.count)
			end
			last_call_successful := res = Error_success
		end

feature -- Basic Actions

	create_key (parent_key: POINTER; key_name: STRING_GENERAL; sam: INTEGER): POINTER is
			-- Create `key_name' under `parent_key' according to `sam'.
			-- Return handle to created key or default_pointer on failure.
		require
				key_name_possible: key_name /= Void and then not key_name.is_empty
				parent_key_possible:valid_value_for_hkey(parent_key)
		local
			a: WEL_STRING
			disp, res: INTEGER
		do
			create a.make (key_name)
			res := cwin_reg_create_key (
				parent_key,
				a.item,
				0,
				Reg_none,
				Reg_option_non_volatile,
				sam,
				default_pointer,
				$Result,
				$disp)
			last_call_successful := res = Error_success
			if not last_call_successful then
				Result := default_pointer
			end
		end

	open_key (parent_key: POINTER; key_name: STRING_GENERAL; access_mode: INTEGER): POINTER is
			-- Open subkey `key_name' of `parent_key' according to `access_mode'.
			-- Return handle to created key or default_pointer on failure.
		require
			key_name_possible: key_name /= Void and then not key_name.is_empty
			parent_key_possible:valid_value_for_hkey(parent_key)
		local
			a: WEL_STRING
			res: INTEGER
		do
			create a.make (key_name)
			res := cwin_reg_open_key (parent_key, a.item, 0, access_mode, $Result)
			if res /= Error_success then
				Result := default_pointer
			end
		end

	close_key (key: POINTER) is
			-- Close `key'.
			-- Return True if succeeded, False otherwise.
		require
			key_possible:valid_value_for_hkey(key)
		do
			last_call_successful := cwin_reg_close_key (key) = Error_success
		end

	delete_key (parent_key: POINTER; key_name: STRING_GENERAL) is
			-- Delete subkey `key_name' of `parent_key'.
			-- Return True if succeeded, False otherwise.
			-- Under Windows 95, all subkeys are deleted.
			-- Under Windows NT, only specified key is deleted
			-- it should not have subkeys.
		require
			key_name_possible: key_name /= Void and then not key_name.is_empty
			parent_key_possible:valid_value_for_hkey(parent_key)
		local
			a: WEL_STRING
			res: INTEGER
		do
			create a.make (key_name)
			res := cwin_reg_delete_key (parent_key, a.item)
			last_call_successful := res = Error_success
		end

	enumerate_values (key: POINTER): LINKED_LIST [STRING_32] is
		-- Find the names of the key values within the
		-- key referenced by 'key'.
		local
			i: INTEGER
			s: STRING_GENERAL
		do
			create Result.make
			from
				i:=0
			until
				i = -1
			loop
				s := enumerate_value(key, i)
				if s /= Void then
					Result.extend(s)
					i := i+1
				else
					i := -1
				end
			end
		end

	enumerate_values_as_string_8 (key: POINTER): LINKED_LIST [STRING] is
		-- Find the names of the key values within the
		-- key referenced by 'key'.
		local
			i: INTEGER
			s: STRING_GENERAL
		do
			create Result.make
			from
				i:=0
			until
				i = -1
			loop
				s := enumerate_value(key, i)
				if s /= Void then
					Result.extend(s.as_string_8)
					i := i+1
				else
					i := -1
				end
			end
		end

feature  -- New actions

	delete_value (parent_key: POINTER; name: STRING_GENERAL) is
		require
			key_possible: valid_value_for_hkey(parent_key)
			name_possible: name /= Void
		local
			a: WEL_STRING
			res: INTEGER
		do
			create a.make (name)
			res := cwin_reg_delete_value (parent_key, a.item)
			last_call_successful := res = Error_success
		end

	enumerate_value (key: POINTER; index: INTEGER): STRING_GENERAL is
			-- Find the name of the key_value corresponding
			-- to the key 'key and the index 'index'.
		local
			p: POINTER
			res, size: INTEGER
			ext: WEL_STRING
		do
			size := 1024
			create ext.make_empty (size)
			res  := cwin_reg_enum_value (key, index, ext.item, $size, p, p, p, p)
			last_call_successful := res = Error_success
			if last_call_successful then
				Result := ext.substring (1, size)
			else
				Result := Void
			end
		end

	number_of_subkeys (key: POINTER): INTEGER is
		local
			res, nbkey, size, values: INTEGER
			p: POINTER
		do
			res := cwin_reg_value_number(key, p, p, p, $Result, $nbkey, $size, $values, p, p, p, p)
			last_call_successful := res = Error_success
			if not last_call_successful then
				Result := 0
			end

		end

	number_of_values (key: POINTER): INTEGER is
		local
			res, nbkeys, nbkey, size: INTEGER
			p: POINTER
		do
			res := cwin_reg_value_number(key, p, p, p, $nbkeys, $nbkey, $size, $Result, p, p, p, p)
			last_call_successful := res = Error_success
			if not last_call_successful then
				Result := 0
			end
		end

	valid_value_for_hkey (key: POINTER): BOOLEAN is
			-- Does key pointed by 'key' exists
		do
			Result := (key /= default_pointer)
		end

feature -- Access

	key_value (key: POINTER; value_name: STRING_GENERAL): WEL_REGISTRY_KEY_VALUE is
			-- Retrieve value of `value_name' associated with open
			-- `key'.
			-- The identifier 'key' relative to the parent key must
			-- have been opened with the KEY_QUERY_VALUE access.
		require
        	value_name_possible: value_name /= Void
			key_valid: valid_value_for_hkey (key)
		local
			l_name: WEL_STRING
			l_type, l_size, l_res: INTEGER
			l_ext: MANAGED_POINTER
			l_null: POINTER
		do
			create l_name.make (value_name)
			last_call_successful := False
			if cwin_reg_query_value_ex (key, l_name.item, l_null, l_null, l_null, $l_size) = Error_success then
					-- Repeat until it works and that no more data has to be read. See MSDN
					-- comments about why this needs to be done when the root key is HKEY_PERFORMANCE_DATA.
				from
					create l_ext.make (l_size)
					l_res := cwin_reg_query_value_ex (key, l_name.item, l_null, $l_type, l_ext.item, $l_size)
				until
					l_res = error_success or l_res /= error_more_data
				loop
					create l_ext.make (l_size)
					l_res := cwin_reg_query_value_ex (key, l_name.item, l_null, $l_type, l_ext.item, $l_size)
				end

				if l_res = error_success then
					create Result.make_with_data (l_type, l_ext)
					last_call_successful := True
				end
			end
		end

feature {NONE} -- Externals

	cwin_reg_create_key (parent_key: POINTER; key_name: POINTER; res: INTEGER; clas: POINTER; opt, sam: INTEGER; sec, resu, dis: POINTER): INTEGER is
		external
			"C macro signature (HKEY, LPCTSTR, DWORD, LPTSTR, DWORD, REGSAM, LPSECURITY_ATTRIBUTES, PHKEY, LPDWORD): EIF_INTEGER use <windows.h>"
		alias
			"RegCreateKeyEx"
		end

	cwin_reg_open_key (parent_key: POINTER; key_name: POINTER; options, access_mode: INTEGER; res: POINTER): INTEGER is
		external
			"C macro signature (HKEY, LPCTSTR, DWORD, REGSAM, PHKEY): EIF_INTEGER use <windows.h>"
		alias
			"RegOpenKeyEx"
		end

	cwin_reg_delete_key (key: POINTER; subkey: POINTER): INTEGER is
		external
			"C macro signature (HKEY, LPCTSTR): EIF_INTEGER use <windows.h>"
		alias
			"RegDeleteKey"
		end

	cwin_reg_enum_key (key: POINTER; index: INTEGER; name, cname, reserved, cl, ccl, lastwrite: POINTER): INTEGER is
		external
			"C macro signature (HKEY, DWORD, LPTSTR, LPDWORD, LPDWORD, LPTSTR, LPDWORD, PFILETIME): EIF_INTEGER use <windows.h>"
		alias
			"RegEnumKeyEx"
		end

	cwin_reg_set_key_value (key, keyname: POINTER; res, type: INTEGER; data: POINTER; siz: INTEGER): INTEGER is
		external
			"C macro signature (HKEY, LPCTSTR, DWORD, DWORD, BYTE *, DWORD): EIF_INTEGER use <windows.h>"
		alias
			"RegSetValueEx"
		end

	cwin_reg_close_key (key: POINTER): INTEGER is
		external
			"C macro signature (HKEY): EIF_INTEGER use <windows.h>"
		alias
			"RegCloseKey"
		end

	cwin_reg_query_value_ex (key, value_name, res, type, data, size: POINTER): INTEGER is
		external
			"C macro signature (HKEY, LPCTSTR, LPDWORD, LPDWORD, LPBYTE, LPDWORD): EIF_INTEGER use <windows.h>"
		alias
			"RegQueryValueEx"
		end

	cwin_reg_delete_value (key, value_name: POINTER): INTEGER is
		external
			"C macro signature (HKEY, LPCTSTR): EIF_INTEGER use <windows.h>"
		alias
			"RegDeleteValue"
		end

	cwin_reg_query_value (key: POINTER; subkey, value_name, size: POINTER): INTEGER is
		external
			"C macro signature (HKEY, LPCTSTR, LPTSTR, PLONG): EIF_INTEGER use <windows.h>"
		alias
			"RegQueryValue"
		end

	cwin_reg_enum_value (key: POINTER; index: INTEGER; val_name, val_size, res, type, data, pcb_data: POINTER): INTEGER is
		external
			"[
				C macro signature
					(HKEY, DWORD, LPTSTR, LPDWORD, LPDWORD, LPDWORD, LPBYTE, LPDWORD): EIF_INTEGER
				use <windows.h>
			]"
		alias
			"RegEnumValue"
		end

	cwin_reg_value_number (key, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11: POINTER) : INTEGER is
		external
			"[
			C macro signature
				(HKEY, LPTSTR, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, PFILETIME): EIF_INTEGER         
				use <windows.h>
			]"
		alias
			"RegQueryInfoKey"
		end

	cwin_reg_connect_key (name, key, pkey: POINTER): INTEGER is
		external
			"C macro signature (LPTSTR, HKEY, PHKEY): EIF_INTEGER use <windows.h>"
		alias
			"RegConnectRegistry"
		end

feature {NONE} -- External constants

	Error_success: INTEGER is
		external
			"C [macro <windows.h>]"
		alias
			"ERROR_SUCCESS"
		end

	Error_more_data: INTEGER is
		external
			"C [macro <windows.h>]"
		alias
			"ERROR_MORE_DATA"
		end

	Reg_none: POINTER is
		external
			"C macro use <windows.h>"
		alias
			"REG_NONE"
		end

	Reg_option_non_volatile: INTEGER is
		external
			"C macro use <windows.h>"
		alias
			"REG_OPTION_NON_VOLATILE"
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




end -- class WEL_REGISTRY


indexing
	description: "Registry manager"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	note: "Changed the type of Keys from INTEGER to POINTER"

class
	WEL_REGISTRY

inherit
	WEL_REGISTRY_ACCESS_MODE
		export
			{NONE} all
			{ANY} default_pointer
		end
		
	WEL_HKEY
	
	STRING_HANDLER

feature -- Actions

	create_new_key (key_path: STRING) is
				-- Create a new key, with as path 'path'
				-- The path should be like "a\b\c"
				-- Please refer to WEL_HKEY for possible value for a.
		require
			at_least_one_back_slash: key_path /= Void and then key_path.has('\')
		local
			node_list: ARRAYED_LIST [STRING]
			index_value, i: POINTER
		do
			node_list := value_keys_list (key_path)
			check
				node_list_possible: node_list.count > 0
				first_element_possible: basic_valid_name_for_HKEY (node_list.first)
			end
			node_list.start
			index_value := index_value_for_root_keys (node_list.item)
			from
				node_list.forth
			until
				node_list.after
			loop
				i := open_key (index_value,node_list.item, Key_create_sub_key)
				if i = default_pointer then
					i := create_key (index_value, node_list.item, Key_create_sub_key)
				end
				close_key (index_value)
				index_value := i
				node_list.forth
			end
		end

	open_key_with_access (key_path: STRING; acc: INTEGER): POINTER is
				-- Open the key relative to the path 'key_path', with
				-- the access 'acc'.
				-- Return the key reference (defaul_pointer if the operation failed).
		require
			at_least_one_back_slash: key_path /= Void and then key_path.has('\')
		local
			node_list: ARRAYED_LIST [STRING]
			index_value, i: POINTER
		do
			node_list := value_keys_list(key_path)
			check
				node_list_possible: node_list.count>0
				first_element_possible: basic_valid_name_for_HKEY(node_list.first)
			end
			node_list.start
			index_value := index_value_for_root_keys (node_list.item)
			from
				node_list.forth
			until
				node_list.after or index_value = default_pointer
			loop
				i := open_key (index_value,node_list.item, acc)
				close_key (index_value)
				index_value := i
				node_list.forth
			end
			Result := index_value
		end

	open_key_value (key_path: STRING; value_name: STRING): WEL_REGISTRY_KEY_VALUE is
				-- Open a key, with as path 'path' and 
				-- name 'key_name'.
				-- The path should be like "a\b\c"
				-- Please refer to WEL_HKEY for possible value for a.
				-- Return Void if the operation did not correctly terminate.
		require
			key_name_possible: value_name /= Void and then not value_name.is_empty
			at_least_one_back_slash: key_path /= Void and then key_path.has('\')
		local
			node_list: ARRAYED_LIST [STRING]
			index_value, i: POINTER
			stop: BOOLEAN
		do
			node_list := value_keys_list(key_path)
			check
				node_list_possible: node_list.count>0
				first_element_possible: basic_valid_name_for_HKEY(node_list.first)
			end
			node_list.start
			index_value := index_value_for_root_keys (node_list.item)
			from
				node_list.forth
			until
				node_list.after or stop
			loop
				i := open_key (index_value,node_list.item, Key_read)
				if i = default_pointer then
					stop := TRUE
				end
				close_key (index_value)
				index_value := i
				node_list.forth
			end
			if not stop then
				Result := key_value (index_value, value_name)
			end
		end

feature -- Status

	last_call_successful: BOOLEAN
			-- Did last call succeed?

feature {NONE} -- Internal Results

	value_keys_list (path: STRING): ARRAYED_LIST [STRING] is
			-- From a path ( "a\b\c\...\x") 
			-- Return a list of string: a,b,c,d,e,...x
		require
			path_possible: path /= Void
		local
			i,j: INTEGER
			s: STRING
		do
			create Result.make (10)
			from
				i :=1
				j := 1
				s := clone (path)
			until
				j < 1
			loop
				j := s.index_of ('\', i + 1)
				if j > i then
					Result.extend (s.substring (i, j - 1))
					i := j + 1
				end
			end
			if i + 1 < s.count then
				Result.extend (s.substring (i, s.count))
			end
		end

feature -- Access

	key_from_remote_host (host_name: STRING; root_key: POINTER): POINTER is
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
		do
			from
				key_size := 64
				class_size := 20
				create key_name.make_empty (key_size)
				create class_name.make_empty (class_size)
				create file_time.make
				res := - 1
			until
				done and then (res = Error_success or res /= Error_more_data)
			loop
				done := True
				res := cwin_reg_enum_key (
					key,
					index,
					key_name.item,
					$key_size,
					default_pointer,
					class_name.item,
					$class_size,
					file_time.item)
			end
			
			last_call_successful := res = Error_success
			if last_call_successful then
				create Result.make (key_name.string, class_name.string, file_time)
			end
		end

	default_key_value (key: POINTER; path: STRING): WEL_REGISTRY_KEY_VALUE is
			-- Retrieve value of `value_name' associated with open
			-- `key'.
		require
			key_possible:valid_value_for_hkey(key)
		local
			a: ANY
			res, size: INTEGER
			ext: WEL_STRING
		do
			size := 512
			create ext.make_empty (size)
			if path /= Void then
				a := path.to_c
				res := cwin_reg_query_value (key, $a, ext.item, $size)
			else
				res := cwin_reg_query_value (key, default_pointer, ext.item, $size)
			end
			last_call_successful := res = Error_success
			if last_call_successful then
				create Result.make (0, ext.string)
			end
		end

feature -- Settings

	set_key_value (key: POINTER; value_name: STRING; value: WEL_REGISTRY_KEY_VALUE) is
			-- Change value defined by `key' and `value_name' to `value'.
	     	-- The key identified by the hKey parameter must have been 
			-- opened with KEY_SET_VALUE access
		require
			valid_value: value /= Void
			valid_value_name: value_name /= Void
			key_possible:valid_value_for_hkey(key)
		local
			a, b: ANY
			res: INTEGER
		do
			b := value.value.to_c
			if value_name /= Void then
				a := value_name.to_c
				res := cwin_reg_set_key_value (key, $a, 0, value.type, $b, value.value.capacity)
			else
				res := cwin_reg_set_key_value (key, default_pointer, 0, value.type, $b, value.value.capacity)
			end
			last_call_successful := res = Error_success
		end

feature -- Basic Actions 

	create_key (parent_key: POINTER; key_name: STRING; sam: INTEGER): POINTER is
			-- Create `key_name' under `parent_key' according to `sam'.
			-- Return handle to created key or default_pointer on failure.
		require
				key_name_possible: key_name /= Void and then not key_name.is_empty
				parent_key_possible:valid_value_for_hkey(parent_key)
		local
			a: ANY
			disp, res: INTEGER
		do
			a := key_name.to_c
			res := cwin_reg_create_key (
				parent_key,
				$a,
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

	open_key (parent_key: POINTER; key_name: STRING; access_mode: INTEGER): POINTER is
			-- Open subkey `key_name' of `parent_key' according to `access_mode'.
			-- Return handle to created key or default_pointer on failure.
		require
			key_name_possible: key_name /= Void and then not key_name.is_empty
			parent_key_possible:valid_value_for_hkey(parent_key)
		local
			a: ANY
			res: INTEGER
		do
			a := key_name.to_c
			res := cwin_reg_open_key (parent_key, $a, 0, access_mode, $Result)
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

	delete_key (parent_key: POINTER; key_name: STRING) is
			-- Delete subkey `key_name' of `parent_key'.
			-- Return True if succeeded, False otherwise.
			-- Under Windows 95, all subkeys are deleted.
			-- Under Windows NT, only specified key is deleted
			-- it should not have subkeys.
		require
			key_name_possible: key_name /= Void and then not key_name.is_empty
			parent_key_possible:valid_value_for_hkey(parent_key)
		local
			a: ANY
			res: INTEGER
		do
			a := key_name.to_c
			res := cwin_reg_delete_key (parent_key, $a)
			last_call_successful := res = Error_success
		end

	enumerate_values (key: POINTER): LINKED_LIST [STRING] is
		-- Find the names of the key values within the
		-- key referenced by 'key'.
		local
			i: INTEGER
			s: STRING
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

feature  -- New actions

	delete_value (parent_key: POINTER; name: STRING) is
		require
			key_possible: valid_value_for_hkey(parent_key)
			name_possible: name /= Void
		local
			a: ANY
			res: INTEGER
		do
			a := name.to_c
			res := cwin_reg_delete_value (parent_key, $a)
			last_call_successful := res = Error_success
		end

	enumerate_value (key: POINTER; index: INTEGER): STRING is
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
				Result := ext.string
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

	key_value (key: POINTER; value_name: STRING): WEL_REGISTRY_KEY_VALUE is
			-- Retrieve value of `value_name' associated with open 
			-- `key'. 
			-- The identifier 'key' relative to the parent key must
			-- have been opened with the KEY_QUERY_VALUE access.
		require
        	value_name_possible: value_name /= Void and then not value_name.is_empty
			key_valid:valid_value_for_hkey(key)
		local
			a: ANY
			res, type, size: INTEGER
			ext: WEL_STRING
		do
			a := value_name.to_c
			size := 512
			create ext.make_empty (size)
			res := cwin_reg_query_value_ex (key, $a, default_pointer, $type, ext.item, $size)
			if res = Error_success then
				create Result.make (type, ext.string)
			else
				if res = Error_more_data then
						-- Size was given by first call to RegQueryValueEx, we create
						-- a string that can hold that much.
					create ext.make_empty (size)
					res := cwin_reg_query_value_ex (key, $a, default_pointer, $type, ext.item, $size)
					if res = Error_success then
						create Result.make (type, ext.string)
					end
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
				(HKEY, LPSTR, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, PFILETIME): EIF_INTEGER         
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
				
end -- class WEL_REGISTRY


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


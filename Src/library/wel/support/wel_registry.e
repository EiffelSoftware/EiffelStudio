indexing
	description: "Registry manager"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$";
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

feature -- Actions

	create_new_key (key_path: STRING) is
				-- Create a new key, with as path 'path'
				-- The path should be like "a\b\c"
				-- Please refer to WEL_HKEY for possible value for a.
		require
			at_least_one_back_slash: key_path /= Void and then key_path.has('\')
		local
			node_list: LINKED_LIST [STRING]
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
				index_value := i
				node_list.forth
			end
		end

	open_key_with_access(key_path: STRING; sam: INTEGER):POINTER is
				-- Open the key relative to the path 'key_path', with
				-- the access 'sam'.
				-- Return the key reference (defaul_pointer if the operation failed).
		require
			at_least_one_back_slash: key_path /= Void and then key_path.has('\')
		local
			node_list: LINKED_LIST [STRING]
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
				i := open_key (index_value,node_list.item,sam)
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
			node_list: LINKED_LIST [STRING]
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
				index_value := i
				node_list.forth
			end
			if not stop then
				Result := key_value (index_value, value_name)
				if Result /= Void and then Result.item = default_pointer then
					Result := Void
				end
			end
		end


feature {NONE} -- Internal Results

	value_keys_list (path :STRING): LINKED_LIST[STRING] is
			-- From a path ( "a\b\c\...\x") 
			-- Return a list of string: a,b,c,d,e,...x
		require
			path_possible: path /= Void
		local
			i,j: INTEGER
			s: STRING
		do
			create Result.make
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

	key_from_remote_host(host_name: STRING; root_key: POINTER):POINTER is
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
		do
			if not host_name.is_empty then
				create s.make(host_name)
				Result := cwin_reg_connect_key(s.item,root_key)
			else
				Result := cwin_reg_connect_key(DEFAULT_POINTER, root_key)
			end
		end

	enumerate_key (key: POINTER; index: INTEGER): WEL_REGISTRY_KEY is
			-- `index'th subkey of `key',
			-- Void if `key' has less than `index' subkeys.
		require
			key_possible: valid_value_for_hkey (key)
			index_possible: index <= number_of_subkeys (key)
		local
			registry_key_ptr: POINTER
		do
			registry_key_ptr := cwin_reg_enum_key (key, index)
			if registry_key_ptr /= default_pointer then
				create Result.make_from_pointer (registry_key_ptr)
			end
		end

	default_key_value (key: POINTER; path: STRING): WEL_REGISTRY_KEY_VALUE is
			-- Retrieve value of `value_name' associated with open
			-- `key'.
		require
			key_possible:valid_value_for_hkey(key)
		local
			wel_string: WEL_STRING;
			registry_value_ptr: POINTER
		do
			if path /= Void then
				create wel_string.make (path);
				registry_value_ptr := cwin_reg_def_query_value (key, wel_string.item)
			else
				registry_value_ptr := cwin_reg_def_query_value (key, default_pointer)
			end;
			if registry_value_ptr /= default_pointer then
				create Result.make_from_pointer (registry_value_ptr)
			end
		end

feature -- Settings

	set_key_value (key: POINTER; value_name: STRING; value: WEL_REGISTRY_KEY_VALUE) is
			-- Change value defined by `key' and `value_name' to `value'.
	     	-- The key identified by the hKey parameter must have been 
			-- opened with KEY_SET_VALUE access
		require
			valid_value: value /= Void and then value.item /= default_pointer
			valid_value_name: value_name /= Void
			key_possible:valid_value_for_hkey(key)
		local
			wel_string: WEL_STRING
		do
			if value_name /= Void then
				create wel_string.make (value_name)
				cwin_reg_set_key_value (key, wel_string.item, value.item)
			else
				cwin_reg_set_key_value (key, default_pointer, value.item)
			end
		end

feature -- Basic Actions 

	create_key (parent_key: POINTER; key_name: STRING; sam: INTEGER): POINTER is
			-- Create `key_name' under `parent_key' according to `sam'.
			-- Return handle to created key or default_pointer on failure.
		require
				key_name_possible: key_name /= Void and then not key_name.is_empty
				parent_key_possible:valid_value_for_hkey(parent_key)
		local
			wel_string: WEL_STRING
		do
			create wel_string.make (key_name)
			Result := cwin_reg_create_key (parent_key, wel_string.item, sam)
		end

	open_key (parent_key: POINTER; key_name: STRING; access_mode: INTEGER): POINTER is
			-- Open subkey `key_name' of `parent_key' according to `access_mode'.
			-- Return handle to created key or default_pointer on failure.
		require
			key_name_possible: key_name /= Void and then not key_name.is_empty
			parent_key_possible:valid_value_for_hkey(parent_key)
		local
			wel_string: WEL_STRING
		do
			create wel_string.make (key_name)
			Result := cwin_reg_open_key (parent_key, wel_string.item, access_mode)
		end

	close_key (key: POINTER): BOOLEAN is
			-- Close `key'.
			-- Return True if succeeded, False otherwise.
		require
			key_possible:valid_value_for_hkey(key)
		do
			Result := cwin_reg_close_key (key)
		end

	delete_key (parent_key: POINTER; key_name: STRING): BOOLEAN is
			-- Delete subkey `key_name' of `parent_key'.
			-- Return True if succeeded, False otherwise.
			-- Under Windows 95, all subkeys are deleted.
			-- Under Windows NT, only specified key is deleted;
			-- it should not have subkeys.
		require
			key_name_possible: key_name /= Void and then not key_name.is_empty
			parent_key_possible:valid_value_for_hkey(parent_key)
		local
			wel_string: WEL_STRING
		do
			create wel_string.make (key_name)
			Result := cwin_reg_delete_key (parent_key, wel_string.item)
		end

	enumerate_values(key: POINTER):LINKED_LIST[STRING] is
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

	delete_value(parent_key: POINTER; name: STRING):BOOLEAN is
		require
			key_possible: valid_value_for_hkey(parent_key)
			name_possible: name /= Void
		local
			wel_string: WEL_STRING
		do
			create wel_string.make (name)
			Result := cwin_reg_delete_value(parent_key, wel_string.item)
		end

	enumerate_value(key: POINTER; index: INTEGER): STRING is
				-- Find the name of the key_value corresponding
				-- to the key 'key and the index 'index'.
			local
				p: POINTER
			do
				p  := cwin_reg_enum_value (key, index)
				if p/=default_pointer then
					create Result.make(20)
					Result.from_c(p)
				end	
			end

	number_of_subkeys(key: POINTER):INTEGER is
			do
				Result := cwin_reg_subkey_number(key)
			end

	number_of_values(key: POINTER):INTEGER is
			do
				Result := cwin_reg_value_number(key)
			end

	valid_value_for_hkey (key: POINTER):BOOLEAN is
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
			wel_string: WEL_STRING
			a_pointer: POINTER
		do
			create wel_string.make (value_name)
			a_pointer := cwin_reg_query_value (key, wel_string.item)
		 	if (a_pointer /= default_pointer) then
   				create Result.make_from_pointer (a_pointer)
         	end
		end	

feature {NONE} -- Externals

	cwin_reg_create_key (parent_key: POINTER; key_name: POINTER; sam: INTEGER): POINTER is
		external
			"C | %"registry.h%""
		end
		
	cwin_reg_open_key (parent_key: POINTER; key_name: POINTER; access_mode: INTEGER): POINTER is
		external
			"C | %"registry.h%""
		end
		
	cwin_reg_delete_key (key: POINTER; subkey: POINTER): BOOLEAN is
		external
			"C | %"registry.h%""
		end

	cwin_reg_enum_key (key: POINTER; index: INTEGER): POINTER is
			-- (export status {NONE})
		external
			"C | %"registry.h%""
		end;

	cwin_reg_set_key_value (key: POINTER; keyname: POINTER; keyvalue: POINTER) is
		external
			"C | %"registry.h%""
		end

	cwin_reg_close_key (key: POINTER):BOOLEAN is
		external
			"C | %"registry.h%""
		end

	cwin_reg_query_value (key: POINTER; value_name: POINTER): POINTER is
		external
			"C | %"registry.h%""
		end

	cwin_reg_delete_value (key: POINTER; value_name: POINTER): BOOLEAN is
		external
			"C | %"registry.h%""
		end

	cwin_reg_def_query_value (key: POINTER; value_name: POINTER): POINTER is
			-- (export status {NONE})
		external
			"C | %"registry.h%""
		end

	cwin_reg_enum_value (key: POINTER; index: INTEGER): POINTER is
			-- (export status {NONE})
		external
			"C | %"registry.h%""
		end

	cwin_reg_subkey_number(key: POINTER) : INTEGER is
		-- (export status {NONE})
		external
			"C | %"registry.h%""
		end

	cwin_reg_value_number(key:POINTER) : INTEGER is
		-- (export status {NONE})
		external
			"C | %"registry.h%""
		end

	cwin_reg_connect_key(name: POINTER; key: POINTER): POINTER is
		-- (export status {NONE})
		external
			"C | %"registry.h%""
		end

end -- class WEL_REGISTRY

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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


indexing
	description: "Windows Registry resource structure implementation."

class
	PREFERENCE_STRUCTURE_IMP

inherit
	PREFERENCE_STRUCTURE_I
	
	WEL_REGISTRY

create
	make_empty,
	make_with_location

feature {PREFERENCE_STRUCTURE} -- Initialization
	
	make_empty is
			-- Create resource structure in the registry.  Registry key created base on name of application 
			-- in `HKEY_CURRENT_USER\Software\'.  So location will be `HKEY_CURRENT_USER\Software\APPLICATION_NAME_HERE'
		local
			l_loc, l_prog: STRING
			l_exec: EXECUTION_ENVIRONMENT
		do			
			create l_exec
			l_loc := "HKEY_CURRENT_USER\Software\"
			l_prog := l_exec.command_line.argument (0)
			if l_prog /= Void then
				l_prog := l_prog.substring (l_prog.last_index_of ('\', l_prog.count) + 1, l_prog.count) + "\"
			else
				l_prog := "\"
			end
			l_loc.append (l_prog)			
			make_with_location (l_loc)
		end

	make_with_location (a_location: STRING) is
			-- Create resource structure in the registry at location `a_location'.
			-- Try to read key at `a_location' if it exists, if not create new one.
	   	local
			l_keyp: POINTER
			l_name,
			l_value: STRING
			l_key_values: LINKED_LIST [STRING]
		do			
			create session_values.make (5)
			location := a_location
			l_keyp := open_key_with_access (location, key_read)
			if l_keyp = default_pointer then
				create_new_key (location)
			else
				l_key_values := enumerate_values (l_keyp)
				if not l_key_values.is_empty then				
					from						
						l_key_values.start
					until
						l_key_values.after
					loop
						l_name := l_key_values.item
						l_value := key_value (l_keyp, l_name).string_value
						if l_name.has ('_') then
							l_name := l_name.substring (l_name.index_of ('_', 1) + 1, l_name.count)
						end						
						if not session_values.has (l_name) then
							session_values.put (l_value, l_name)
						end
						l_key_values.forth
					end
				end
			end		
		end

feature {PREFERENCE_STRUCTURE} -- Resource Management

	has_resource (a_name: STRING): BOOLEAN is
			-- Does the underlying store contain a resource with `a_name'?
		local
			l_handle,
			l_child_handle: POINTER
		do
			l_handle := open_key_with_access (location, Key_read)			
			l_child_handle := open_key (l_handle, location + a_name, Key_read)
			close_key (l_child_handle)
			close_key (l_handle)
			Result := l_child_handle /= default_pointer
		end
		
	get_resource_value (a_name: STRING): STRING is
			-- Retrieve the resource string value from the underlying store.
		local
			l_handle,
			l_child_handle: POINTER
			l_key_value: WEL_REGISTRY_KEY_VALUE
		do
			l_handle := open_key_with_access (location, Key_read)			
			l_child_handle := open_key (l_handle, location + a_name, Key_read)
			
			l_key_value := key_value (l_child_handle, location + a_name)
			Result := l_key_value.string_value
			close_key (l_child_handle)
			close_key (l_handle)			
		end	

	save_resource (a_resource: PREFERENCE) is
			-- Save `a_resource' to registry
		local
			l_parent_key: POINTER
			l_new_value: WEL_REGISTRY_KEY_VALUE
			l_registry_resource_name: STRING
		do
			l_registry_resource_name := a_resource.string_type + "_" + a_resource.name
			l_parent_key := open_key_with_access (location, key_write)
			create l_new_value.make ({WEL_REGISTRY_KEY_VALUE_TYPE}.reg_sz, a_resource.string_value)		
			
			set_key_value (l_parent_key, l_registry_resource_name, l_new_value)
			close_key (l_parent_key)
		end		

	save (resources: ARRAYED_LIST [PREFERENCE]) is
			-- Save all resources.			
		do			
			from
				resources.start
			until
				resources.after
			loop
				save_resource (resources.item)
				resources.forth
			end
		end		

invariant
	has_session_values: session_values /= Void

end -- class PREFERENCE_STRUCTURE_IMP

indexing
	description: "Objects containing the information relative to a resource folder."
	author: "Christophe Bonnard"

class
	RESOURCE_FOLDER_IMP

inherit
	RESOURCE_FOLDER_I

	WEL_REGISTRY

create
	make, make_root, make_default, make_default_root

feature -- Initialization

	make (doc: WEL_REGISTRY_KEY; p: POINTER; struct: like structure) is
			-- Initialization
		do
			name := doc.name
			description := name
			structure := struct
			handle := p
			load_attributes
		end

	make_root (path: STRING; struct: like structure) is
		do
			name := "root"
			description := "root folder"
			structure := struct
			handle := open_key_with_access (path, Key_read)
			load_attributes
			close_key (handle)
			check
				success: last_call_successful
			end
		end

	load_attributes is
		local
			i: INTEGER
			child: like Current
			key: WEL_REGISTRY_KEY
			child_handle: POINTER
			s: STRING
			resource: RESOURCE
		do
				--| We fill `child_list'
			create {ARRAYED_LIST [RESOURCE_FOLDER_IMP]} child_list.make (20)
			from
				i := 0
				key := enumerate_key (handle, i)
			until
				key = Void
			loop
				child_handle := open_key (handle, key.name, Key_read)
				create child.make (key, child_handle, structure)
				child.create_interface
				child_list.extend (child)
				close_key (child_handle)
				check
					success: last_call_successful
				end
				i := i + 1
				key := enumerate_key (handle, i)
			end
				--| We fill `resource_list'
			create {ARRAYED_LIST [RESOURCE]} resource_list.make (20)
			from
				i := 0
				s := enumerate_value (handle, i)
			until
				s = Void
			loop
				resource := load_resource (s, key_value (handle, s))
				resource_list.extend (resource)
				structure.put_resource (resource)
				i := i + 1
				s := enumerate_value (handle, i)
			end
		end

feature -- Update

	update_root (path: STRING) is
		do
			name := "root"
			description := "root folder"
			handle := open_key_with_access (path, Key_read)
			if handle /= Default_pointer then
				update_attributes (handle)
				close_key (handle)
				check
					success: last_call_successful
				end
			else
				raise ("Registry key does not exist")
			end
		end

	update_attributes (p_handle: POINTER) is
		local
			i: INTEGER
			child: like Current
			key: WEL_REGISTRY_KEY
			child_handle: POINTER
			s: STRING
			resource: RESOURCE
			act_resource: RESOURCE
		do
				--| We update `child_list'
			from
				i := 0
				key := enumerate_key (p_handle, i)
			until
				key = Void
			loop
				child := child_of_name (key.name)
				if child /= Void then
					child_handle := open_key (p_handle, key.name, Key_read)
					child.update_attributes (child_handle)
					close_key (child_handle)
					check
						success: last_call_successful
					end
				end
				i := i + 1
				key := enumerate_key (p_handle, i)
			end
				--| We update `resource_list'
			from
				i := 0
				s := enumerate_value (p_handle, i)
			until
				s = Void
			loop
				act_resource := load_resource (s, key_value (p_handle, s))
				
				resource ?= structure.item (act_resource.name)
				if resource /= Void then
					resource.set_value (act_resource.value)
				end

				i := i + 1
				s := enumerate_value (p_handle, i)
			end
		end

feature -- Access

	handle: POINTER
		-- Handle of the key. Required by windows for access to registry data.
		-- Must be released after use.
		--| Used as a temporary variable. Has no meaning most of the time.

feature -- Save

	root_save (location: STRING) is
		local
			resource: RESOURCE
			child: like Current
		do
			handle := open_key_with_access (location, Key_write)
			if handle = default_pointer then
				create_new_key (location)
				handle := open_key_with_access (location, Key_write)
			end
			from
				child_list.start
			until
				child_list.after
			loop
				child := child_list.item
				child.save (handle)
				child_list.forth
			end
			from
				resource_list.start
			until
				resource_list.after
			loop
				resource := resource_list.item
--				if resource.has_changed then
					set_key_value (handle, resource.registry_name,
						create {WEL_REGISTRY_KEY_VALUE}.make (feature {WEL_REGISTRY_KEY_VALUE_TYPE}.Reg_sz, resource.value)
					)
--				end
				resource_list.forth
			end
			close_key (handle)
			check
				success: last_call_successful
			end
		end

	save (father_handle: POINTER) is
		local
			resource: RESOURCE
			child: like Current
		do
			handle := open_key (father_handle, name, Key_write)
			if handle = default_pointer then
				handle := create_key (father_handle, name, Key_all_access)
			end
			from
				child_list.start
			until
				child_list.after
			loop
				child := child_list.item
				child.save (handle)
				child_list.forth
			end
			from
				resource_list.start
			until
				resource_list.after
			loop
				resource := resource_list.item
--				if resource.has_changed then
					set_key_value (handle, resource.registry_name,
						create {WEL_REGISTRY_KEY_VALUE}.make (feature {WEL_REGISTRY_KEY_VALUE_TYPE}.Reg_sz, resource.value)
					)
--				end
				resource_list.forth
			end
			close_key (handle)
			check
				success: last_call_successful
			end
		end

feature {NONE} -- Implementation

	load_resource (k_name: STRING; reg_k: WEL_REGISTRY_KEY_VALUE): RESOURCE is
			-- Gets the appropriate resource from `reg_k' whose name is `k_name'
			-- if the type is unknown, it is assumed to be a string.
		local
			sprefix: STRING
			types: LINEAR [RESOURCE_TYPE]
		do
			if reg_k.type = reg_k.Reg_dword then
				Result := (structure.registered_types @ structure.Integer_type_index).load_resource (k_name, reg_k.value)
			else
				if k_name.count > 7 then
					sprefix := k_name.substring (1, 6)
					from
						types := structure.registered_types
						types.start
					until
						types.after or Result /= Void
					loop
						if types.item.registry_name.is_equal (sprefix) then
							Result := types.item.load_resource (k_name.substring (8, k_name.count), reg_k.value)
							if Result = Void then
								raise (types.item.error_message)
							end
						end
						types.forth
					end
				end
			end
		end

end -- class RESOURCE_FOLDER_IMP

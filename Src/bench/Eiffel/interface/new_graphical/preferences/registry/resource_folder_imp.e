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
			if not close_key (handle) then
				check
					Error: False
				end
			end
		end

	load_attributes is
		local
			i: INTEGER
			child: like Current
			key: WEL_REGISTRY_KEY
			child_handle: POINTER
			s: STRING
			reg_resource: REGISTRY_RESOURCE
			resource: RESOURCE
		do
				--| We fill `child_list'
			create child_list.make
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
				if not close_key (child_handle) then
					check
							Error: False
					end
				end
				i := i + 1
				key := enumerate_key (handle, i)
			end
				--| We fill `resource_list'
			create resource_list.make
			from
				i := 0
				s := enumerate_value (handle, i)
			until
				s = Void
			loop
				create reg_resource.make (s, key_value (handle, s))
				resource := reg_resource.value
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
			update_attributes (handle)
			if not close_key (handle) then
				check
					Error: False
				end
			end
		end

	update_attributes (p_handle: POINTER) is
		local
			i: INTEGER
			child: like Current
			key: WEL_REGISTRY_KEY
			child_handle: POINTER
			s: STRING
			reg_resource: REGISTRY_RESOURCE
			resource: RESOURCE
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
					if not close_key (child_handle) then
						check
								Error: False
						end
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
				create reg_resource.make (s, key_value (p_handle, s))
				resource := reg_resource.value
				structure.replace_resource (resource)
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
			if not close_key (handle) then
				check
					Error: False
				end
			end
		end

	save (father_handle: POINTER) is
		local
			reg_resource: REGISTRY_RESOURCE
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
				if resource.has_changed then
					create reg_resource.make_from_resource (resource)
					set_key_value (handle, resource.registry_name, reg_resource.key_value)
					resource.mark_saved
				end
				resource_list.forth
			end
			if not close_key (handle) then
				check
					Error: False
				end
			end
		end

	save_resource (res: RESOURCE; location: STRING; path: STRING) is
		local
			reg_resource: REGISTRY_RESOURCE
			s: STRING
			h: POINTER
		do
			s := location + "\" + path
			create_new_key (s)
			h := open_key_with_access (s, Key_write)
			create reg_resource.make_from_resource (res)
			set_key_value (h, res.registry_name, reg_resource.key_value)
			if not close_key (h) then
				check
					Error: False
				end
			end
		end

end -- class RESOURCE_FOLDER_IMP

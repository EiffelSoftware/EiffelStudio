indexing
	description: "Objects containing the information relative to a resource folder."
	author: "Christophe Bonnard"

class
	RESOURCE_FOLDER_IMP

inherit
	RESOURCE_FOLDER
		redefine
			structure
		end

	WEL_REGISTRY

create
	make, make_root

feature -- Initialization

	make (doc: WEL_REGISTRY_KEY; p: POINTER; struct: RESOURCE_STRUCTURE_IMP) is
			-- Initialization
		do
			name := doc.name
			description := name
			structure := struct
			handle := p
			load_attributes
		end

	make_root (path: STRING; struct: RESOURCE_STRUCTURE_IMP) is
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
				create reg_resource.make (s, key_value (handle, s), structure)
				resource_list.extend (reg_resource.value)
				i := i + 1
				s := enumerate_value (handle, i)
			end
		end

feature -- Access

	structure: RESOURCE_STRUCTURE_IMP

	handle: POINTER
		-- Handle of the key. Required by windows for access to registry data.
		-- handle must be released after use.

feature -- Save

	root_save (path: STRING) is
		do
			handle := open_key_with_access (path, Key_read)
			from
				child_list.start
			until
				child_list.after
			loop
				child_list.item.save (handle)
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
		do
			handle := open_key (father_handle, name, Key_write)
			from
				child_list.start
			until
				child_list.after
			loop
				child_list.item.save (handle)
				child_list.forth
			end
			from
				resource_list.start
			until
				resource_list.after
			loop
				resource := resource_list.item
				if resource.has_changed then
					create reg_resource.make_from_resource (resource, structure)
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

end -- class RESOURCE_FOLDER_IMP

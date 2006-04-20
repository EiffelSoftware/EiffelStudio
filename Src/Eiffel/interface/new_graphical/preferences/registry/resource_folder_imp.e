indexing
	description: "Objects containing the information relative to a resource folder."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
				close_key (child_handle)
				check
					success: last_call_successful
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
			if handle /= Default_pointer then
				update_attributes (handle)
				close_key (handle)
				check
					success: last_call_successful
				end
			else
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
				create reg_resource.make (s, key_value (p_handle, s))
				act_resource := reg_resource.value
				
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
			reg_resource: REGISTRY_RESOURCE
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
					create reg_resource.make_from_resource (resource)
					set_key_value (handle, resource.registry_name, reg_resource.key_value)
					resource.mark_saved
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
--				if resource.has_changed then
					create reg_resource.make_from_resource (resource)
					set_key_value (handle, resource.registry_name, reg_resource.key_value)
					resource.mark_saved
--				end
				resource_list.forth
			end
			close_key (handle)
			check
				success: last_call_successful
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class RESOURCE_FOLDER_IMP

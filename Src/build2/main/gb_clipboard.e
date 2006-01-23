indexing
	description: "Objects that handle clipboard manipulation in EiffelBuild"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CLIPBOARD

inherit
	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end

	GB_COMMAND_ADD_OBJECT
		export
			{NONE} all
		end

	GB_XML_OBJECT_BUILDER
		export
			{NONE} all
		end

create
	make_with_components

feature -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Initialize `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			create content_change_actions
			components.history.change_actions.extend (agent history_changed)
			object_stone_dirty := True
			create contents_cell
		ensure
			components_set: components = a_components
		end

feature -- Access

	object: GB_OBJECT is
			-- `Result' is a new object representation of the contents.
		local
			a_list: ARRAYED_LIST [GB_OBJECT]
		do
			Result := internal_object
			if Result /= Void then
				create a_list.make (20)
				Result.all_children_recursive (a_list)
				a_list.extend (Result)
				from
					a_list.start
				until
					a_list.off
				loop
						-- Remove all names from the copied XML. There is no easy method
						-- of keeping the original names as we perform a replace for all objects that
						-- are top level instances within the XML. Can be done, but may be tricky. For later.
					a_list.item.set_name ("")
					a_list.item.set_id (components.id_handler.new_id)
					components.object_handler.add_object_to_objects (a_list.item)
					a_list.forth
				end
					-- Perform the connection of the instance referers afterwards as
					-- otherwise, the temporary object instance referers structure may
					-- reference the sane object in a nested chain as all of the new ids have not yet been updated.
				from
					a_list.start
				until
					a_list.off
				loop
					if a_list.item.associated_top_level_object_on_loading > 0 and not components.object_handler.deleted_objects.has (a_list.item.associated_top_level_object_on_loading) then
						a_list.item.update_object_as_instance_representation
					end
					a_list.forth
				end

			end
		end

	object_stone: GB_CLIPBOARD_OBJECT_STONE is
				-- Execute `Current'.
			local
				contents, temp_element: XM_ELEMENT
				element_info: ELEMENT_INFORMATION
				full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
				all_instances: ARRAYED_LIST [XM_ELEMENT]
				data: XM_CHARACTER_DATA
				temp_object_id: INTEGER
				parent_element: XM_ELEMENT
			do
				if object_stone_dirty then
						-- Only generate a new up to date version of the object stone if
						-- it is possible that the structure of the contents has changed.
					check
						clipboard_not_empty: contents_cell.item /= Void
					end
					create Result.make_with_components (components)
					parent_element := contents_cell.item.deep_twin
					contents ?= parent_element.first
					replace_all_instances_with_up_to_date_xml (contents)
					contents ?= parent_element.first
					remove_nodes_recursive (contents, root_window_string)

						-- Now determine if the top level object is an instance of another
						-- object and if so, set the associated object for `Result'.
					contents ?= parent_element.first
					temp_element ?= child_element_by_name (contents, internal_properties_string)
					full_information := get_unique_full_info (temp_element)
					element_info := full_information @ (reference_id_string)
					if element_info /= Void then
						check
							data_is_integer:element_info.data.is_integer
						end
						temp_object_id := element_info.data.to_integer
						if components.object_handler.objects.has (temp_object_id) then
							Result.set_associated_top_level_object (temp_object_id)
						end
					end

						-- Now return `all_contained_instances' of `Result' so that we can
						-- correctly determine if a drop is permitted.
						-- Must perform special handling if the instance is a top level object
						-- that has been deleted.
						-- How do we check this?
					temp_element ?= parent_element.first
					all_instances := all_elements_by_name (temp_element, reference_id_string)
					from
						all_instances.start
					until
						all_instances.off
					loop
						data ?= all_instances.item.first
						if data /= Void then
							check
								data_is_integer:data.content.is_integer
							end
							temp_object_id := data.content.to_integer
							if components.object_handler.objects.has (temp_object_id) then
								Result.all_contained_instances.put (temp_object_id, temp_object_id)
							end
						end
						all_instances.forth
					end
					object_stone_internal := Result
					object_stone_dirty := False
				else
						-- Simply return the previously computed value.
					Result := object_stone_internal
				end
			end

	object_type: STRING
			-- Type of `object' or Void if `is_empty'.

	is_empty: BOOLEAN is
			-- Is clipboard empty?
		do
			Result := contents_cell.item = Void
		end

	content_change_actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Action sequence executed when contents of clipboard change.

feature {GB_CLIPBOARD_COMMAND} -- Implementation

	internal_object: GB_OBJECT is
			-- `Result' is a new object representing clipboard contents.
			-- This is a minimal representation and does not have it's id's updated, referers connected etc etc.
			-- Used when you simply need a copy of the clipboard's contents for viewing.
		local
			contents: XM_ELEMENT
		do
			if contents_cell.item /= Void then
				contents := contents_cell.item.deep_twin
				components.system_status.block
--				if system_status.is_in_debug_mode then
--					show_element (main_window)
--				end				
				replace_all_instances_with_up_to_date_xml (contents)
				remove_nodes_recursive (contents, root_window_string)
--				if system_status.is_in_debug_mode then
--					show_element (contents, main_window)
--				end				

				Result := new_object (contents, True)
					-- Modify id of `Result' so that it is not the same as that of `Current'.
				components.system_status.resume
			end
		end

feature {GB_CUT_OBJECT_COMMAND, GB_COPY_OBJECT_COMMAND, GB_CLIPBOARD_COMMAND, GB_PASTE_OBJECT_COMMAND} -- Implementation

	set_object (an_object: GB_OBJECT) is
			-- Assign a copy of `an_object' to `Current'.
		require
			an_object_not_void: an_object /= Void
		local
			xml_store: GB_XML_STORE
			xm_element: XM_ELEMENT
			element: XM_ELEMENT
		do
			if an_object.object = Void then
				an_object.build_objects
			end
			object_type := an_object.type
			create xml_store.make_with_components (components)
			xml_store.store_individual_object (an_object)
			xm_element := xml_store.last_stored_individual_object

			if an_object.is_top_level_object then
				-- We must now parse the XML and set the first object as a reference
				-- object and remove the deeper references.
				element ?= xm_element.first
				convert_element_to_instance (element, an_object.id, 1)
			end

			contents_cell.put (xm_element)
			if not content_change_actions.is_empty then
				content_change_actions.call (Void)
			end
			object_stone_dirty := True
		ensure
			contents_cell_not_empty: contents_cell.item /= Void
		end

	contents_cell: CELL [XM_ELEMENT]
			-- A cell to hold the contents of `Current'.
			-- Whenver the contents are requested, this must be copied.

feature {NONE} -- Implementation

		object_stone_internal: GB_CLIPBOARD_OBJECT_STONE
			-- `Result' is the last generated obejct stone from a call to
			-- `object_stone'. This should only be used by `object_stone' and
			-- permits optimization when calling `object_stone' if we know the
			-- structures have not changed.

		object_stone_dirty: BOOLEAN
			-- Should `object_stone_internal' be recomputed?

		history_changed is
				-- Index of history has changed, so flag `object_stone_internal'
				-- for recomputation. If the history position changes, it is possible
				-- that the structure of the object references kept within the clipboard have changed.
			do
				object_stone_dirty := True
			ensure
				object_stone_dirty: object_stone_dirty = True
			end

invariant
--	content_change_actions_not_void: content_change_actions /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_CLIPBOARD

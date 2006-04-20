indexing
	description: "Objects that manipulate objects of type EV_CONTAINER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_CONTAINER

inherit
	
	GB_EV_ANY
		undefine
			attribute_editor
		redefine
			modify_from_xml_after_build
		end
		
	GB_EV_CONTAINER_EDITOR_CONSTRUCTOR
		
	INTERNAL
		export
			{NONE} all
		undefine
			default_create
		end
		
	GB_SHARED_DEFERRED_BUILDER
		export
			{NONE} all
		undefine
			default_create
		end

feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			groups: ARRAYED_LIST [EV_CONTAINER]
			groups_string: STRING
			counter: INTEGER
		do
			groups := first.merged_radio_button_groups
			groups_string := ""
			if groups /= Void then
				from
					counter := 1
				until
					counter > groups.count
				loop
					groups_string.append (components.object_handler.object_from_display_widget (groups @ counter).id.out)
					if counter < groups.count then
						groups_string.append (" ")
					end
					counter := counter + 1
				end
			end
			if not groups_string.is_empty then
				add_element_containing_string (element, merged_groups_string, groups_string)
			end
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		do
				-- We set up some deferred building now.
			deferred_builder.defer_building (Current, element)
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): ARRAYED_LIST [STRING] is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
			linked_groups: ARRAYED_LIST [INTEGER]
			temp_output: STRING
			window_actual_name_for_feature_call: STRING
			other_info: GB_GENERATED_INFO
		do
			create Result.make (2)
			full_information := get_unique_full_info (element)
			element_info := full_information @ merged_groups_string
			if element_info /= Void then
				linked_groups := list_from_single_spaced_values (element_info.data)
					-- If the information was in the XML, then there
					-- should be at least one link.
				check
					has_links: linked_groups.count >= 1
				end
				from
					linked_groups.start
				until
					linked_groups.off
				loop
					if components.object_handler.object_from_id (linked_groups.item).is_top_level_object then
						other_info := info.generated_info_by_id.item (linked_groups.item)
						if other_info.generate_as_client then
							if other_info.type.is_equal (ev_titled_window_string) or other_info.type.is_equal (ev_dialog_string) then
								window_actual_name_for_feature_call.append (client_window_string)
							else
								window_actual_name_for_feature_call.append (client_widget_string)
							end
						else
							window_actual_name_for_feature_call := "Current"
						end
						temp_output := info.actual_name_for_feature_call + "merge_radio_button_groups (" + window_actual_name_for_feature_call + ")"
					else
						temp_output := info.actual_name_for_feature_call + "merge_radio_button_groups (" + info.Names_by_id.item (linked_groups.item) + ")"
					end
					Result.extend (temp_output)
					linked_groups.forth
				end
			end
		end
		
feature {GB_DEFERRED_BUILDER} -- Status setting


	modify_from_xml_after_build (element: XM_ELEMENT) is
			-- Build from XML any information that was
			-- deferred during the load/build cycle.
		local
			element_info: ELEMENT_INFORMATION
			temp_string: STRING
			counter, last_space, found_id: INTEGER
			merged_object: GB_CONTAINER_OBJECT
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (merged_groups_string)
			if element_info /= Void then
				last_space := 1
				temp_string := element_info.data
				from
					counter := 1
				until
					counter > temp_string.count
				loop
					if temp_string @ counter = ' ' then
						check
							only_one_space_per_value: temp_string @ (counter + 1) /= ' '
						end
						found_id := (temp_string.substring (last_space, counter - 1)).to_integer						
						last_space := counter + 1
					elseif counter = temp_string.count then
						found_id := (temp_string.substring (last_space, counter)).to_integer
					end
					merged_object ?= components.object_handler.object_from_id (found_id)
					
--					check
--						merged_object_was_container: merged_object /= Void
--					end
--| FIXME this is to handle the case where we build a component that has a linked radio button.
--| This does not currently work.
					if merged_object /= Void then
						link_to_object (merged_object)
					end
					counter := counter + 1
				end
			end
		end

feature {GB_DELETE_OBJECT_COMMAND} -- Implementation

	new_merge (object_stone: GB_STANDARD_OBJECT_STONE) is
			-- Merge radio group of `an_object' with `Current'.
		local
			container: EV_CONTAINER
			other_groups: ARRAYED_LIST [EV_CONTAINER]
			counter: INTEGER
			radio_group_link: GB_RADIO_GROUP_LINK
			other_object: GB_OBJECT
			an_object: GB_CONTAINER_OBJECT
		do
			an_object ?= object_stone.object
			check
				an_object_not_void: an_object /= Void
			end
			create radio_group_link.make_with_components (components)
			radio_group_link.set_pebble (radio_group_link)
			radio_group_link.set_object (an_object)
			radio_group_link.set_gb_ev_container (Current)
			
			merged_list.extend (radio_group_link)				
				-- We must now create a new addition for all containers that
				-- were already linked to `an_object'.
			container ?= an_object.object
			other_groups := container.merged_radio_button_groups
				-- `other' may not be merged to any other groups.
			if other_groups /= Void then
				from
					counter := 1
				until
					counter > other_groups.count
				loop
					other_object := components.object_handler.object_from_display_widget (other_groups @ counter)
					check
						object_not_void: other_object /= Void
					end
					create radio_group_link.make_with_components (components)
					radio_group_link.set_object (other_object)
					radio_group_link.set_gb_ev_container (Current)
					radio_group_link.set_pebble (radio_group_link)
					merged_list.extend (radio_group_link)
					counter := counter + 1
				end
			end
				-- We cannot use `for_all_objects' as we need to pass a different argument
				-- to each object.
			link_to_object (an_object)
		end
			
	update_linked_names is
			-- For all items in `merged_list', update
			-- their texts to reflect the current state of
			-- associated object names.
		local
			radio_group_link: GB_RADIO_GROUP_LINK
		do
			from
				merged_list.start
			until
				merged_list.off
			loop
				radio_group_link ?= merged_list.item
				check
					item_was_radio_group: radio_group_link /= Void
				end
				radio_group_link.update_displayed_text
				merged_list.forth
			end
		end

feature {GB_DELETE_OBJECT_COMMAND} -- Implementation
		
	unlink_group (group_link: GB_RADIO_GROUP_LINK) is
			--
		local
			container: EV_CONTAINER
			current_display_object, link_display_object: GB_DISPLAY_OBJECT
			grouped_container: EV_CONTAINER
		do
				-- Firstly, unlink the Vision2 object associated
				-- with GB_OBJECT.object.
			container ?= group_link.object.object
			check
				object_was_container: container /= Void
			end
			grouped_container ?= object.object
			check
				object_was_container: grouped_container /= Void
			end
			grouped_container.unmerge_radio_button_groups (container)
			
				-- Now, unlink the Vision2 object associated
				-- with GB_OBJECT.display_object
			link_display_object ?= group_link.object.display_object
			check
				was_container_display_object: link_display_object /= Void
			end
			current_display_object ?= object.display_object
			check
				object_was_a_contained: current_display_object /= Void
			end
			current_display_object.child.unmerge_radio_button_groups (link_display_object.child)

				-- Removed `group_link' from display of
				-- merged containers.
			merged_list.prune_all (group_link)
			
				-- Updated object editors that may be affected by this
				-- attribute change.
			update_object_editors_for_radio_unmerge (group_link.object, parent_editor)
				-- Destroy `group_link' as it is no longer needed.
			group_link.destroy
			
				-- Now update the project status, as something has changed.
			enable_project_modified
		end
		
	update_object_editors_for_radio_unmerge (unmerged_object: GB_OBJECT; calling_editor: GB_OBJECT_EDITOR) is
			-- For every item in `editors', updated, to reflect an unmerging of `merged_object'.
		local
			editor: GB_OBJECT_EDITOR
			editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
			editor_container: EV_CONTAINER
		do
			editors := components.object_editors.all_editors
			from
				editors.start
			until
				editors.off
			loop
				editor := editors.item
				editor_container ?= editor.object.object
				if editor /= calling_editor and editor_container /= Void then
					editor.update_current_object	
				end
				editors.forth
			end
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		local
			groups: ARRAYED_LIST [EV_CONTAINER]
			container: EV_CONTAINER
			counter: INTEGER
			radio_group_link: GB_RADIO_GROUP_LINK
			other_object: GB_OBJECT
		do
			container ?= first
			check
				first_is_container: container /= Void
			end
			groups := container.merged_radio_button_groups
			if groups /= Void then
				if groups.count = merged_list.count then
					update_linked_names	
				else
				merged_list.wipe_out
				from
					counter := 1
				until
					counter > groups.count
				loop
					other_object := components.object_handler.object_from_display_widget (groups @ counter)
					create radio_group_link.make_with_components (components)
					radio_group_link.set_object (other_object)
					radio_group_link.set_gb_ev_container (Current)
					radio_group_link.set_pebble (radio_group_link)
					merged_list.extend (radio_group_link)
					counter := counter + 1
				end
				end
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


end -- class GB_EV_CONTAINER

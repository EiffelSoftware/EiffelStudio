indexing
	description: "Objects that manipulate objects of type EV_CONTAINER"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_CONTAINER

inherit
	
	GB_EV_ANY
		redefine
			attribute_editor,
			ev_type,
			modify_from_xml_after_build
		end
		
	GB_XML_UTILITIES
		export
			{NONE} all
		undefine
			default_create
		end
		
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
		
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		undefine
			default_create
		end
		
	GB_GENERAL_UTILITIES
		export
			{NONE} all
		undefine
			default_create
		end

feature -- Access


	ev_type: EV_CONTAINER
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_CONTAINER"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			label: EV_LABEL
		do
			Result := Precursor {GB_EV_ANY}
			create label.make_with_text ("radio button groups")
			Result.extend (label)
			create merged_list
			merged_list.set_minimum_height (50)
			merged_list.drop_actions.extend (agent new_merge)
			Result.extend (merged_list)
	
			update_attribute_editor
			disable_all_items (Result)
			align_labels_left (Result)
		end
		
		new_merge (an_object: GB_OBJECT) is
				-- Merge radio group of `an_object' with `Current'.
			local
				list_item: EV_LIST_ITEM
				container: EV_CONTAINER
				other_groups: ARRAYED_LIST [EV_CONTAINER]
				counter: INTEGER
				radio_group_link: GB_RADIO_GROUP_LINK
				other_object: GB_OBJECT
			do
				create radio_group_link.make_with_text (an_object.id.out)
				radio_group_link.set_pebble (radio_group_link)
				radio_group_link.set_object (an_object)
				radio_group_link.set_gb_ev_container (Current)
				
				merged_list.extend (radio_group_link)
					-- We cannot use `for_all_objects' as we need to pass a different argument
					-- to each object.
				link_to_object (an_object)
				
				-- We must now create a new addition for all containers that
				-- were already linked to `an_object'.
				container ?= an_object.object
				other_groups := container.merged_radio_button_groups
				from
					counter := 1
				until
					counter > other_groups.count
				loop
					other_object := object_handler.object_from_display_widget (other_groups @ counter)
					check
						object_not_void: other_object /= Void
					end
					create radio_group_link.make_with_text (other_object.id.out)
					radio_group_link.set_object (other_object)
					radio_group_link.set_gb_ev_container (Current)
					radio_group_link.set_pebble (radio_group_link)
					counter := counter + 1
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
			merged_list.wipe_out
			container ?= first
			check
				first_is_container: container /= Void
			end
			groups := container.merged_radio_button_groups
			if groups /= Void then
				from
					counter := 1
				until
					counter > groups.count
				loop
					other_object := object_handler.object_from_display_widget (groups @ counter)
					create radio_group_link.make_with_text (other_object.id.out)
					radio_group_link.set_object (other_object)
					radio_group_link.set_gb_ev_container (Current)
					radio_group_link.set_pebble (radio_group_link)
					merged_list.extend (radio_group_link)
					counter := counter + 1
				end
			end
		end
		
feature {GB_XML_STORE} -- Output

	
	generate_xml (element: XML_ELEMENT) is
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
					groups_string.append (object_handler.object_from_display_widget (groups @ counter).id.out)
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
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		do
				-- We set up some deferred building now.
			deferred_builder.defer_building (Current, element)
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XML_ELEMENT; info: GB_GENERATED_INFO): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			linked_groups: ARRAYED_LIST [INTEGER]
			temp_output: STRING
		do
			Result := ""
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
					temp_output := info.Names_by_id.item (linked_groups.item) + ".merge_radio_button_groups (" + info.name + ")"
					if linked_groups.index = 1 then
						Result := temp_output
					else
						Result := Result + indent + temp_output
					end
					linked_groups.forth
				end
			end
		end
		
feature {GB_DEFERRED_BUILDER} -- Status setting


	modify_from_xml_after_build (element: XML_ELEMENT) is
			-- Build from XML any information that was
			-- deferred during the load/build cycle.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			temp_string: STRING
			counter, last_space, found_id: INTEGER
			merged_object: GB_OBJECT
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
						merged_object := object_handler.object_from_id (found_id)
						link_to_object (merged_object)
						last_space := counter + 1
					elseif counter = temp_string.count then
						found_id := (temp_string.substring (last_space, counter)).to_integer
						merged_object := object_handler.object_from_id (found_id)
						link_to_object (merged_object)
					end
					counter := counter + 1
				end
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
			grouped_container ?= parent_editor.object.object
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
			current_display_object ?= parent_editor.object.display_object
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
		end
		
	update_object_editors_for_radio_unmerge (unmerged_object: GB_OBJECT; calling_editor: GB_OBJECT_EDITOR) is
			-- For every item in `editors', updated, to reflect an unmerging of `merged_object'.
		local
			editor: GB_OBJECT_EDITOR
			window_parent: EV_WINDOW
			editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
			unmerged_container: EV_CONTAINER
			editor_container: EV_CONTAINER
		do
			editors := all_editors
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

feature {NONE} -- Implementation

	link_to_object (an_object: GB_OBJECT) is
			-- Perform a merging of `Current' and `an_object'.
		local
			container: EV_CONTAINER
			display_object: GB_DISPLAY_OBJECT
		do
				-- First set up display object.
			container ?= an_object.object
			check
				object_was_container: container /= Void
			end
			if first.merged_radio_button_groups = Void or not first.merged_radio_button_groups.has (container) then
				first.merge_radio_button_groups (container)			
			end
				
				-- Now set up the builder object.
			display_object ?= an_object.display_object
			check
				object_was_a_contained: display_object /= Void
			end
			if (objects @ 2).merged_radio_button_groups = Void or not (objects @ 2).merged_radio_button_groups.has (display_object.child) then
				(objects @ 2).merge_radio_button_groups (display_object.child)	
			end
		end
		

	merged_list: EV_LIST
		-- Representation of all containers linked to
		-- this one for radio button grouping.

end -- class GB_EV_CONTAINER

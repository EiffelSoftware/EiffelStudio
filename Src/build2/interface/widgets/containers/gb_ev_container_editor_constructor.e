indexing
	description: "Builds an attribute editor for modification of objects of type EV_CONTAINER."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_CONTAINER_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
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
			editor_item: GB_OBJECT_EDITOR_ITEM
			hbox1, hbox2: EV_HORIZONTAL_BOX
			pixmap: EV_PIXMAP
			tool_bar1, tool_bar2: EV_TOOL_BAR
		do
			create Result
			initialize_attribute_editor (Result)
			create label.make_with_text (gb_ev_container_radio_groups)
			label.set_tooltip (gb_ev_container_radio_groups_tooltip)
			Result.extend (label)
			label.set_minimum_height (label.minimum_height + Object_editor_padding_width)
			create merged_list
			merged_list.set_tooltip (gb_ev_container_radio_groups_tooltip)
			merged_list.set_minimum_height (100)
			merged_list.drop_actions.extend (agent new_merge)
			merged_list.drop_actions.set_veto_pebble_function (agent veto_merge (?))
			Result.extend (merged_list)
			
			pixmap := (create {GB_SHARED_PIXMAPS}).pixmap_by_name ("propagate")
			
			create propagate_foreground_color--.make_with_text (gb_ev_container_propagate_foreground_color)
			create tool_bar1
			tool_bar1.extend (propagate_foreground_color)
			propagate_foreground_color.set_pixmap (pixmap)
			create propagate_background_color--.make_with_text (gb_ev_container_propagate_background_color)
			create tool_bar2
			tool_bar2.extend (propagate_background_color)
			propagate_background_color.set_pixmap (pixmap)
			propagate_background_color.set_tooltip (gb_ev_container_propagate_background_color_tooltip)
			propagate_foreground_color.set_tooltip (gb_ev_container_propagate_foreground_color_tooltip)
			propagate_foreground_color.select_actions.extend (agent for_all_objects (agent {EV_CONTAINER}.propagate_foreground_color))
			propagate_background_color.select_actions.extend (agent for_all_objects (agent {EV_CONTAINER}.propagate_background_color))
				-- We now modify the editor item corresponding to
				-- GB_EV_COLORIZABLE. It is much nicer, if the
				-- propagate buttons are placed here, along with the color
				-- selection.
			editor_item := parent_editor.editor_item_by_type ("EV_COLORIZABLE")
			check
				colorizable_controls_not_changed: editor_item /= Void
			end
			hbox1 ?= editor_item @ 2
			hbox1.go_i_th (hbox1.count)
			hbox1.put_left (tool_bar1)
			hbox1.disable_item_expand (tool_bar1)
			
			
			hbox2 ?= editor_item @ 4
			hbox2.go_i_th (hbox2.count)
			hbox2.put_left (tool_bar2)
			hbox2.disable_item_expand (tool_bar2)
			
			update_attribute_editor
			disable_all_items (Result)
			align_labels_left (Result)
		end
		
feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			-- Nothing to do here.
		end

	new_merge (an_object: GB_OBJECT) is
			-- Merge radio group of `an_object' with `Current'.
		deferred
		end

	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		deferred
		end
		
	update_linked_names is
			-- For all items in `merged_list', update
			-- their texts to reflect the current state of
			-- associated object names.
		deferred
		end
		
	unlink_group (group_link: GB_RADIO_GROUP_LINK) is
			--
		deferred
		end
		
	update_object_editors_for_radio_unmerge (unmerged_object: GB_OBJECT; calling_editor: GB_OBJECT_EDITOR) is
			-- For every item in `editors', updated, to reflect an unmerging of `merged_object'.
		deferred
		end

	veto_merge (an_object: GB_CONTAINER_OBJECT): BOOLEAN is
			-- Stop invalid radio_group_merges.
			-- An object may not be dropped if it is the same object that
			-- `Current' represents, or it is already merged to the object
			-- that current represents.
			-- Also, may only drop, if object is a container.
		local
			container_object: GB_CONTAINER_OBJECT
		do
			if an_object.object /= Void then
				container_object ?= an_object
				if container_object /= Void and then object /= an_object then
					if (first.merged_radio_button_groups = Void) then
						Result := True
					elseif not first.merged_radio_button_groups.has (container_object.object) then
						Result := True
					end
				end
			end
		end

	link_to_object (an_object: GB_CONTAINER_OBJECT) is
			-- Perform a merging of `Current' and `an_object'.
		local
			container: EV_CONTAINER
			display_object: GB_DISPLAY_OBJECT
			second: like ev_type
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
			second := objects @ 2
			if second /= Void then
				if second.merged_radio_button_groups = Void or not second.merged_radio_button_groups.has (display_object.child) then
					second.merge_radio_button_groups (display_object.child)	
				end
			end
				-- Now update the project status, as something has changed.
			enable_project_modified
		end

	merged_list: EV_LIST
		-- Representation of all containers linked to
		-- this one for radio button grouping.
		
	propagate_foreground_color, propagate_background_color: EV_TOOL_BAR_BUTTON

end -- class GB_EV_CONTAINER_EDITOR_CONSTRUCTOR

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
			vbox1, vbox2: EV_VERTICAL_BOX
			frame1, frame2: EV_FRAME
			button1, button2: EV_BUTTON
			new_button1, new_button2: EV_BUTTON
		do
			create Result
			initialize_attribute_editor (Result)
			create label.make_with_text (gb_ev_container_radio_groups)
			label.set_tooltip (gb_ev_container_radio_groups_tooltip)
			Result.extend (label)
			create merged_list
			merged_list.set_tooltip (gb_ev_container_radio_groups_tooltip)
			merged_list.set_minimum_height (100)
			merged_list.drop_actions.extend (agent new_merge)
			merged_list.drop_actions.set_veto_pebble_function (agent veto_merge (?))
			Result.extend (merged_list)
			create propagate_foreground_color.make_with_text (gb_ev_container_propagate_foreground_color)
			create propagate_background_color.make_with_text (gb_ev_container_propagate_background_color)
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
			frame1 ?= editor_item @ 1
			frame2 ?= editor_item @ 2
			check
				colorizable_controls_not_changed: frame1 /= Void and frame2 /= Void
			end

				-- Note that as we rebuild the colorizable control,
				-- we must rebuild one of the buttons, as we have no
				-- way of restoring it back to its original size.
			
				-- Firstly rebuild the background_color
			vbox1 ?= frame1.item
			hbox1 ?= vbox1.i_th (vbox1.count)
			button1 ?= hbox1.i_th (1)
			create new_button1
			new_button1.set_text (button1.text)
			new_button1.select_actions.append (button1.select_actions)
			button1.destroy
			hbox1.extend (new_button1)
			hbox1.extend (propagate_background_color)
			
			
				-- Secondly rebuild the foreground_color
			vbox2 ?= frame2.item
			hbox2 ?= vbox2.i_th (vbox2.count)
			button2 ?= hbox2.i_th (1)
			create new_button2
			new_button2.set_text (button2.text)
			new_button2.select_actions.append (button2.select_actions)
			button2.destroy
			hbox2.extend (new_button2)
			hbox2.extend (propagate_foreground_color)
			
			update_attribute_editor
			disable_all_items (Result)
			align_labels_left (Result)
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

feature {NONE} -- Implementation

	veto_merge (an_object: GB_OBJECT): BOOLEAN is
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
				if container_object /= Void and then parent_editor.object /= an_object then
					if (first.merged_radio_button_groups = Void) then
						Result := True
					elseif not first.merged_radio_button_groups.has (container_object.object) then
						Result := True
					end
				end
			end
		end

	link_to_object (an_object: GB_OBJECT) is
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
		
	propagate_foreground_color, propagate_background_color: EV_BUTTON

end -- class GB_EV_CONTAINER_EDITOR_CONSTRUCTOR

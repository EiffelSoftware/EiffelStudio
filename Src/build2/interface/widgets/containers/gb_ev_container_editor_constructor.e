indexing
	description: "Builds an attribute editor for modification of objects of type EV_CONTAINER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			hbox1, hbox2: EV_HORIZONTAL_BOX
			pixmap: EV_PIXMAP
			tool_bar1, tool_bar2: EV_TOOL_BAR
		do
			create Result.make_with_components (components)
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
			
			create propagate_foreground_color
			create tool_bar1
			tool_bar1.extend (propagate_foreground_color)
			propagate_foreground_color.set_pixmap (pixmap)
			create propagate_background_color
			create tool_bar2
			tool_bar2.extend (propagate_background_color)
			propagate_background_color.set_pixmap (pixmap)
			propagate_background_color.set_tooltip (gb_ev_container_propagate_background_color_tooltip)
			propagate_foreground_color.set_tooltip (gb_ev_container_propagate_foreground_color_tooltip)
			propagate_foreground_color.select_actions.extend (agent internal_propagate_color (object, True))
			propagate_background_color.select_actions.extend (agent internal_propagate_color (object, False))
				-- We now modify the editor item corresponding to
				-- GB_EV_COLORIZABLE. It is much nicer, if the
				-- propagate buttons are placed here, along with the color
				-- selection.
			colorizable_editor_item := parent_editor.editor_item_by_type ("EV_COLORIZABLE")
			check
				colorizable_controls_not_changed: colorizable_editor_item /= Void
			end
			hbox1 ?= colorizable_editor_item @ 2
			hbox1.go_i_th (hbox1.count)
			hbox1.put_left (tool_bar1)
			hbox1.disable_item_expand (tool_bar1)
			
			
			hbox2 ?= colorizable_editor_item @ 4
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

	new_merge (object_stone: GB_STANDARD_OBJECT_STONE) is
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

	veto_merge (object_stone: GB_STANDARD_OBJECT_STONE): BOOLEAN is
			-- Stop invalid radio_group_merges.
			-- An object may not be dropped if it is the same object that
			-- `Current' represents, or it is already merged to the object
			-- that current represents.
			-- Also, may only drop, if object is a container.
		local
			container_object: GB_CONTAINER_OBJECT
		do
			if object_stone.object.object /= Void then
				container_object ?= object_stone.object
				if container_object /= Void and then object /= object_stone.object then
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
		-- Buttons used for color propagation.
	
	internal_propagate_color (an_object: GB_OBJECT; is_foreground_color: BOOLEAN) is
			-- Propagate color setting specified by `is_foreground_color' of `an_object' to all children
			-- recursively.
		require
			an_object_not_void: an_object /= Void
		local
			constant_context: GB_CONSTANT_CONTEXT
			constant: GB_CONSTANT
			color: EV_COLOR
			color_string: STRING
		do
			if not an_object.is_instance_of_top_level_object then
				if is_foreground_color then
					color := first.foreground_color
					color_string := foreground_color_string
				else
					color := first.background_color
					color_string := background_color_string
				end
				constant_context := object.constants.item (colorizable_type + color_string)
				if constant_context /= Void then
					constant := constant_context.constant
				end
				update_color (an_object, color, constant, is_foreground_color)
				for_all_instance_referers (an_object, agent update_color (?, color, constant, is_foreground_color))
				from
					an_object.children.start
				until
					an_object.children.off
				loop				
					internal_propagate_color (an_object.children.item, is_foreground_color)
					an_object.children.forth
				end
				enable_project_modified
			end
		end
		
	update_color (an_object: GB_OBJECT; color: EV_COLOR; constant: GB_CONSTANT; is_foreground_color: BOOLEAN) is
			-- Update color of `an_object' to `color' setting a constant reference to `constant' if not Void.
			-- If `constant' is Void then remove existing constant context if any.
			-- `is_foreground_color' specifis if it is a foreground or background color.
		require
			an_object_not_void: an_object /= Void
			color_not_void: color /= Void
		local
			colorizable: EV_COLORIZABLE
			constant_context: GB_CONSTANT_CONTEXT
			color_string: STRING
		do
			if is_foreground_color then
				color_string := foreground_color_string
			else
				color_string := background_color_string
			end
				-- Ensure that the old constant is removed.
			constant_context := an_object.constants.item (colorizable_type + color_string)
			if constant_context /= Void then
				constant_context.destroy
			end
				-- If we have  anew constant then assign it.
			if constant /= Void then
				create constant_context.make_with_context (constant, an_object, colorizable_type, color_string)
				constant.add_referer (constant_context)
				an_object.add_constant_context (constant_context)
			end
			
				-- Now actually update the colors.
			colorizable ?= an_object.object
			if colorizable /= Void then
				if is_foreground_color then
					colorizable.set_foreground_color (color)
				else
					colorizable.set_background_color (color)
				end
			end
			colorizable ?= an_object.display_object
			if colorizable /= Void then
				if is_foreground_color then
					colorizable.set_foreground_color (color)
				else
					colorizable.set_background_color (color)
				end
			end
				-- Ensure that any existing object editors are updated to reflect this change.
			components.object_editors.update_editors_for_property_change (an_object.object, colorizable_type, parent_editor)
		end
		
	colorizable_editor_item: GB_OBJECT_EDITOR_ITEM;
		-- Access to the colorizable editor item used by `Current' as the propagate butons
		-- are only available to containers.

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


end -- class GB_EV_CONTAINER_EDITOR_CONSTRUCTOR

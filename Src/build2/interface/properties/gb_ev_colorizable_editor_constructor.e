indexing
	description: "Builds an attribute editor for modification of objects of type EV_COLORIZABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_COLORIZABLE_EDITOR_CONSTRUCTOR

inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
	
	GB_CONSTANTS
	
	INTERNAL
		undefine
			default_create
		end
	
feature -- Access

	ev_type: EV_COLORIZABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_COLORIZABLE"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			horizontal_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
			reset_button: EV_TOOL_BAR_BUTTON
			tool_bar: EV_TOOL_BAR
			reset_pixmap: EV_PIXMAP
		do
			create Result.make_with_components (components)
			initialize_attribute_editor (Result)
			
			reset_pixmap := (create {GB_SHARED_PIXMAPS}).pixmap_by_name ("icon_recycle_bin_color")
			
			create label.make_with_text (gb_ev_colorizable_foreground_color)
			Result.extend (label)
			Result.disable_item_expand (label)
			Result.set_padding_width (object_editor_vertical_padding_width)
			create horizontal_box
			create foreground_color_entry.make (Current, horizontal_box, foreground_color_string, "", gb_ev_colorizable_foreground_color_tooltip,
				agent actually_set_foreground_color (?), agent valid_color (?), components)
			foreground_color_entry.color_area.set_pebble_function (agent retrieve_color (foreground_color_entry.color_area, True))
			create reset_button
			create tool_bar
			tool_bar.extend (reset_button)
			reset_button.set_pixmap (reset_pixmap)
			reset_button.set_tooltip (reset_foreground_color_tooltip)
			reset_button.select_actions.extend (agent restore_foreground_color)
			horizontal_box.extend (tool_bar)
			horizontal_box.disable_item_expand (tool_bar)
			Result.extend (horizontal_box)
			
			create label.make_with_text (gb_ev_colorizable_background_color)
			Result.extend (label)
			Result.disable_item_expand (label)
			create horizontal_box
			create background_color_entry.make (Current, horizontal_box, background_color_string, "", gb_ev_colorizable_background_color_tooltip,
				agent actually_set_background_color (?), agent valid_color (?), components)
			background_color_entry.color_area.set_pebble_function (agent retrieve_color (background_color_entry.color_area, False))
			create reset_button
			create tool_bar
			tool_bar.extend (reset_button)
			reset_button.set_pixmap (reset_pixmap)
			reset_button.set_tooltip (reset_background_color_tooltip)
			reset_button.select_actions.extend (agent restore_background_color)
			horizontal_box.extend (tool_bar)
			horizontal_box.disable_item_expand (tool_bar)
			Result.extend (horizontal_box)

			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			foreground_color_entry.update_constant_display (first.foreground_color)
			background_color_entry.update_constant_display (first.background_color)
		end

feature {NONE} -- Implementation

	accept_foreground_color_stone (stone: GB_COLOR_STONE) is
			-- Set foreground color, based on settings of `stone'.
		require
			stone_not_void: stone /= Void
		do
			actually_set_foreground_color (stone.color)
		end
		
	accept_background_color_stone (stone: GB_COLOR_STONE) is
			-- Set background color, based on settings of `stone'.
		require
			stone_not_void: stone /= Void
		do
			actually_set_background_color (stone.color)
		end

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			execution_agents.put (agent actually_set_foreground_color (?), foreground_color_string)
			validate_agents.put (agent valid_color, foreground_color_string)
			execution_agents.put (agent actually_set_background_color (?), background_color_string)
			validate_agents.put (agent valid_color, background_color_string)
		end

	default_object_by_type (a_type: STRING): EV_ANY is
			-- `Result' is a default object that corresponds to `a_type'.
		deferred
		end

	retrieve_color (label: EV_DRAWING_AREA; is_foreground: BOOLEAN): GB_COLOR_STONE is
			-- `Result' is color for pick and drop, retrieved
			-- from `background_color' of `label'.
		do
			if is_foreground then
				Result := create {GB_COLOR_STONE}.make_with_properties (label.background_color.twin, True)
			else
				Result := create {GB_COLOR_STONE}.make_with_properties (label.background_color.twin, False)
			end
		end

	restore_background_color is
			-- Restore `background_color' of objects to originals.
		local
			colorizable: EV_COLORIZABLE
			p: PROCEDURE [EV_ANY, TUPLE]
			constant_context: GB_CONSTANT_CONTEXT
		do
				-- Firsty remove the constant if one exists.
			constant_context := object.constants.item (type + background_color_string)
			if constant_context /= Void then
				constant_context.destroy
			end
			colorizable ?= default_object_by_type (class_name (first))
			p := agent {EV_COLORIZABLE}.set_background_color (colorizable.background_color)
			for_all_objects (p)
			update_editors
			update_attribute_editor
		end
		
	restore_foreground_color is
			-- Restore `foreground_color' of objects to originals.
		local
			colorizable: EV_COLORIZABLE
			p: PROCEDURE [EV_ANY, TUPLE]
			constant_context: GB_CONSTANT_CONTEXT
		do
				-- Firsty remove the constant if one exists.
			constant_context := object.constants.item (type + foreground_color_string)
			if constant_context /= Void then
				constant_context.destroy
			end
			colorizable ?= default_object_by_type (class_name (first))
			p := agent {EV_COLORIZABLE}.set_foreground_color (colorizable.foreground_color)
			for_all_objects (p)
			update_editors
			update_attribute_editor
		end

	update_background_color is
			-- Update `background_color' of objects through an EV_COLOR_DIALOG.
		do
			color_dialog.set_color (background_color)
			color_dialog.show_modal_to_window (parent_window (parent_editor))
			if color_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				actually_set_background_color (color_dialog.color)
			end
		end
		
	actually_set_background_color (color: EV_COLOR) is
			-- Actually update the background colors.
		local
--			container: EV_CONTAINER
			p: PROCEDURE [EV_ANY, TUPLE]
		do
			p := agent {EV_COLORIZABLE}.set_background_color (color)
			for_all_objects (p)
--| FIXME ADD THIS and propagate to all instances.
--| See code in the container editor constructor also.
--			container ?= objects.i_th (2)
--			if container /= Void then
--				container ?= container.parent
--				if container /= Void then
--					container.set_background_color (color)
--				end
--			end
			background_color := color
			update_editors
--			update_background_display
		end

	update_foreground_color is
			-- Update `foreground_color' of objects through an EV_COLOR_DIALOG.
		do
			color_dialog.set_color (foreground_color)
			color_dialog.show_modal_to_window (parent_window (parent_editor))
			if color_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				actually_set_foreground_color (color_dialog.color)
			end
		end
		
	actually_set_foreground_color (color: EV_COLOR) is
			-- Actually update the foreground colors.
		local
			p: PROCEDURE [EV_ANY, TUPLE]
		do
			p := agent {EV_COLORIZABLE}.set_foreground_color (color)
			for_all_objects (p)
			foreground_color := color
			update_editors
		end
		
	valid_color (a_color: EV_COLOR): BOOLEAN is
			-- Is `a_color' a valid color?
		do
			Result := True
		end

	foreground_color: EV_COLOR
	background_color: EV_COLOR
	
	b_area, f_area: EV_DRAWING_AREA
	
	color_dialog: EV_COLOR_DIALOG
	
	foreground_color_entry: GB_COLOR_INPUT_FIELD
	
	background_color_entry: GB_COLOR_INPUT_FIELD;

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


end -- class GB_EV_COLORIZABLE_EDITOR_CONSTRUCTOR

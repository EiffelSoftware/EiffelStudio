indexing
	description: "Builds an attribute editor for modification of objects of type EV_FONTABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_FONTABLE_EDITOR_CONSTRUCTOR

inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end

	DEFAULT_OBJECT_STATE_CHECKER
		undefine
			default_create
		end

feature -- Access

	ev_type: EV_FONTABLE
		-- Vision2 type represented by `Current'.

	type: STRING is "EV_FONTABLE"
		-- String representation of object_type modifyable by `Current'.

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			font_button: EV_BUTTON
			reset_button: EV_BUTTON
			horizontal_box: EV_HORIZONTAL_BOX
		do
			create Result.make_with_components (components)
			initialize_attribute_editor (Result)
			create horizontal_box
			create font_button.make_with_text ("Select font...")
			font_button.select_actions.extend (agent show_dialog)
			horizontal_box.extend (font_button)
			create reset_button.make_with_text ("Reset")
			reset_button.select_actions.extend (agent reset_font)
			horizontal_box.set_padding_width (4)
			horizontal_box.extend (reset_button)
			horizontal_box.disable_item_expand (reset_button)
			horizontal_box.disable_item_expand (font_button)
			Result.extend (horizontal_box)
			update_attribute_editor
		end

	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			-- Nothing to do, as there is no display of the
			-- current font at the moment.
		end

feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			-- Nothing to do here.
		end

	show_dialog is
			-- Display font dialog for user input, and
			-- set font of `objects' to match result.
		do
			create font_dialog
			font_dialog.set_font (first.font)
			font_dialog.show_modal_to_window (parent_window (parent_editor))
			if font_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				for_all_objects (agent {EV_FONTABLE}.set_font (font_dialog.font))
			end
		end

	reset_font is
			-- Reset font of `object' in `Current' to default.
		local
			fontable: EV_FONTABLE
		do
			fontable ?= default_object_by_type (class_name (first))
			for_all_objects (agent {EV_FONTABLE}.set_font (fontable.font))
		end


	font_dialog: EV_FONT_DIALOG
		-- Dialog for user font choices.

-- Constants for XML

	family_string: STRING is "Family"
	weight_string: STRING is "Weight"
	shape_string: STRING is "Shape"
	height_string: STRING is "Height"
	preferred_family_string: STRING is "Preferred_family";

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_EV_FONTABLE_EDITOR_CONSTRUCTOR

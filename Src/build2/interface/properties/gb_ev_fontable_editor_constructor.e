indexing
	description: "Builds an attribute editor for modification of objects of type EV_FONTABLE."
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
			reset_button: EV_BUTTON
			horizontal_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
		do
			create Result
			initialize_attribute_editor (Result)
			create label.make_with_text (gb_ev_fontable_font)
			label.align_text_left
			Result.extend (label)
			Result.disable_item_expand (label)
			create horizontal_box
			create font_entry.make (Current, horizontal_box, font_string, "", gb_ev_fontable_font_tooltip,
				agent set_font (?), agent valid_font (?))
			create reset_button.make_with_text ("Reset")
			reset_button.select_actions.extend (agent reset_font)
			horizontal_box.extend (reset_button)
			horizontal_box.disable_item_expand (reset_button)
			Result.extend (horizontal_box)
			
			update_attribute_editor
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			font_entry.update_constant_display (first.font)
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
		
	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to all instances of `object'.
		require
			a_font_not_void: a_font /= Void
		do
			for_all_objects (agent {EV_FONTABLE}.set_font (a_font))
		end
		
	valid_font (a_font: EV_FONT): BOOLEAN is
			-- Is `font' a valid font? Always true as all fonts
			-- are permitted.
		require
			a_font_not_Void: a_font /= Void
		do
			Result := True
		end

	reset_font is
			-- Reset font of `object' in `Current' to default, removing
			-- constant value if set.
		local
			fontable: EV_FONTABLE
			constant_context: GB_CONSTANT_CONTEXT
		do
			constant_context := object.constants.item (type + font_string)
			if constant_context /= Void then
				constant_context.destroy
			end
			fontable ?= default_object_by_type (class_name (first))
			for_all_objects (agent {EV_FONTABLE}.set_font (fontable.font))
			font_entry.update_constant_display (first.font)
		end

	font_dialog: EV_FONT_DIALOG
		-- Dialog for user font choices.
		
	font_entry: GB_FONT_INPUT_FIELD
		-- Input field for retrieving font information.

end -- class GB_EV_FONTABLE_EDITOR_CONSTRUCTOR

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
		do
			create Result
			initialize_attribute_editor (Result)
			create font_button.make_with_text ("Select font...")
			font_button.select_actions.extend (agent show_dialog)
			Result.extend (font_button)
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

	show_dialog is
			-- Display font dialog for user input, and
			-- set font of `objects' to match result.
		do
			create font_dialog
			font_dialog.set_font (first.font)
			font_dialog.show_modal_to_window (parent_window (parent_editor))
			for_all_objects (agent {EV_FONTABLE}.set_font (font_dialog.font))
		end
		
	font_dialog: EV_FONT_DIALOG
		-- Dialog for user font choices.

-- Constants for XML

	family_string: STRING is "Family"
	weight_string: STRING is "Weight"
	shape_string: STRING is "Shape"
	height_string: STRING is "Height"
	preferred_family_string: STRING is "Preferred_family"

end -- class GB_EV_FONTABLE_EDITOR_CONSTRUCTOR

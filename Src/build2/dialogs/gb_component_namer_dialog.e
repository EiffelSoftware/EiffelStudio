indexing
	description: "Objects that represent a naming dialog"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMPONENT_NAMER_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize
		end
		
	EV_LAYOUT_CONSTANTS
		undefine
			default_create, copy
		end
	
	GB_CONSTANTS
		undefine
			default_create, copy
		end
		
	GB_NAMING_UTILITIES
		undefine
			default_create, copy
		end

create
	default_create

feature -- Initialization

	initialize is
			-- Initialize `Current'.
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			accept_button, cancel_button: EV_BUTTON
		do
			Precursor {EV_DIALOG}
			set_title ("New component namer")
			create name_field
			create accept_button.make_with_text ("OK")
			create cancel_button.make_with_text ("Cancel")
			create vertical_box
			create horizontal_box
			extend (vertical_box)
			vertical_box.extend (name_field)
			vertical_box.extend (horizontal_box)
			horizontal_box.set_padding_width (default_padding_size)
			horizontal_box.set_border_width (default_border_size)
			set_default_size_for_button (accept_button)
			set_default_size_for_button (cancel_button)
			horizontal_box.extend (accept_button)
			horizontal_box.extend (cancel_button)
			set_default_push_button (accept_button)
			accept_button.select_actions.extend (agent hide_and_set)
			cancel_button.select_actions.extend (agent hide)
			show_actions.extend (agent name_field.set_focus)
				-- We must never return a void, name.
			name := ""
		end
		
	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		do
			name := a_name
			name_field.set_text (name)
		end
		
	name: STRING
		-- The name currently  
		
feature {NONE} -- Implementation
	
	
	hide_and_set is
			-- Hide `Current' and set `name'.
		local
			warning: EV_WARNING_DIALOG
		do
				-- Components use the same naming convention
				-- as class names.
			if valid_class_name (name_field.text) then
				hide
				name := name_field.text
			else
				create warning.make_with_text ("`" + name_field.text + "'" + Component_name_warning)
				warning.show_modal_to_window (Current)
			end
		end
		
	name_field: EV_TEXT_FIELD
		-- The entry field for new name.
	
end -- class GB_NAMER_DIALOG

indexing
	description: "Builds an attribute editor for modification of objects of type EV_SENSITIVE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_SENSITIVE_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_SENSITIVE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_SENSITIVE"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			create Result
			initialize_attribute_editor (Result)
			create check_button.make_with_text (gb_ev_sensitive_is_sensitive)
			check_button.set_tooltip (gb_ev_sensitive_is_sensitive_tooltip)
			update_attribute_editor
			Result.extend (check_button)
			check_button.select_actions.extend (agent toggle_sensitivity)
			check_button.select_actions.extend (agent update_editors)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			check_button.select_actions.block
			if first.is_sensitive then
				check_button.enable_select
			else
				check_button.disable_select
			end
			check_button.select_actions.resume
		end

feature {NONE} -- Implementation

	check_button: EV_CHECK_BUTTON
		-- Check button used for setting attribute.
	
	toggle_sensitivity is
			-- Update sensitive state.
		do
			if check_button.is_selected then
				for_first_object (agent {EV_SENSITIVE}.enable_sensitive)
			else
				for_first_object (agent {EV_SENSITIVE}.disable_sensitive)
			end
		end

	-- Constants for XML
	
	is_sensitive_string: STRING is "Is_sensitive"

end -- class GB_EV_SENSITIVE_EDITOR_CONSTRUCTOR

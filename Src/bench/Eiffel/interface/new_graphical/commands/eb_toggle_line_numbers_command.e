indexing
	description: "Toggle line numbers in editors."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TOGGLE_LINE_NUMBERS_COMMAND

inherit
	EB_MENUABLE_COMMAND

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end
	
create	
	make
	
feature -- Initialization

	make is	
			-- New command
		do
			initialize	
		end		
	
feature -- Execution

	initialize is
			-- Initialize
		do
			create accelerator.make_with_key_combination (create {EV_KEY}.make_with_code (key_constants.key_l), True, False, False)
			accelerator.actions.extend (agent execute)	
			enable_sensitive
		end

	execute is
			-- Execute the command.
		do
			preferences.editor_data.show_line_numbers_preference.set_value (not preferences.editor_data.show_line_numbers)
		end

feature {NONE} -- Implementation

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_line_numbers
		end

end

indexing

	description:
		"A tool button for the preference tool.";
	date: "$Date$";
	revision: "$Revision$"

deferred class PREFERENCE_BUTTON

inherit
	ISE_BUTTON
		rename
			make as ise_button_make
		end

feature {NONE} -- Initialization

	make (cmd: PREFERENCE_CATEGORY; a_parent: COMPOSITE) is
			-- Initialize Current
		do
			ise_button_make (button_name, a_parent);
			set_focus_string (cmd.name)
			set_symbol (cmd.symbol);
			add_activate_action (cmd, cmd.name);
			initialize_focus 
		end

feature -- Access

	symbol: PIXMAP is
			-- Not needed
		do
		end

feature -- Status Setting

	set_selected (b: BOOLEAN) is
		do
			set_pressed (b)
		end;

end -- class PREFERENCE_BUTTON

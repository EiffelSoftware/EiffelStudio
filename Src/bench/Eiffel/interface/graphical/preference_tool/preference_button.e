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
		redefine
			set_sensitive, set_insensitive
		end

feature {NONE} -- Initialization

	make (cmd: PREFERENCE_CATEGORY; a_parent: COMPOSITE) is
			-- Initialize Current
		do
			ise_button_make (button_name, a_parent);
			focus_string := cmd.name;
			symbol := cmd.symbol;
			dark_symbol := cmd.dark_symbol;
			set_symbol (symbol);
			add_activate_action (cmd, cmd.name);
			initialize_focus 
		end

feature -- Access

	symbol: PIXMAP;
			-- The pixmap representing Current.

	dark_symbol: PIXMAP;
			-- Dark version of `symbol'

	focus_string: STRING
			-- String to display on the focus

feature -- Status Setting

	set_selected (b: BOOLEAN) is
			-- Set the shown pixmap to `dark_symbol' if `b', otherwise to
			-- `symbol'.
		do
			if b then
				set_symbol (dark_symbol)
			else
				set_symbol (symbol)
			end
		end;

feature {NONE} -- Useless

	set_insensitive is do end;

	grey_symbol: PIXMAP is do end;

	set_sensitive is do end;

end -- class PREFERENCE_BUTTON

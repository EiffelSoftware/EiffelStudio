indexing

	description:
		"Abstract notion of a tool button.";
	date: "$Date$";
	revision: "$Revision$"

class FORMAT_BUTTON

inherit
	EB_BUTTON
		redefine
			make, associated_command
		end;
	WINDOWS

creation
	make

feature {NONE} -- Initialization

	make (cmd: FORMATTER; a_parent: COMPOSITE) is
		do
			associated_command := cmd;
			button_make (button_name, a_parent);
			set_symbol (cmd.symbol);
			add_activate_action (cmd, cmd.tool);
			initialize_focus 
		end;

feature -- Access

	dark_symbol: PIXMAP is
			-- Dark version of `symbol'
		do
			Result := associated_command.dark_symbol
		end;

feature -- Status Setting

	set_selected (b: BOOLEAN) is
			-- Darken the symbol of current button if `b', lighten it otherwise.
		do
			if b then
				set_symbol (dark_symbol)
			else
				set_symbol (symbol)
			end
		end;

feature {NONE} -- Properties

	associated_command: FORMATTER

end -- class FORMAT_BUTTON

indexing

	description:
		"Abstract notion of a tool button.";
	date: "$Date$";
	revision: "$Revision$"

class EB_BUTTON

inherit
	ISE_BUTTON
		rename
			make as button_make
		end;
	WINDOWS

creation
	make

feature {NONE} -- Initialization

	make (cmd: ICONED_COMMAND; a_parent: COMPOSITE) is
		do
			associated_command := cmd;
			button_make (button_name, a_parent);
			set_symbol (cmd.symbol);
			add_activate_action (cmd, cmd.tool);
			initialize_focus (a_parent)
		end;

feature -- Access

	symbol: PIXMAP is
			-- The pixmap representing Current.
		do
			Result := associated_command.symbol
		end;

	dark_symbol: PIXMAP is
			-- Dark version of `symbol'
		do
			Result := associated_command.dark_symbol
		end;

	grey_symbol: PIXMAP is
			-- Insensitive version of `symbol'
		do
			Result := associated_command.grey_symbol
		end;

	focus_string: STRING is
		do
			Result := associated_command.name
		end

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

	set_sensitive is
			-- Make Current sensitive for user input.
		do
			set_symbol (symbol)
		end;

	set_insensitive is
			-- Make Current insensitive for user input.
		do
			set_symbol (grey_symbol)
		end;

	set_symbol (p: PIXMAP) is
			-- Set the pixmap if it it valid
		do
			if p.is_valid then
				set_pixmap (p)
			end;
		end;

feature {NONE} -- Implementation

	focus_label: FOCUS_LABEL_I is
			-- Focus label for Current.
		once
			!FOCUS_LABEL! Result.initialize (Project_tool)
		end

feature {NONE} -- Properties

	associated_command: ICONED_COMMAND

end -- class EB_BUTTON

indexing

	description:
		"Abstract notion of a tool button.";
	date: "$Date$";
	revision: "$Revision$"

class EB_BUTTON

inherit
	PICT_COLOR_B
		rename
			make as button_make
		end
	FOCUSABLE

creation
	make

feature {NONE} -- Initialization

	make (cmd: like associated_command; a_parent: COMPOSITE) is
		do
			associated_command := cmd;
			button_make (button_name, a_parent);
			set_symbol (cmd.symbol)
			add_activate_action (cmd, cmd.text_window);
			initialize_focus;
		end;

feature -- Properties

	associated_command: ICONED_COMMAND_2;
			-- The associated command.

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

	focus_source: WIDGET is
			-- Widget representing Current on the screen.
		do
			Result := Current
		end;

	focus_string: STRING is
		local
			s: STRING
		do
			s := clone (associated_command.name);
			s.append (" DONE");
			Result := s
		end

feature -- Status Setting

	darken (b: BOOLEAN) is
			-- Darken the symbol of current button if `b', lighten it otherwize
		do
			if b then
				set_symbol (dark_symbol)
			else
				set_symbol (symbol)
			end
		end;

feature {NONE} -- Properties

	button_name: STRING is "push_b"

feature {NONE} -- Implementation

	set_symbol (p: PIXMAP) is
			-- Set the pixmap if it it valid
		require
			non_void_arg: p /= Void
		do
			if p.is_valid then
				set_pixmap (p)
			end;
		end;

end -- class EB_BUTTON

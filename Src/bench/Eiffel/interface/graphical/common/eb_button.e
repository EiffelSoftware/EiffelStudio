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
	WINDOWS;
	WIDGET_ROUTINES

create
	make,
	make_without_action

feature {NONE} -- Initialization

	make (cmd: PIXMAP_COMMAND; a_parent: COMPOSITE) is
			-- Initialize button  and automatically add the activate
			-- action callback to current button.
		do
			associated_command := cmd;
			button_make (button_name, a_parent);
			init_button (implementation);
			set_symbol (cmd.symbol);
			add_activate_action (cmd, cmd.tool);
			set_focus_string (associated_command.name)
			initialize_focus 
		end;

	make_without_action (cmd: PIXMAP_COMMAND; a_parent: COMPOSITE) is
			-- Initialize button  and do not add the activate
			-- action callback to current button.
		do
			associated_command := cmd;
			button_make (button_name, a_parent);
			init_button (implementation);
			set_symbol (cmd.symbol);
			set_focus_string (associated_command.name)
			initialize_focus 
		end;

feature -- Element change

	add_third_button_action is
			-- Add the `associated_command' to the third mouse button action.
		do
			add_button_press_action (3, associated_command,
				associated_command.button_three_action)
		end;

feature -- Access

	symbol: PIXMAP is
			-- The pixmap representing Current.
		do
			Result := associated_command.symbol
		end;

feature {NONE} -- Properties

	associated_command: PIXMAP_COMMAND

end -- class EB_BUTTON

indexing

	description:
		"Menu entry for the preference tool.";
	date: "$Date$";
	revision: "$Revision$"

class PREFERENCE_MENU_ENTRY

inherit
	PUSH_B
		rename
			make as button_make
		end;
	ISE_MENU_ENTRY
		redefine
			associated_command
		end

create
	make

feature -- Access

	associated_command: PREFERENCE_COMMAND is
			-- Command type that menu entry expects
		do
		end;

feature -- Status setting

	set_menu_text (a_text: STRING; an_acc: STRING) is
			-- Set the menu text to `a_text' and if there
			-- is `an_acc' then set the accelerator.
		require
			valid_text: a_text /= Void
		do
			set_text (a_text);
			if an_acc /= Void then	
				set_accelerator_action (an_acc)
			end
		end

feature -- Initialization

	make (a_cmd: like associated_command; a_parent: MENU) is
			-- Initialize button.
		do
			button_make (t_Empty, a_parent);
			add_activate_action (a_cmd, Void)
		end;

	t_Empty: STRING is "";

end -- class PREFERENCE_MENU_ENTRY

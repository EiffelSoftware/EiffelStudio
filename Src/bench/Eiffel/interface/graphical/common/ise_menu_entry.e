indexing

	description:
		"Abstract notion of a menu entry.";
	date: "$Date$";
	revision: "$Revision$"

deferred class ISE_MENU_ENTRY

feature {NONE} -- Initialization

	make (a_cmd: like associated_command; a_parent: MENU) is
		require
			non_void_cmd: a_cmd /= Void;
			non_void_parent: a_parent /= Void;
		deferred
		end;

feature -- Properties

	text: STRING is
			-- Text as displayed on the button.
		deferred
		end;

	associated_command: COMMAND is
			-- Command type that menu entry expects
		require
			never_be_called: false
		do
		end;

feature -- Status setting

	set_text (a_string: STRING) is
			-- Set the text to `a_string'.
		deferred
		end;

feature {NONE} -- Properties

	menu_entry_name: STRING is "menu_entry"

end -- class MENU_ENTRY

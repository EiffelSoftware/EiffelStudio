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

	insensitive: BOOLEAN is
			-- Is current widget insensitive to
			-- user actions? (If it is, events will
			-- not be dispatched to Current widget or
			-- any of its children)
		deferred
		end;

feature -- Status setting

	set_text (a_string: STRING) is
			-- Set the text to `a_string'.
		deferred
		end;

	set_insensitive is
			-- Make Current widget insensitive
		deferred
		end;

	set_sensitive is
			-- Make Current widget sensitive.
		deferred
		end;

feature {NONE} -- Properties

	menu_entry_name: STRING is "menu_entry"

end -- class MENU_ENTRY

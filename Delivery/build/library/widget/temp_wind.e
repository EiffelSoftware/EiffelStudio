indexing

	description:
		"Widget: Temporary window.%
		% A window that can be popped up and popped down.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TEMP_WIND 

inherit

	EB_BULLETIN_D

creation

	make
	
feature -- Not to be put in ebuild library in delivery
	
	set_parent_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
			-- Set `a_command' to be executed when `a_translation' for parent occurs.
			-- `a_translation' must be specified with the X toolkit conventions.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		do
			dialog_command_target;
			set_action (a_translation, a_command, argument);
			widget_command_target;
		end;

	remove_parent_action (a_translation: STRING) is
			-- Remove the command executed when `a_translation' for the parent occurs.
			-- Do nothing if no command has been specified.
		do
			dialog_command_target;
			remove_action (a_translation);
			widget_command_target;
		end;

end

--|----------------------------------------------------------------
--| EiffelBuild library.
--| Copyright (C) 1995 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

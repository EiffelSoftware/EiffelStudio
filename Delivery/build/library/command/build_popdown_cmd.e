indexing

	description:
		"EiffelBuild predefined command for %
		%popping down a temporary window.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class BUILD_POPDOWN_CMD 

inherit

	BUILD_CMD

creation

	make

feature -- Initialization

	make (arg1: TEMP_WIND) is
			-- Initialize command relative to `arg1'.
		do
			argument1 := arg1
		end;

feature -- Access

	argument1: TEMP_WIND;
			-- The command's argument

	popdown_label: STRING is "popdown";
			-- Text of label for Popdown transition

feature -- Execution

	execute is
			-- Set transition to `popdown_label' and popdown
			-- `argument1'.
		do
			set_transition_label (popdown_label);
			argument1.popdown
		end;

end -- class BUILD_POPDOWN

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

indexing

	description:
		"General notion of an undoable command.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"


deferred class BUILD_UNDOABLE_CMD

inherit

   BUILD_CMD

feature

   redo is
			-- Re-execute Current command.
			-- (After it has previously been
			-- executed).
	  deferred
	  end;

   undo is
			-- Undo the effect of execution
			-- of Current command.
	  deferred
	  end;

end -- class BUILD_UNDOABLE_CMD

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


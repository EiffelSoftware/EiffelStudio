indexing

	description: "General pulldown menu implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class PULLDOWN_I 

inherit

	MENU_I
	
feature 

	text: STRING is
			-- Label of menu button
		deferred
		end; -- text

	set_text (a_text: STRING) is
			-- Set button text to `a_text'.
		deferred
		end; -- text

	allow_recompute_size is
		deferred
		end;

	forbid_recompute_size is
		deferred
		end;

end -- class PULLDOWN_I


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

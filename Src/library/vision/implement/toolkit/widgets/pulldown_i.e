indexing

	description: "General pulldown menu implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	PULLDOWN_I 

inherit

	MENU_I
	
feature -- Access

	text: STRING is
			-- Label of menu button
		deferred
		end;

feature -- Status setting

	allow_recompute_size is
		deferred
		end;

	forbid_recompute_size is
		deferred
		end;

feature -- Element change

	set_text (a_text: STRING) is
			-- Set button text to `a_text'.
		deferred
		end;

end -- class PULLDOWN_I



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


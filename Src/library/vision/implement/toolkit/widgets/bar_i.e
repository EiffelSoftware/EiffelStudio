indexing

	description: "General menu bar implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	BAR_I 

inherit

	MENU_I


	
feature -- Access

	help_button: MENU_B is
			-- Menu Button which appears at the lower right corner of the
			-- menu bar
		deferred
		end;

feature -- Status setting


	allow_recompute_size is
		deferred
		end;

	forbid_recompute_size is
		deferred
		end

feature -- Element change

	set_help_button (button: MENU_B) is
			-- Set the Menu Button which appears at the lower right corner
			-- of the menu bar.
		deferred
		ensure
			same_button: help_button.same (button)
		end;

end -- class BAR_I



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


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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------


indexing

	description: "General menu bar implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class BAR_I 

inherit

	MENU_I


	
feature 

	help_button: MENU_B is
            -- Menu Button which appears at the lower right corner of the
            -- menu bar
        deferred
		end;

    set_help_button (button: MENU_B) is
            -- Set the Menu Button which appears at the lower right corner
            -- of the menu bar.
        deferred
        ensure
            help_button.same (button)
		end;

	allow_recompute_size is
		deferred
		end;

	forbid_recompute_size is
		deferred
		end;


end -- class BAR_I


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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

indexing

	description: 
		"EiffelVision bar, gtk implementation.";
	status: "See notice at end of class";
	id: "$id: $";
	date: "$Date$";
	revision: "$Revision$"
	
class
	BAR_IMP

inherit

	BAR_I
	MENU_IMP	

creation

	make

feature {NONE} -- Initialization

	make (a_bar: BAR; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif bar menu.
		do
			check
				not_be_called: false
			end
			
		end;


feature -- Access

	help_button: MENU_B is
			-- Menu Button which appears at the lower right corner of the
			-- menu bar
		do
			check
				not_be_called: False
			end

		end;

feature -- Status setting


	allow_recompute_size is
		do
			check
				not_be_called: False
			end

		end;

	forbid_recompute_size is
		do
			check
				not_be_called: False
			end

		end

feature -- Element change

	set_help_button (button: MENU_B) is
			-- Set the Menu Button which appears at the lower right corner
			-- of the menu bar.
		do
			check
				not_be_called: False
			end

		end;

end -- class BAR_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

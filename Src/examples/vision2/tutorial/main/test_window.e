indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	TEST_WINDOW
inherit

	--DEMO_WINDOW
	--	rename
	--		make as demo_make
	--	end
		
	EV_HORIZONTAL_BOX
		redefine
			make
		end



creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We create the box first without parent because it
			-- is faster.
	
		do
			{EV_HORIZONTAL_BOX} Precursor (Void)

			set_homogeneous (False)
			!!test_but.make_with_text (Current,"TEST BUTTON")
			!!test_but2.make_with_text (Current,"TEST BUTTON")

			set_parent (par)
		end

feature -- Access

	test_but ,test_but2: EV_BUTTON

end -- class BUTTON_WINDOW
--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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


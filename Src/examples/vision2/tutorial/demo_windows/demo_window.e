indexing
	description:
		"Demo window, ancestor of all the window of%
		% demonstration";
	date: "$Date$";
	revision: "$Revision$"

class
	DEMO_WINDOW

creation
	make_demo

feature {NONE} -- Initialization

	make_demo (par: EV_CONTAINER; a_title: STRING) is
			-- Create the demo in `par'.
			-- Need to be redefine
		do
			check
				is_redefined: False
			end
		end

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
			-- Need to be undefine
		do
			check
				is_undefined: False
			end
		end

end -- class DEMO_WINDOW

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
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

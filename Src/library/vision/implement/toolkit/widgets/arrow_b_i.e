indexing

	description:
		"Button drawn on screen with an arrow";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	ARROW_B_I 

inherit

	BUTTON_I
	
feature -- Status report

	down: BOOLEAN is
			-- Is the arrow direction down ?
		deferred
		end;

	left: BOOLEAN is
			-- Is the arrow direction left ?
		deferred
		end;

	right: BOOLEAN is
			-- Is the arrow direction right ?
		deferred
		end;

	up: BOOLEAN is
			-- Is the arrow direction up ?
		deferred
		end

feature -- Status setting

	set_down is
			-- Set the arrow direction to down.
		deferred
		end;

	set_left is
			-- Set the arrow direction to left.
		deferred
		end;

	set_right is
			-- Set the arrow direction to right.
		deferred
		end;

	set_up is
			-- Set the arrow direction to up.
		deferred
		end;

end -- class ARROW_B_I

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



-- General primitive implementation.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class PRIMITIVE_I 

inherit

	WIDGET_I;

	STACKABLE_I;

feature 

	foreground: COLOR is
			-- Foreground color of primitive widget
		deferred
		end;

	set_foreground (new_color: COLOR) is
			-- Set foreground color to `new_color'.
		require
			color_not_void: not (new_color = Void)
		deferred
		ensure
			foreground= new_color
		end;

    update_foreground is
            -- Update the X color after a change inside the Eiffel color.
        deferred
        end;

end


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

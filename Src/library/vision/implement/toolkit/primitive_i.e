indexing

	description: "General primitive implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	PRIMITIVE_I 

inherit

	WIDGET_I;

	STACKABLE_I;

feature -- Access

	foreground_color: COLOR is
			-- Foreground color of primitive widget
		deferred
		ensure
			valid_result: Result /= Void
		end;

feature -- Status setting

	update_foreground_color is
		deferred
		end;

feature -- Element change

	set_foreground_color (new_color: COLOR) is
			-- Set foreground color to `new_color'.
		require
			valid_color: new_color /= Void
		deferred
		ensure
			foreground_set: foreground_color = new_color
		end;

end -- class PRIMITIVE_I

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


indexing

	description: "General manager implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class MANAGER_I 

inherit

	COMPOSITE_I;

	STACKABLE_I;

feature 

	foreground_color: COLOR is
			-- Foreground color of manager widget
		deferred
		end;

	foreground: COLOR is obsolete "Use ``foreground_color''"
			-- Foreground color of manager widget
		do
			Result := foreground_color
		end;

	set_foreground_color (new_color: COLOR) is
			-- Set foreground color to `new_color'.
		require
			color_not_void: not (new_color = Void)
		deferred
		ensure
			foreground_color = new_color
		end;

	set_foreground (new_color: COLOR) is obsolete "Use ``set_foreground_color''"
			-- Set foreground color to `new_color'.
		do
			set_foreground_color (new_color)
		end;

	update_foreground is obsolete "Use ``update_foreground_color''"
		do
			update_foreground_color
		end;

	update_foreground_color is
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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

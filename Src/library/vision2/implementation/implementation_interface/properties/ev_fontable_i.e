indexing
	description: "EiffelVision fontable, implementation interface.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_FONTABLE_I 

inherit
	EV_ANY_I

feature -- Access

	font: EV_FONT is
			-- Font name of label
		require
			exists: not destroyed
		deferred
		end

feature -- Element change

	set_font (a_font: EV_FONT) is
			-- Set font label to `font_name'.
		require
			exists: not destroyed
			valid_font: a_font.is_valid
			a_font_specified: a_font.is_specified
		deferred
		end

end -- class EV_FONTABLE_I

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


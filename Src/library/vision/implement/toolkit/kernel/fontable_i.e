indexing

	description: "Widgets which define a font";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	FONTABLE_I 

feature -- Access

	font: FONT is
			-- Font name of label
		deferred
		end

feature -- Element change

	set_font (a_font: FONT) is
			-- Set font label to `font_name'.
		require
			a_font_exists: a_font /= Void
			a_font_specified: a_font.is_specified
		deferred
		end

end -- class FONTABLE_I



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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


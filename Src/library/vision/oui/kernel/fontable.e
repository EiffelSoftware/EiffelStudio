
-- Widget who can change its font.

indexing

	date: "$Date$";
	revision: "$Revision$"

class FONTABLE 

feature 

	font: FONT is
			-- Font name of label
		do
			Result := implementation.font
		end; -- font

feature {G_ANY, WIDGET_I, TOOLKIT}

	implementation: FONTABLE_I;
			-- Implementation of widget

feature 

	set_font (a_font: FONT) is
			-- Set font label to `font_name'.
		require
			a_font_exists: not (a_font = Void);
			a_font_specified: a_font.is_specified
		do
			implementation.set_font (a_font)
		end; -- set_font

	set_font_name (a_font_name: STRING) is
			-- Set font label to `a_font_name'.
		require
			a_font_name_exists: not (a_font_name = Void);
		local
			a_font: FONT;
		do
			!! a_font.make;
			a_font.set_name (a_font_name);
			set_font (a_font);
		end;

feature {G_ANY, WIDGET_I, TOOLKIT}

	set_font_imp (an_implementation: FONTABLE_I) is
			-- Set `implementation' to `an_implementation'.
		require
			an_implementation_exists: not (an_implementation = Void)
		do
			implementation := an_implementation
		end -- set_font_imp

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

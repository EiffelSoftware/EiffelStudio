indexing

	description: "Widget which can change its font";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	FONTABLE 

feature -- Access

	font: FONT is
			-- Font name of label
		require
			exists: not destroyed
		do
			Result := implementation.font
		end;

feature -- Status report

	destroyed: BOOLEAN is
			-- Is current object destroyed
		deferred
		end;

feature -- Element change

	set_font (a_font: FONT) is
			-- Set font label to `font_name'.
		require
			exists: not destroyed;
			a_font_exists: a_font /= Void
			a_font_specified: a_font.is_specified
		do
			implementation.set_font (a_font)
		end;

	set_font_name (a_font_name: STRING) is
			-- Set font label to `a_font_name'.
		require
			exists: not destroyed;
			a_font_name_exists: a_font_name /= Void
		local
			a_font: FONT;
		do
			!! a_font.make;
			a_font.set_name (a_font_name);
			set_font (a_font);
		end;

feature {G_ANY, WIDGET_I, TOOLKIT} -- Implementation

	implementation: FONTABLE_I;
			-- Implementation of widget

feature {G_ANY, WIDGET_I, TOOLKIT} -- Implementation

	set_font_imp (an_implementation: FONTABLE_I) is
			-- Set `implementation' to `an_implementation'.
		require
			an_implementation_exists: an_implementation /= Void
		do
			implementation := an_implementation
		end

end -- class FONTABLE



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


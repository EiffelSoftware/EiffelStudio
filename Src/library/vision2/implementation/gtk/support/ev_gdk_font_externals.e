indexing
	description:
	" Externals C function of Gdk and Gtk specific for the%
	% fonts."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GDK_FONT_EXTERNALS

feature

	c_gdk_font_ascent (font: POINTER): INTEGER is
		external
			"C [macro %"gdk_eiffel.h%"]"
		end

	c_gdk_font_descent  (font: POINTER): INTEGER is
		external
			"C [macro %"gdk_eiffel.h%"]"
		end

end -- class EV_GDK_FONT_EXTERNALS


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


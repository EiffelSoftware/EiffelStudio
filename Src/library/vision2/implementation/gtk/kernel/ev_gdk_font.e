indexing
	description: "Eiffel Vision GDK font. (for GTK implementation.) %N%
		%Objects that have a reference to a GdkFont, and the fully %N%
		%matched string that it is loaded from."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GDK_FONT

inherit
	EV_C_UTIL

create
	make

feature {NONE} -- Initialization

	make (a_full_name: STRING) is
			-- Initialize.
		require
			a_full_name_not_void: a_full_name /= Void
		do
			full_name := a_full_name
			load
		end

feature {NONE} -- Implementation

	load is
			-- Load font specified in `full_name'.
		local
			temp_string: ANY
		do
			temp_string := full_name.to_c
			c_object := C.gdk_font_load ($temp_string)
		end

	destroy is
			-- Unreference font.
		do
			C.gdk_font_unref (c_object)
		end

feature -- Access

	full_name: STRING

	c_object: POINTER

end -- class EV_GDK_FONT


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


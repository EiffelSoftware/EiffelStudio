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
		do
			c_object := C.gdk_font_load (eiffel_to_c (full_name))
		end

	destroy is
			-- Unreference font.
		do
			C.gdk_font_unref (c_object)
		end

	C: EV_C_EXTERNALS is
		once
			create Result
		end

feature -- Access

	full_name: STRING

	c_object: POINTER

end -- class EV_GDK_FONT

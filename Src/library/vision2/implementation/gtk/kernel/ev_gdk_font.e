indexing
	description: "Eiffel Vision GDK font. (for GTK implementation.) %N%
		%Objects that have a reference to a GdkFont, and the fully %N%
		%matched string that it is loaded from."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GDK_FONT

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
			a_cs: EV_GTK_C_STRING
		do
			create a_cs.make (full_name)
			c_object := {EV_GTK_EXTERNALS}.gdk_font_load (a_cs.item)
		end

	destroy is
			-- Unreference font.
		do
			{EV_GTK_EXTERNALS}.gdk_font_unref (c_object)
		end

feature -- Access

	full_name: STRING

	c_object: POINTER

end -- class EV_GDK_FONT

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------


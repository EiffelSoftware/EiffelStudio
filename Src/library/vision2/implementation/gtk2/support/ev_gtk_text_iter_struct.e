indexing
	description: 
		"GtkTextIter Struct helper class"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_TEXT_ITER_STRUCT

inherit
	MEMORY_STRUCTURE
	
create
	make

feature {NONE} -- Externals

	structure_size: INTEGER is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"sizeof(GtkTextIter)"
		end

end -- EV_GTK_TEXT_ITER_STRUCT

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

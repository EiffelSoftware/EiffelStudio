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

feature -- Externals

	frozen structure_size: INTEGER is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"sizeof(GtkTextIter)"
		end

end -- EV_GTK_TEXT_ITER_STRUCT

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


indexing
	description: "Objects that is a pixmap with an id."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_IDENTIFIED_PIXMAP
	
create
	make_with_id
	
feature {NONE} -- Initialisation

	make_with_id (a_pixmap: like pixmap; an_id: like id) is
			-- Create an EV_IDENTIFIED_PIXMAP containing `a_pixmap' with `an_id'.
		require
			a_pixmap_not_Void: a_pixmap /= Void
			an_id_positive: an_id > 0
		do
			pixmap := a_pixmap
			id := an_id
		ensure
			set: pixmap = a_pixmap and id = an_id
		end

feature -- Access

	pixmap: EV_PIXMAP
		-- Font
	
	id: INTEGER
		-- id for `pixmap'.
	
invariant
	pixmap_not_Void: pixmap /= Void
	id_positive: id >= 0

end -- class EV_IDENTIFIED_PIXMAP

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


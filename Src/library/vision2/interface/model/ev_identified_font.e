indexing
	description: "Objects that is an font with an id (for EV_SCALED_FONT_FACTORY)."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_IDENTIFIED_FONT
	
create
	make_with_id
	
feature {NONE} -- Initialisation

	make_with_id (a_font: like font; an_id: like id) is
			-- Create an EV_IDENTIFIED_FONT containing `a_font' with `an_id'.
		require
			a_font_not_void: a_font /= Void
			an_id_positive: an_id > 0
		do
			font := a_font
			id := an_id
		ensure
			set: font = a_font and id = an_id
		end

feature -- Access

	font: EV_FONT
		-- Font
	
	id: INTEGER
		-- id for `font'.
	
invariant
	font_not_void: font /= Void
	id_positive: id >= 0

end -- class EV_IDENTIFIED_FONT

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


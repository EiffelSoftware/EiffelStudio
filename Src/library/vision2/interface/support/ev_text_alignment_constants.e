indexing
	description: "Constants for use by and with EV_TEXT_ALIGNABLE."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT_ALIGNMENT_CONSTANTS

feature -- Constants

	Ev_text_alignment_left: INTEGER is 1
		-- Aligned left.
		
	Ev_text_alignment_center: INTEGER is 2
		-- Aligned center.
		
	Ev_text_alignment_right: INTEGER is 3
		-- Aligned right.
		
feature -- Contract support

	valid_alignment (an_alignment: INTEGER): BOOLEAN is
			-- Is `an_alignment' a valid alignment?
		do
			Result := an_alignment = Ev_text_alignment_left or else
				an_alignment = Ev_text_alignment_center or else
				an_alignment = Ev_text_alignment_right	
		end

end -- class EV_TEXT_ALIGNMENT_CONSTANTS

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


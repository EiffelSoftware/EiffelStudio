indexing
	description: "EiffelVision generic rich text event data. Implementation interface";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_RICH_TEXT_EVENT_DATA_I
	
inherit
	EV_EVENT_DATA_I	

feature -- Access	

	rich_text: EV_RICH_TEXT
			-- The mouse pointer was over this widget 
			-- when event happened

feature -- Element change

	set_all (a_rich_text: EV_RICH_TEXT) is
			-- Fill all the values of the data.
		do
			set_rich_text (a_rich_text)
		end

	set_rich_text (a_rich_text: EV_RICH_TEXT) is
			-- Make `a_rich_edit' the new widget.
		do
			rich_text := a_rich_text
		end

end -- class EV_RICH_TEXT_EVENT_DATA_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

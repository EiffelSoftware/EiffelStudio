indexing
	description: "EiffelVision radio button. Radio buttons are%
                     %similar to check buttons except that radio%
                     %buttons are grouped so that only one may be%
                     %selected at a time."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_BUTTON

inherit
	EV_CHECK_BUTTON
		redefine
			make_with_text,
			implementation
		end

creation
	make_with_text

feature -- Initialization

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- radio button with `par' as parent and `txt' as
			-- text label
		do
			!EV_RADIO_BUTTON_IMP!implementation.make_with_text (par, txt)
			widget_make (par)
		end

feature {NONE} -- Implementation

	implementation: EV_RADIO_BUTTON_I

	
end -- class EV_RADIO_BUTTON

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

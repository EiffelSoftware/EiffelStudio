indexing

	description: 
		"EiffelVision label, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_LABEL_I
	
inherit
	EV_PRIMITIVE_I
	
	EV_BAR_ITEM_I
	
	EV_TEXTABLE_I

	EV_FONTABLE_I

feature {NONE} -- Initialization

 	make_with_text (txt: STRING) is
			-- Create a widget with `txt' as text.
		require
			valid_string: txt /= Void
		deferred
        end	
	
end --class EV_LABEL_I

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

indexing	
	description: 
		"EiffelVision item. Implementation interface"
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_SIMPLE_ITEM_I

inherit
	EV_ITEM_I

	EV_PIXMAPABLE_I

feature {NONE} -- Initialization

	make_with_text (txt: STRING) is
			-- Create a row with text in it.
		require
			valid_text: txt /= Void
		deferred
		ensure
			text_set: text.is_equal (txt)
		end

feature -- Access

	text: STRING is
			-- Current label of the item
		require
			exists: not destroyed
		deferred
		ensure
			valid_result: Result /= Void
		end

feature -- Element change

	set_text (txt: STRING) is
			-- Make `txt' the new label of the item.
		require
			exists: not destroyed
			valid_text: txt /= Void
		deferred
		ensure
			text_set: text.is_equal (txt)
		end

end -- class EV_SIMPLE_ITEM_I

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

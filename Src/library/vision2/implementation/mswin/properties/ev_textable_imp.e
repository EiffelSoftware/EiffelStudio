--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"EiffelVision text container, gtk implementation"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXTABLE_IMP
	
inherit
	EV_TEXTABLE_I

feature -- Status setting

	align_text_center is
			-- Set text alignment of current label to center.
		deferred
           end

	align_text_right is
			-- Set text alignment of current label to right.
		deferred
		end

	align_text_left is
			-- Set text alignment of current label to left.
		deferred
		end
	
	destroyed: BOOLEAN is
		deferred
		end

	remove_text is
			-- Remove text by setting it to an empty string.
		do
			set_text ("")
		end

feature -- Inapplicable

	set_default_minimum_size is
			-- Set to the size of the text
		do
		end

end -- class EV_TEXTABLE_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.13  2000/02/14 11:40:40  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.6.3  2000/01/27 19:30:13  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.6.2  2000/01/10 17:15:32  rogers
--| The three alignment functions names have been changed to the format set_*****_algnment. Remove text has been implemented.
--|
--| Revision 1.12.6.1  1999/11/24 17:30:20  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.2.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

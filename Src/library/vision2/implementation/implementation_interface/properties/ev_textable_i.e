indexing
	description: 
		"EiffelVision textable. Implementation interface."
	status: "See notice at end of class"
	keywords: "text, label, font, name, property"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXTABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end
	
feature -- Access

	text: STRING is
			-- Text displayed in label.
		deferred
		end

	alignment: EV_TEXT_ALIGNMENT is
			-- Current text positioning.
		deferred
		end

feature -- Status setting

	align_text_center is
			-- Display `text' centered.
		deferred
		end

	align_text_left is
			-- Display `text' left aligned.
		deferred
		end

	align_text_right is
			-- Display `text' right aligned.
		deferred
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		require
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		deferred
		ensure
			text_assigned: text.is_equal (a_text)
		end

	remove_text is
			-- Make `text' `Void'.
		deferred
		ensure
			text_removed: text = Void
		end

feature {NONE} -- Implementation

	interface: EV_TEXTABLE
            -- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_TEXTABLE_I

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.13  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.12  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.11  2001/06/07 23:08:09  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.7.4.4  2000/11/29 00:35:59  rogers
--| Changed empty to is_empty.
--|
--| Revision 1.7.4.3  2000/08/24 21:50:22  rogers
--| Added alignment as deferred.
--|
--| Revision 1.7.4.2  2000/05/10 23:00:48  king
--| Changed set_text precond to use empty
--|
--| Revision 1.7.4.1  2000/05/03 19:08:59  oconnor
--| mergred from HEAD
--|
--| Revision 1.9  2000/02/22 18:39:42  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.8  2000/02/14 11:40:35  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.12  2000/02/04 04:00:11  oconnor
--| released
--|
--| Revision 1.7.6.11  2000/01/27 19:29:57  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.10  2000/01/18 19:33:32  oconnor
--| Removed inheritance of fontable,
--| ont all texables are actualy fontable as well,
--| those that are should now inherit fontable explicitly.
--|
--| Revision 1.7.6.9  2000/01/14 02:35:41  oconnor
--| comments
--|
--| Revision 1.7.6.8  2000/01/10 21:53:41  king
--| Removed invalid text_not_void invariant as we can have void text
--|
--| Revision 1.7.6.7  2000/01/10 20:04:51  king
--| Corrected text_not_void invariant
--|
--| Revision 1.7.6.6  2000/01/10 17:19:29  rogers
--| removed the text_not_void invariant, as it no longer is applicable.
--|
--| Revision 1.7.6.5  2000/01/07 17:16:34  oconnor
--| renamed allignment features, added remove_text
--|
--| Revision 1.7.6.4  2000/01/06 18:39:42  king
--| Improved comments.
--| Added invariant.
--|
--| Revision 1.7.6.3  1999/12/06 18:04:37  brendel
--| Added reference to interface.
--|
--| Revision 1.7.6.2  1999/12/01 01:02:33  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that relied
--| on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.7.6.1  1999/11/24 17:30:07  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

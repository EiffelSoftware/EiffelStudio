indexing
	description: "Eiffel Vision textable. Objects that have a text label."
	status: "See notice at end of class"
	keywords: "text, label, font, name, property"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXTABLE

inherit
	EV_ANY
		undefine
			create_action_sequences
		redefine
			implementation
		end

feature {NONE} -- Initialization

	make_with_text (a_text: STRING) is
			-- Create the textable and set `text' to `txt'
		require
			a_text_not_void: a_text /= Void
			a_text_not_empty: a_text.count > 0
			default_create_not_already_called: not default_create_called
		do
			default_create
			set_text (a_text)
		ensure
			text_assigned: text.is_equal (a_text)
		end
	
feature -- Access

	text: STRING is
			-- Text displayed in textable.
		do
			Result:= implementation.text
		ensure
			bridge_ok: (Result = implementation.text ) or else
				Result.is_equal (implementation.text)
		end 

feature -- Status setting

	align_text_center is
			-- Display `text' centered.
		do
			implementation.align_text_center
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			implementation.align_text_right
		end
        
	align_text_left is
			-- Display `text' left aligned.
		do
			implementation.align_text_left
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		require
			a_text_not_void: a_text /= Void
			a_text_not_empty: a_text.count > 0
		do
			implementation.set_text (a_text)
		ensure
			text_assigned: text.is_equal (a_text)
		end

	remove_text is
			-- Make `text' `Void'.
		do
			implementation.remove_text
		ensure
			text_removed: text = Void
		end

feature {EV_TEXTABLE_I} -- Implementation

	implementation: EV_TEXTABLE_I
            -- Responsible for interaction with the underlying native graphics
            -- toolkit.

feature -- Obsolete

	set_center_alignment is
			-- Display `text' centered.
		obsolete
			"Use: align_text_center."
		do
			implementation.align_text_center
		end

	set_right_alignment is
			-- Display `text' right aligned.
		obsolete
			"Use: align_text_right."
		do
			implementation.align_text_right
		end
        
	set_left_alignment is
			-- Display `text' left aligned.
		obsolete
			"Use: align_text_left."
		do
			implementation.align_text_left
		end

invariant
	text_not_void_implies_text_not_empty:
		is_useable and text /= Void implies text.count > 0

end -- class EV_TEXTABLE

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.13  2000/02/14 11:40:49  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.6.19  2000/02/08 09:43:40  oconnor
--| fixed text postcondition
--|
--| Revision 1.12.6.18  2000/02/04 21:17:19  king
--| Uncommented invariants, added make_with_text
--|
--| Revision 1.12.6.17  2000/01/28 20:00:11  oconnor
--| released
--|
--| Revision 1.12.6.16  2000/01/27 19:30:47  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.6.15  2000/01/27 18:05:41  brendel
--| Removed invariant about empty text.
--|
--| Revision 1.12.6.14  2000/01/19 23:23:08  oconnor
--| added  is_useable to text_not_void_implies_text_not_empty invariant
--|
--| Revision 1.12.6.13  2000/01/18 19:33:34  oconnor
--| Removed inheritance of fontable,
--| ont all texables are actualy fontable as well,
--| those that are should now inherit fontable explicitly.
--|
--| Revision 1.12.6.12  2000/01/17 02:43:15  oconnor
--| fixed comment for feature text
--|
--| Revision 1.12.6.11  2000/01/13 18:28:14  oconnor
--| tweaked comments
--|
--| Revision 1.12.6.10  2000/01/07 23:31:45  king
--| Added obsolete calls for previously replaced features.
--|
--| Revision 1.12.6.9  2000/01/07 22:55:07  king
--| Corrected spelling mistake in align_text_right
--|
--| Revision 1.12.6.8  2000/01/07 17:19:21  oconnor
--| renamed allignment features, added remove_text
--|
--| Revision 1.12.6.7  2000/01/06 18:37:20  king
--| Critical review. Removed some features; now only consists of text and
--| set_text
--| along with the alignment functions.
--|
--| Revision 1.12.6.6  1999/12/16 03:49:55  oconnor
--| mutiple inheritance of creation_action_sequences tweaked
--|
--| Revision 1.12.6.5  1999/12/16 03:45:48  oconnor
--| added width and height
--|
--| Revision 1.12.6.4  1999/12/06 18:01:29  brendel
--| Now inherits from EV_FONTABLE.
--|
--| Revision 1.12.6.3  1999/12/02 20:06:14  brendel
--| Commented out feature `parent_needed'.
--|
--| Revision 1.12.6.2  1999/11/29 23:14:13  brendel
--| Added keywords and changed tags on assertions.
--|
--| Revision 1.12.6.1  1999/11/24 17:30:48  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.2.4  1999/11/23 23:01:25  oconnor
--| undefine create_action_sequences on repeated inherit
--|
--| Revision 1.12.2.3  1999/11/04 23:10:54  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.12.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
 

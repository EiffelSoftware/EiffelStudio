indexing
	description: 
		"Eiffel Vision textable. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXTABLE_IMP
	
inherit
	EV_TEXTABLE_I
	
feature -- Access

	text: STRING is
			-- Text displayed in `Current'.
		do
			if text_length > 0 then
				Result := wel_text
			end
		end

	alignment: EV_TEXT_ALIGNMENT is
			-- Alignment of `text' on `Current'.
		do
			inspect text_alignment
				when text_alignment_left then 
					create Result.make_with_left_alignment
				when text_alignment_right then
					create Result.make_with_right_alignment
				when text_alignment_center then
					create Result.make_with_center_alignment
				end
		end

	text_alignment: INTEGER
			-- Current text alignment. Possible value are
			--	* Text_alignment_left
			--	* Text_alignment_right
			--	* Text_alignment_center

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			wel_set_text (a_text)
		end

	remove_text is
			-- Make `text' `Void'.
		do
			wel_set_text (create {STRING}.make (0))
		end

	align_text_center is
			-- Display `text' centered.
		do
			text_alignment := text_alignment_center
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			text_alignment := text_alignment_right
		end
        
	align_text_left is
			-- Display `text' left aligned.
		do
			text_alignment := text_alignment_left 	
		end

feature {NONE} -- Implementation

	Text_alignment_left: INTEGER is 0
			-- Left aligned text.

	Text_alignment_right: INTEGER is 1
			-- Right aligned text.

	Text_alignment_center: INTEGER is 2
			-- Centered text.

	wel_set_text (a_text: STRING) is
			-- Set `a_text' in WEL object.
		deferred
		end

	wel_text: STRING is
			-- Text from WEL object.
		deferred
		ensure
			not_void: Result /= Void
		end

	text_length: INTEGER is
			-- Length of text
		deferred
		ensure
			positive_length: Result >= 0
		end

	line_count: INTEGER is
			-- Number of lines required by `text'.
		do
			if text /= Void then
				Result := text.occurrences ('%N') + 1
			end
		ensure
			non_negative: Result >= 0
		end

feature -- Obsolete

	set_default_minimum_size is
			-- Set to the size of the text.
		obsolete
			"Implement using {EV_FONT_IMP}.text_metrics."
		do
			check
				inapplicable: False
			end
		end

end -- class EV_TEXTABLE_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--| Revision 1.25  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.12.4.7  2001/04/24 15:59:51  rogers
--| Removed all features which processed ampersands, as the new class
--| ev_internally_processed_textable_imp now contains these features.
--| Any class which must add extra ampersands internally will inherit
--| ev_internally_processed_textable_imp.
--|
--| Revision 1.12.4.6  2001/01/22 20:01:37  rogers
--| Removed obsolete feature `safe_text'.
--|
--| Revision 1.12.4.4  2000/08/24 21:58:26  rogers
--| Added alignment, text_alignment, align_text_center, align_text_right,
--| align_text_left And corresponding constants.
--|
--| Revision 1.12.4.3  2000/08/11 19:13:14  rogers
--| Fixed copyright clause. Now use ! instead of |.
--|
--| Revision 1.12.4.2  2000/06/05 16:50:40  manus
--| Added `text_length' in `EV_TEXTABLE_IMP' to improve the performance of its
--| counterpart `text' in order to reduce creation of useless empty strings.
--|
--| Revision 1.12.4.1  2000/05/03 19:09:16  oconnor
--| mergred from HEAD
--|
--| Revision 1.23  2000/04/10 18:25:52  brendel
--| Reverted to old imp of `text'.
--|
--| Revision 1.22  2000/04/07 22:50:00  brendel
--| Implementation improvement.
--|
--| Revision 1.21  2000/04/05 19:43:21  rogers
--| Minor formatting and comment change.
--|
--| Revision 1.20  2000/03/29 20:32:56  brendel
--| Fixed bugs in implementation and postconditions.
--|
--| Revision 1.19  2000/03/29 07:00:49  pichery
--| Commented bad postcondition after discussion with Sam.
--| Should be fixed by Vincent.
--|
--| Revision 1.18  2000/03/28 22:11:41  brendel
--| Added check for Void string.
--|
--| Revision 1.17  2000/03/28 00:04:23  brendel
--| Revised.
--| Changed feature order and comments with _I.
--| Removed redundant deferred redeclaration of align_* features.
--| Added deferred wel_set_text and wel_text, to be implemented by WEL object.
--| Added set_text, that uses wel_set_text to pass filtered text. See code.
--| Added text, that uses wel_text to retreive text with inverted filter.
--| Declared safe_text obsolete. wel_text can be used instead.
--|
--| Revision 1.16  2000/03/03 00:55:10  brendel
--| Added feature `line_count'.
--| Formatted for 80 columns.
--|
--| Revision 1.15  2000/02/25 18:03:26  brendel
--| Added feature `safe_text' that never returns a Void string.
--|
--| Revision 1.14  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.13  2000/02/14 11:40:40  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.6.3  2000/01/27 19:30:13  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.6.2  2000/01/10 17:15:32  rogers
--| The three alignment functions names have been changed to the format
--| set_*****_algnment. Remove text has been implemented.
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

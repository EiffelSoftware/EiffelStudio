indexing
	description: 
		"EiffelVision text component. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_COMPONENT_I
	
inherit
	EV_PRIMITIVE_I

	EV_TEXT_COMPONENT_ACTION_SEQUENCES_I

feature -- Access

	text: STRING is
			-- `Result' is text of `Current'.
		require
		deferred
		end

	text_length: INTEGER is
			-- Length of the text in `Current'.
		require
		deferred
		end

	selected_text: STRING is
			-- Text currently selected in `Current'.
		require
		do
			Result := text.substring (selection_start, selection_end)
		end

	maximum_character_width: INTEGER is
			-- Maximum width of a single character in `Current'.
		deferred
		end

	clipboard_content: STRING is
			-- `Result' is current clipboard content.
		deferred
		end

feature -- Status report

	is_editable: BOOLEAN is
			-- Is the text editable by the user?
		require
		deferred
		end

	caret_position: INTEGER is
			-- Current position of the caret.
		require
		deferred
		end

	has_selection: BOOLEAN is
			-- Does `Current' have a selection?
		require
		deferred
		end

	selection_start: INTEGER is
			-- Index of the first character selected.
		require
			has_selection: has_selection
		deferred
		ensure
			result_large_enough: Result >= 1
			result_small_enough: Result <= text_length
		end

	selection_end: INTEGER is
			-- Index of the last character selected.
		require
			has_selection: has_selection
		deferred
		ensure
			result_large_enough: Result >= 1
			result_small_enough: Result <= text_length
		end

	valid_caret_position (pos: INTEGER): BOOLEAN is
			-- Is `pos' a valid position for the caret?
		require
		do
			Result := pos >= 1 and pos <= text_length + 1			
		end

feature -- Status setting
	
	set_editable (flag: BOOLEAN) is
			-- if `flag' then make the component read-write.
			-- if not `flag' then make the component read-only.
		require
		deferred
		end

	set_caret_position (pos: INTEGER) is
			-- set current insertion position
		require
			position_large_enough: pos >= 1
			position_small_enough: pos <= text_length + 1
			is_editable: is_editable
		deferred
		end
	
feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to text of `Current'.
		deferred
		ensure
			text_set: a_text /= Void implies text.is_equal (a_text)
		end

	remove_text is
			-- Make `text' `Void'.
		do
			set_text (Void)
		ensure
			text_removed: text = Void
		end

	insert_text (txt: STRING) is
			-- Insert `txt' at the current caret position.
		require
			valid_text: txt /= Void
		deferred
		end
	
	append_text (txt: STRING) is
			-- append 'txt' into `Current'.
		require
			valid_text: txt /= Void
		deferred
		ensure
			text_appended:
		end
	
	prepend_text (txt: STRING) is
			-- prepend 'txt' into `Current'.
		require
			valid_text: txt /= Void
		deferred
		ensure
			text_prepended:
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make a minimum of `nb' of the widest character visible
			-- on one line.
		require
			valid_nb: nb > 0
		deferred
		end

feature -- Basic operation

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- `start_pos' and `end_pos'. Both `start_pos' and
			-- `end_pos' are selected.
		require
			valid_start: start_pos >= 1 and start_pos <= text_length
			valid_end: end_pos >= 1 and end_pos <= text_length
		deferred
		ensure
			has_selection: (start_pos /= end_pos) implies has_selection
			selection_start_set: selection_start = start_pos
			selection_end_set: selection_end = end_pos
		end	

	select_all is
			-- Select all the text of `Current'.
		require
			positive_length: text_length > 0
		do
			select_region (1, text.count)
		ensure
			has_selection: has_selection
			selection_start_set: selection_start = 1
			selection_end_set: selection_end = text_length
		end

	deselect_all is
			-- Unselect the current selection.
		require
		deferred
		ensure
			has_no_selection: not has_selection
		end

	delete_selection is
			-- Delete the current selection.
		require
			has_selection: has_selection
			is_editable: is_editable
		deferred
		ensure
			has_no_selection: not has_selection
		end

	cut_selection is
			-- Cut `selected_region' by erasing it from
			-- the text and putting it in the Clipboard to paste it later.
			-- If `selectd_region' is empty, it does nothing.
		require
			has_selection: has_selection
			is_editable: is_editable
		deferred
		end

	copy_selection is
			-- Copy `selected_region' into the Clipboard.
			-- If the `selected_region' is empty, it does nothing.
		require
			has_selection: has_selection
		deferred
		end

	paste (index: INTEGER) is
			-- Insert the contents of the clipboard 
			-- at `index' postion of `text'.
			-- If the Clipboard is empty, it does nothing. 
		require
			index_large_enough: index >= 1
			index_small_enough: index <= text_length + 1
			is_editable: is_editable
		deferred
		end

end -- class EV_TEXT_COMPONENT_I

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
--| Revision 1.40  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.39  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.38  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.35.2.14  2000/12/09 00:31:00  etienne
--| Undid unneeded last commit
--|
--| Revision 1.35.2.12  2000/10/27 22:13:19  rogers
--| Removed post condition on text and pre condition on set_text to fit in
--| with new behaviour. Modified post condition on set_text.
--|
--| Revision 1.35.2.11  2000/10/27 02:28:21  manus
--| Removed declaration or undefinition of `set_default_colors'. Now it is defined
--| in a platform dependent manner to improve performance and correctness.
--|
--| Revision 1.35.2.10  2000/10/26 22:11:28  rogers
--| To maintain consistency between EV_TEXTABLE and EV_TEXT_COMPONENT,
--| set_text now has a pre-condition that the text is not empty and a feature
--| `remove_text' has been added
--|
--| Revision 1.35.2.9  2000/09/07 17:06:06  rogers
--| Fixed post conditions on select_all. Select_All is now implemented using
--| select_region and is no longer deferred into the implementation.
--|
--| Revision 1.35.2.8  2000/09/07 16:14:10  king
--| Formatting
--|
--| Revision 1.35.2.7  2000/09/06 23:15:50  rogers
--| Added maximum_character_width and clipboard_content as deferred. These
--| are required for contract checking in EV_TEXT_COMPONENT.
--|
--| Revision 1.35.2.6  2000/09/06 15:18:56  rogers
--| Corrected valid_caret_position.
--|
--| Revision 1.35.2.5  2000/08/22 18:43:33  rogers
--| Fixed comment on set_minimum_width_in_characters.
--|
--| Revision 1.35.2.4  2000/08/17 23:55:17  rogers
--| removed fixme not_reviewed. Comments, formatting. Replaced commented
--| pre-condition. Removed commented old command association.
--|
--| Revision 1.35.2.3  2000/08/16 19:39:34  king
--| Removed restrictive is_editable precond from set_text
--|
--| Revision 1.35.2.2  2000/07/24 21:30:48  oconnor
--| inherit action sequences _I class
--|
--| Revision 1.35.2.1  2000/05/03 19:09:07  oconnor
--| mergred from HEAD
--|
--| Revision 1.37  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.36  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.35.4.6  2000/02/04 07:09:37  oconnor
--| removed obsolete command features
--|
--| Revision 1.35.4.5  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.35.4.4  2000/01/27 19:30:05  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.35.4.3  1999/12/30 01:59:25  rogers
--| changed position to caret_position , valid_position to valid_caret_position,
--| set_position to set_caret_position.
--|
--| Revision 1.35.4.2  1999/12/03 07:47:01  oconnor
--| make_rgb (int) -> make_with_rgb (real)
--|
--| Revision 1.35.4.1  1999/11/24 17:30:13  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.34.2.3  1999/11/04 23:10:45  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.34.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

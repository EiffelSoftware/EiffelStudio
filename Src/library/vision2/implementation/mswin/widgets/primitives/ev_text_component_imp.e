indexing
	description: "EiffelVision text component. Mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TEXT_COMPONENT_IMP

inherit
	EV_TEXT_COMPONENT_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			set_default_minimum_size,
			interface,
			initialize,
			wel_background_color,
			wel_foreground_color
		end

	EV_TEXT_COMPONENT_ACTION_SEQUENCES_IMP
 
feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			wel_set_font ((create {WEL_SHARED_FONTS}).gui_font)
			Precursor {EV_PRIMITIVE_IMP}
		end

	set_default_minimum_size is
			-- Called after creation. Set current size and
			-- notify parent.
		local
			log_font: WEL_LOG_FONT
		do
			log_font := wel_font.log_font
			ev_set_minimum_size (
				maximum_character_width * 4, internal_font_height +
				total_vertical_padding)
		end

	total_vertical_padding: INTEGER is 9
		-- Number of pixels to be added to height of font used internally,
		-- to give us minimum height of `Current'.

	internal_font_height: INTEGER is
			-- `Result' is height of font used by `Current'.
		local
			screen_dc: WEL_SCREEN_DC
			extent: WEL_SIZE
		do
			create screen_dc
			screen_dc.get
			screen_dc.select_font ((create {WEL_SHARED_FONTS}).gui_font)
			extent := screen_dc.string_size ("X")
			screen_dc.unselect_font 
			screen_dc.quick_release
			Result := extent.height
		end

feature {EV_ANY_I} -- Status report

	is_editable: BOOLEAN is
			-- Is text editable?
		do
			Result := not read_only
		end

	caret_position: INTEGER is
			-- Current position of caret.
		do
			Result := internal_caret_position + 1
		end

	selection_start: INTEGER is
			-- Index of first character selected.
		do
			Result := wel_selection_start + 1
		end

	selection_end: INTEGER is
			-- Index of last character selected.
		do
			Result := wel_selection_end
		end

feature {EV_ANY_I}-- Status setting

	set_editable (flag: BOOLEAN) is
				-- If `flag' then make `Current' editable else
				-- make `Current' component read-only.
			do
				if flag then
					set_read_write
				else
					set_read_only
				end
			end

	set_caret_position (pos: INTEGER) is
			-- set current caret position.
			--| This position is used for insertions.
		do
				-- We store `pos' so caret position can be restored
				-- after operations that should not move caret, but do.
			internal_set_caret_position (pos - 1)
		end

	set_capacity (value: INTEGER) is
			-- Make `value' new maximal length in characters of text.
		do
			set_text_limit (value)
		end

	capacity: INTEGER is
			-- Return maximum number of characters `Current' may hold.
		do
			Result := get_text_limit
		end

feature {EV_ANY_I}-- element change

	insert_text (txt: STRING) is
			-- Insert `txt' at `caret_position'.
		local
			temp_text: STRING
			previous_caret_position: INTEGER
		do
			previous_caret_position := caret_position
			temp_text := text
			if caret_position > temp_text.count then
				temp_text.append (txt)
			else
				temp_text.insert (txt, caret_position)
			end
			set_text (temp_text)
			set_caret_position (previous_caret_position)
		end

	append_text (txt:STRING) is
			-- Append 'txt' to text of `Current'. 
		local
			temp_text: STRING
			previous_caret_position: INTEGER
		do
			previous_caret_position := caret_position
				-- We have to handle the case where `text' is void.
			if text = Void then
				temp_text := txt
			else
				temp_text := text
				temp_text.append (txt)
			end
			set_text (temp_text)
			set_caret_position (previous_caret_position)
		end

	prepend_text (txt: STRING) is
			-- Prepend 'txt' to text of `Current'.
		local
			temp_text: STRING
			previous_caret_position: INTEGER
		do
			previous_caret_position := caret_position
				-- We have to handle the case where `text' is void.
			if text = Void then
				temp_text := txt
			else
				temp_text := text
				temp_text.prepend (txt)
			end
			set_text (temp_text)
			set_caret_position (previous_caret_position)
		end

	maximum_character_width: INTEGER is
			-- `Result' is width of widest character (W), when displayed.
		local
			screen_dc: WEL_SCREEN_DC
			extent: WEL_SIZE
		do
			create screen_dc
			screen_dc.get
			screen_dc.select_font ((create {WEL_SHARED_FONTS}).gui_font)
			extent := screen_dc.string_size ("W")
			screen_dc.unselect_font 
			screen_dc.quick_release
			Result := extent.width
		end

feature {EV_ANY_I} -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make a minimum of `nb' characters visible on one line.
			-- We add nine characters for borders.
		do
			set_minimum_width ((nb * 2) * maximum_character_width + 9)
		end

feature -- Basic operation

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) text between 
			-- 'start_pos' and 'end_pos'
		do
			set_selection (start_pos - 1, end_pos)
		end

	paste (index: INTEGER) is
			-- Insert string which is in Clipboard at
			-- `index' postion in text.
			-- If Clipboard is empty, it does nothing. 
		local
			pos: INTEGER
		do
			pos := caret_position
			set_caret_position (index)
			clip_paste
			if pos <= index then
				set_caret_position (pos)
			else
				set_caret_position (pos + clipboard_content.count)
			end
		end

	wel_set_font (a_wel_font: WEL_FONT) is
			-- Assign `a_wel_font' to font of `Current'.
		deferred
		end

feature {NONE} -- Deferred features

	internal_caret_position: INTEGER is
			-- Caret position.
		deferred
		end

	internal_set_caret_position (a_position: INTEGER) is
			-- Set caret position with `a_position'.
		deferred
		end

	set_selection (start_position, end_position: INTEGER) is
			-- Set selection between `start_position'
			-- and `end_position'.
		deferred
		end

	set_text_limit (value: INTEGER) is
			-- Make `value' new maximal length of text.
		deferred
		end

	get_text_limit: INTEGER is
			-- Result is maximum text length.
		deferred
		end

	read_only: BOOLEAN is
			-- Is `current' edit control read-only?
		deferred
		end

	set_read_only is
			-- Set `Current' read only.
		deferred
		end

	set_read_write is
			-- Set `Current' read/write.
		deferred
		end

	clip_paste is
			-- Paste at current caret position 
			-- content of clipboard.
		deferred
		end

	wel_font: WEL_FONT is
			-- Font of `Current'.
		deferred
		end

	wel_selection_start: INTEGER is
		deferred
		end

	wel_selection_end: INTEGER is
		deferred
		end

	wel_background_color: WEL_COLOR_REF is
		do
			Result := background_color_imp
			if Result = Void then
				create Result.make_rgb (255, 255, 255)
			end
		end

	wel_foreground_color: WEL_COLOR_REF is
		do
			Result := foreground_color_imp
			if Result = Void then
				create Result.make_rgb (0, 0, 0)
			end
		end

feature {NONE} -- Implementation

	clipboard_content: STRING is
			-- `Result' is current clipboard content.
		local
			edit_control: WEL_SINGLE_LINE_EDIT
		do
			create edit_control.make (Default_parent, "", 0, 0, 0, 0, 0)
			edit_control.clip_paste
			Result := edit_control.text
			edit_control.destroy
		end
feature {NONE} -- interface

	interface: EV_TEXT_COMPONENT

end -- class EV_TEXT_COMPONENT_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable  components for ISE Eiffel.
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
--| Revision 1.35  2001/06/30 00:08:42  rogers
--| Fixed `append_text' and `prepend_text' so that they work correctly
--| when `text' is `Void'.
--|
--| Revision 1.34  2001/06/07 23:08:17  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.25.2.23  2000/11/30 18:38:37  manus
--| Removed `the' from comments.
--| `total_vertical_padding' is now defined to 9 instead of 8, because the bottom
--| of most EV_TEXT_COMPONENT_IMP widgets were missing one pixel (eg combo box) and
--| having one pixel bigger is IMHO nice.
--|
--| Revision 1.25.2.22  2000/11/28 02:54:04  manus
--| `set_editable' does not change the background color anymore.
--|
--| Revision 1.25.2.21  2000/11/14 21:12:52  rogers
--| Changed all instances of `bang bang' to create.
--|
--| Revision 1.25.2.20  2000/11/06 19:37:11  king
--| Accounted for default to stock name change
--|
--| Revision 1.25.2.19  2000/10/28 01:09:31  manus
--| Use `gui_font' from WEL_SHARED_FONTS instead of creation a new WEL_DEFAULT_GUI_FONT object
--| all the time.
--|
--| Revision 1.25.2.18  2000/10/27 02:39:53  manus
--| Removed undefinition of `set_default_colors' since the inherited one does what we want. Instead
--| we defined correctly `wel_background_color' and `wel_foreground_color'.
--|
--| Revision 1.25.2.17  2000/10/09 05:05:23  manus
--| Reduced the default minimum size of a text component. It was too big in its current size
--| which was 10 character width, I made it 4.
--|
--| Revision 1.25.2.16  2000/09/13 22:09:21  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.25.2.15  2000/09/08 17:56:49  rogers
--| Paste now correctly restores the caret_position.
--|
--| Revision 1.25.2.14  2000/09/06 23:55:25  rogers
--| Fixed a bug in paste.
--|
--| Revision 1.25.2.13  2000/09/06 23:18:47  rogers
--| Renamed internal_maximum_character_width to maximum_character_width.
--| Changed export clauses of features that were being exported to ANY to
--| EV_ANY_I. Added clipboard_content which returns the content's of the
--| clipboard.
--|
--| Revision 1.25.2.12  2000/09/06 17:09:43  rogers
--| Removed previous_caret_position and restore caret_position, as if the
--| user is to click on the text, then the caret_position would not be stored
--| correctly internally. Insert_text, prepend_text and append_text now
--| query the caret_position ready for the restoration.
--|
--| Revision 1.25.2.11  2000/09/06 16:20:03  rogers
--| Added previous_caret_position which holds the caret position as set by the
--| user. Aded restore_caret_position which will set the caret position back
--| to previous_caret_position. Insert_text now correctly restores the caret.
--|
--| Revision 1.25.2.10  2000/09/06 15:22:24  rogers
--| Fixed insert_text to handle all possible caret positions.
--|
--| Revision 1.25.2.9  2000/08/22 19:01:47  rogers
--| Added internal_maximum_character_width. Fixed set_minimum_width_in_characters.
--|
--| Revision 1.25.2.7  2000/08/11 18:44:45  rogers
--| Fixed copyright clauses. Now use ! instead of |.
--|
--| Revision 1.25.2.6  2000/08/08 02:50:59  manus
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--|
--| Revision 1.25.2.5  2000/07/24 23:21:42  rogers
--| Now inherits EV_TEXT_COMPONENT_ACTION_SEQUENCES_IMP.
--|
--| Revision 1.25.2.4  2000/06/19 19:35:54  rogers
--| Removed FIXME NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.25.2.3  2000/05/30 16:23:40  rogers
--| Removed unreferenced local variables.
--|
--| Revision 1.25.2.2  2000/05/03 22:04:11  rogers
--| Adedd total_vertical_padding and internal_font_height.
--| Fixed set_default_minimum_size height. Removed old command
--| association.
--|
--| Revision 1.25.2.1  2000/05/03 19:09:51  oconnor
--| mergred from HEAD
--|
--| Revision 1.31  2000/04/27 23:18:02  pichery
--| Changed the default font for EV_TEXT_COMPONENT
--| and its descendants.
--|
--| Revision 1.30  2000/04/27 23:04:25  pichery
--| Added set_default_minimum_size
--|
--| Revision 1.29  2000/04/21 01:23:24  pichery
--| Fixed bug (log_font.height can be negative !!!)
--|
--| Revision 1.28  2000/02/19 06:34:13  oconnor
--| removed old command stuff
--|
--| Revision 1.27  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.26  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.25.4.5  2000/02/01 03:37:59  brendel
--| Removed undefine of set_default_minimum_size.
--|
--| Revision 1.25.4.4  2000/01/27 19:30:29  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.25.4.3  2000/01/18 18:21:25  rogers
--| Renamed
--| 	set_maximum_text_length -> set_capacity
--| 	get_maximum_text_length -> capacity
--|
--| Revision 1.25.4.2  1999/12/30 02:01:31  rogers
--| Changes to fit in with the new work.
--|
--| Revision 1.25.4.1  1999/11/24 17:30:34  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.24.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

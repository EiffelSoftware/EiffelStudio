--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision text component. %
				  % Mswindows implementation"
	note: "This class would be the equivalent of a WEL_EDIT%
			% in the wel hierarchy."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TEXT_COMPONENT_IMP

inherit
	EV_TEXT_COMPONENT_I
		--rename
		--	caret_position as internal_caret_position
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		undefine
			set_default_colors
		redefine
			set_default_minimum_size,
			interface,
			initialize
		end

feature {NONE} -- Initialization

	initialize is
		do
			wel_set_font (create {WEL_DEFAULT_GUI_FONT}.make)
			{EV_PRIMITIVE_IMP} Precursor
		end

	set_default_minimum_size is
			-- Called after creation. Set the current size and
			-- notify the parent.
		local
			log_font: WEL_LOG_FONT
		do
			log_font := wel_font.log_font
			internal_set_minimum_size (
				log_font.width.abs * 10, -- 10 characters wide
				log_font.height.abs		 -- 1 character tall
				)
		end

feature -- Status report

	is_editable: BOOLEAN is
			-- Is the text editable
		do
			Result := not read_only
		end

	caret_position: INTEGER is
			-- Current position of the caret.
		do
			Result := internal_caret_position + 1
		end

	selection_start: INTEGER is
			-- Index of the first character selected
		do
			Result := wel_selection_start + 1
		end

	selection_end: INTEGER is
			-- Index of the last character selected
		do
			Result := wel_selection_end
		end

feature -- Status setting

	set_editable (flag: BOOLEAN) is
				-- `flag' true make the component read-write and
				-- `flag' false make the component read-only.
			local
				default_colors: EV_DEFAULT_COLORS
			do
				!! default_colors
				if flag then
					set_read_write
					set_background_color (default_colors.Color_read_write)
				else
					set_read_only
					set_background_color (default_colors.Color_read_only)
				end
			end

	set_caret_position (pos: INTEGER) is
			-- set current insertion position
		do
			internal_set_caret_position (pos - 1)
		end

	set_capacity (value: INTEGER) is
			-- Make `value' the new maximal lenght of the text
			-- in characte number.
		do
			set_text_limit (value)
		end

	capacity: INTEGER is
			-- Return the maximum number of characters
			-- that the user may enter.
		do
			Result := get_text_limit
		end

feature -- element change

	insert_text (txt: STRING) is
			-- Add `txt' to the left of `position' 
		local
			temp_text: STRING
		do
			temp_text := text
			temp_text.insert (txt, caret_position)
			set_text (temp_text)
		end

	append_text (txt:STRING) is
			-- append 'txt' into component
		local
			temp_text: STRING
		do
			temp_text := text
			temp_text.append (txt)
			set_text (temp_text)
		end

	prepend_text (txt: STRING) is
			-- prepend 'txt' into component
		local
			temp_text: STRING
		do
			temp_text := text
			temp_text.prepend (txt)
			set_text (temp_text)
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make `nb' characters visible on one line.
			-- We add nine for the borders.
		do
			internal_set_minimum_width (nb * wel_font.log_font.width + 9)
		end

feature -- Basic operation

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- 'start_pos' and 'end_pos'
		do
			set_selection (start_pos - 1, end_pos)
		end

	paste (index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' postion in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		local
			pos: INTEGER
		do
			pos := internal_caret_position
			set_caret_position (index - 1)
			clip_paste
			set_caret_position (pos)
		end

	wel_set_font (a_wel_font: WEL_FONT) is
			-- Set the font used by this control
		deferred
		end

feature -- Event - command association

--|FIXME	add_change_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--|FIXME			-- Add 'cmd' to the list of commands to be executed 
--|FIXME			-- when the text of the widget have changed.
--|FIXME		do
--|FIXME			add_command (Cmd_change, cmd, arg)
--|FIXME		end

feature -- Event -- removing command association

--|FIXME	remove_change_commands is
--|FIXME			-- Empty the list of commands to be executed
--|FIXME			-- when the text of the widget have changed.
--|FIXME		do
--|FIXME			remove_command (Cmd_change)
--|FIXME		end

feature {NONE} -- Deferred features

	internal_caret_position: INTEGER is
			-- Caret position
		deferred
		end

	internal_set_caret_position (a_position: INTEGER) is
			-- Set the caret position with `position'.
		deferred
		end

	set_selection (start_position, end_position: INTEGER) is
			-- Set the selection between `start_position'
			-- and `end_position'.
		deferred
		end

	set_text_limit (value: INTEGER) is
			-- Make `value' the new maximal length of the text.
		deferred
		end

	get_text_limit: INTEGER is
			-- Return the maximum text length.
		deferred
		end

	read_only: BOOLEAN is
			-- Is the current edit control read-only?
		deferred
		end

	set_read_only is
			-- Set the read-only state.
		deferred
		end

	set_read_write is
			-- Set the read-write state.
		deferred
		end

	clip_paste is
			-- Paste at the current caret position the
			-- content of the clipboard.
		deferred
		end

	wel_font: WEL_FONT is
			-- Current font of the control
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
		end

	wel_foreground_color: WEL_COLOR_REF is
		do
			Result := foreground_color_imp
		end

feature {NONE} -- interface

	interface: EV_TEXT_COMPONENT

end -- class EV_TEXT_COMPONENT_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable  components for ISE Eiffel.
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

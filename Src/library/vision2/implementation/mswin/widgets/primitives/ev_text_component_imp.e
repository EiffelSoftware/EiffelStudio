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

	EV_PRIMITIVE_IMP
		undefine
			set_default_colors,
			set_default_options
		redefine
			set_default_minimum_size
		end

	EV_BAR_ITEM_IMP

feature {NONE} -- Initialization

	set_default_minimum_size is
			-- Called after creation. Set the current size and
			-- notify the parent.
		do
			set_minimum_height (wel_font.log_font.height + 7)
			set_minimum_width (30)
		end

feature -- Status report

	position: INTEGER is
			-- Current position of the caret.
		do
			Result := caret_position + 1
		end

	selection_start: INTEGER is
			-- Index of the first character selected
		do
			Result := wel_selection_start + 1
		end

	selection_end: INTEGER is
			-- Index of the last character selected
		do
			Result := wel_selection_end + 1
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

	set_position (pos: INTEGER) is
			-- set current insertion position
		do
			set_caret_position (pos - 1)
		end

	set_maximum_text_length (value: INTEGER) is
			-- Make `value' the new maximal lenght of the text
			-- in characte number.
		do
			set_text_limit (value)
		end

feature -- element change

	insert_text (txt: STRING) is
			-- Add `txt' to the left of `position' 
		local
			temp_text: STRING
		do
			temp_text := text
			temp_text.insert (txt, position)
			set_text (temp_text)		
		end

	append_text (txt:STRING) is
			-- append 'txt' into component
		do
			set_position (text.count + 1)
			insert_text (txt)
		end

	prepend_text (txt: STRING) is
			-- prepend 'txt' into component
		do
			set_position (1)
			insert_text (txt)	
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make `nb' characters visible on one line.
			-- We add nine for the borders.
		do
			set_minimum_width (nb * wel_font.log_font.width + 9)
		end

feature -- Basic operation

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- 'start_pos' and 'end_pos'
		do
			set_selection (start_pos - 1, end_pos - 1)
		end

	paste (index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' postion in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		local
			pos: INTEGER
		do
			pos := caret_position
			set_caret_position (index - 1)
			clip_paste
			set_caret_position (pos)
		end

feature -- Event - command association

	add_change_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed 
			-- when the text of the widget have changed.
		do
			add_command (Cmd_change, cmd, arg)
		end

feature -- Event -- removing command association

	remove_change_commands is
			-- Empty the list of commands to be executed
			-- when the text of the widget have changed.
		do
			remove_command (Cmd_change)
		end

feature {NONE} -- Deferred features

	caret_position: INTEGER is
			-- Caret position
		deferred
		end

	set_caret_position (a_position: INTEGER) is
			-- Set the caret position with `position'.
		deferred
		end

	set_selection (start_position, end_position: INTEGER) is
			-- Set the selection between `start_position'
			-- and `end_position'.
		deferred
		end

	set_text (txt: STRING) is
			-- Make `txt' the new text of the component.
		deferred
		end

	set_text_limit (value: INTEGER) is
			-- Make `value' the new maximal length of the text.
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

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
			initialize_colors
		end

	EV_DEFAULT_COLORS

feature -- Access

	position: INTEGER is
			-- Current position of the caret.
		do
			Result := caret_position
		end

feature -- Status setting

	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		local
			color: EV_COLOR
		do
			if flag then
				set_read_write
				set_background_color (Color_read_write)
			else
				set_read_only
				set_background_color (Color_read_only)
			end
		end

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
		local
			temp_text: STRING
		do
			temp_text := text
			temp_text.append_string (txt)
			set_text (temp_text)
		end

	prepend_text (txt: STRING) is
			-- prepend 'txt' into component
		do
			set_position (1)
			insert_text (txt)	
		end

	set_position (pos: INTEGER) is
			-- set current insertion position
		do
			set_caret_position (pos)
		end

	set_maximum_line_lenght (lenght: INTEGER) is
			-- Maximum number of charachters on line
		do
			check
				not_yet_implemented: False
			end
		end

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- 'start_pos' and 'end_pos'
		do
			set_selection (start_pos, end_pos)
		end

feature -- Basic operation

	search (str: STRING): INTEGER is
			-- Search the string `str' in the text.
			-- If `str' is find, it returns its start
			-- index in the text, otherwise, it returns
			-- `Void'
		do
			check
				not_yet_implemented: False
			end
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard 
			-- to paste it later.
			-- If the `selectd_region' is empty, it does
			-- nothing.
		do
			check
				not_yet_implemented: False
			end
		end

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			check
				not_yet_implemented: False
			end
		end

	paste (index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' postion in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Implementation : deferred features of WEL_EDIT that 
		-- are used here but not defined

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

	set_text (a_text: STRING) is
   			-- Set the window text
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

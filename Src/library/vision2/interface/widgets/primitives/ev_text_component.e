indexing
	description: 
	"EiffelVision text component. Common ancestor for text classes like% 
	%text field and text area."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_TEXT_COMPONENT

inherit
	EV_PRIMITIVE
		redefine
			implementation
		end
	
	EV_BAR_ITEM
		redefine
			implementation
		end
	
feature -- Access

	text: STRING is
			-- Text in component
		require
			exists: not destroyed
		do
			Result:= implementation.text
		end 

feature -- Status setting
	
	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		require
			exists: not destroyed
		do
			implementation.set_editable (flag)
		end

	set_text (txt: STRING) is
			-- Make `txt' the new `text'.
		require
			exists: not destroyed			
			not_void: txt /= Void
		do
			implementation.set_text (txt)
		ensure
			text_set: text.is_equal (txt)
		end
	
	append_text (txt: STRING) is
			-- Append `txt' into component.
		require
			exist: not destroyed			
			not_void: txt /= Void
		do
			implementation.append_text (txt)
		ensure
			text_appended:
		end
	
	prepend_text (txt: STRING) is
			-- Prepend `txt' into component.
		require
			exist: not destroyed			
			not_void: txt /= Void
		do
			implementation.prepend_text (txt)
		ensure
			text_prepended: 
		end
	
	set_position (pos: INTEGER) is
			-- Set current insertion position.
		require
			exist: not destroyed			
			valid_pos: pos > 0 and pos <= text.count
		do
			implementation.set_position (pos)
		end
	
	set_maximum_line_length (len: INTEGER) is
			-- Make `len' the new number of characters on a line.
			-- If `len' < `text.cout' then the text is truncated
		require
			exist: not destroyed			
		do
			implementation.set_maximum_line_length (len)
		end

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- `start_pos' and `end_pos'
		require
			exist: not destroyed
			valid_start: start_pos > 0 and start_pos <= text.count
			valid_end: end_pos > 0 and end_pos <= text.count
		do
			implementation.select_region (start_pos, end_pos)
		ensure
			-- region selected
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make `nb' characters visible on one line.
		require
			exists: not destroyed
			valid_nb: nb > 0
		do
			implementation.set_minimum_width_in_characters (nb)
		end

feature -- Basic operation

	search (str: STRING): INTEGER is
			-- Search the string `str' in the text.
			-- If `str' is find, it returns its start
			-- index in the text, otherwise, it returns
			-- `Void'
		require
			exists: not destroyed
			valid_string: str /= Void
		do
			Result := implementation.search (str)
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard 
			-- to paste it later.
			-- If the `selectd_region' is empty, it does
			-- nothing.
		require
			exists: not destroyed
		do
			implementation.cut_selection
		end

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		require
			exists: not destroyed
		do
			implementation.copy_selection
		end

	paste (index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' postion in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		require
			exists: not destroyed
		do
			implementation.paste (index)
		end
	
feature {NONE} -- Implementation

	implementation: EV_TEXT_COMPONENT_I
			-- Implementation
			
end -- class EV_TEXT_COMPONENT

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


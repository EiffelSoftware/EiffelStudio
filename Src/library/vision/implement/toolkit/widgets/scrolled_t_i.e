indexing
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCROLLED_T_I 

inherit
	TEXT_I

feature -- Access

	expanded_position (pos: INTEGER): INTEGER is
			-- Position in the text after tabulation expansion
			-- (By default, it is `pos'. This is used for TABBED_TEXT)
		require
			valid_pos: pos >= 0 and pos <= count
		do
			Result := pos
		ensure
			valid_result: Result >= 0 and Result <= actual_count
		end	

	unexpanded_position (pos: INTEGER): INTEGER is
			-- Position in the text before tabulation expansion
			-- (By default, it is `pos'. This is used for TABBED_TEXT)
		require
			valid_pos: pos >= 0 and pos <= actual_count
		do
			Result := pos
		ensure
			valid_result: Result >= 0 and then Result <= count
		end

	actual_cursor_position: INTEGER is
			-- Current position of text
			-- (By default, it is `current_position'. This is used for TABBED_TEXT)
		do
			Result := cursor_position
		end

feature -- Status report

	is_vertical_scrollbar: BOOLEAN is
			-- Is vertical scrollbar visible?
		deferred
		end

	is_horizontal_scrollbar: BOOLEAN is
			-- Is horizontal scrollbar visible?
		deferred
		end

	actual_text: STRING is
			-- Actual text of scrolled text `text'
			-- (By default, it is `text'. This is used for TABBED_TEXT)
		do
			Result := text
		end

	actual_count: INTEGER is
			-- Actual count of scrolled text `text'
			-- (By default, it is `count'. This is used for TABBED_TEXT)
		do
			Result := count
		end

	tab_length: INTEGER is
			-- Size of tabulation
		deferred
		ensure
			result_greater_than_one: Result > 1
		end

feature -- Status setting

	show_vertical_scrollbar is
			-- Make vertical scrollbar visible.
		deferred
		end

	hide_vertical_scrollbar is
			-- Make vertical scrollbar invisible.
		deferred
		end

	show_horizontal_scrollbar is
			-- Make horizontal scrollbar visible.
		deferred
		end

	hide_horizontal_scrollbar is
			-- Make horizontal scrollbar invisible.
		deferred
		end

	set_tab_length (new_length: INTEGER) is
			-- Set `tab_length' to `new_length'.
		require
			valid_new_length: new_length > 1
		deferred
		ensure
			set: tab_length = new_length
		end

end -- class SCROLLED_T_I



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


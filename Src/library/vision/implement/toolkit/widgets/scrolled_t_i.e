note
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCROLLED_T_I 

inherit
	TEXT_I

feature -- Access

	expanded_position (pos: INTEGER): INTEGER
			-- Position in the text after tabulation expansion
			-- (By default, it is `pos'. This is used for TABBED_TEXT)
		require
			valid_pos: pos >= 0 and pos <= count
		do
			Result := pos
		ensure
			valid_result: Result >= 0 and Result <= actual_count
		end	

	unexpanded_position (pos: INTEGER): INTEGER
			-- Position in the text before tabulation expansion
			-- (By default, it is `pos'. This is used for TABBED_TEXT)
		require
			valid_pos: pos >= 0 and pos <= actual_count
		do
			Result := pos
		ensure
			valid_result: Result >= 0 and then Result <= count
		end

	actual_cursor_position: INTEGER
			-- Current position of text
			-- (By default, it is `current_position'. This is used for TABBED_TEXT)
		do
			Result := cursor_position
		end

feature -- Status report

	is_vertical_scrollbar: BOOLEAN
			-- Is vertical scrollbar visible?
		deferred
		end

	is_horizontal_scrollbar: BOOLEAN
			-- Is horizontal scrollbar visible?
		deferred
		end

	actual_text: STRING
			-- Actual text of scrolled text `text'
			-- (By default, it is `text'. This is used for TABBED_TEXT)
		do
			Result := text
		end

	actual_count: INTEGER
			-- Actual count of scrolled text `text'
			-- (By default, it is `count'. This is used for TABBED_TEXT)
		do
			Result := count
		end

	tab_length: INTEGER
			-- Size of tabulation
		deferred
		ensure
			result_greater_than_one: Result > 1
		end

feature -- Status setting

	show_vertical_scrollbar
			-- Make vertical scrollbar visible.
		deferred
		end

	hide_vertical_scrollbar
			-- Make vertical scrollbar invisible.
		deferred
		end

	show_horizontal_scrollbar
			-- Make horizontal scrollbar visible.
		deferred
		end

	hide_horizontal_scrollbar
			-- Make horizontal scrollbar invisible.
		deferred
		end

	set_tab_length (new_length: INTEGER)
			-- Set `tab_length' to `new_length'.
		require
			valid_new_length: new_length > 1
		deferred
		ensure
			set: tab_length = new_length
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SCROLLED_T_I


indexing

	description: 
		"EiffelVision text area, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TEXT_IMP
	
inherit
	EV_TEXT_I
		redefine
			interface
		end

	EV_TEXT_COMPONENT_IMP
		redefine
			interface,
			set_caret_position,
			insert_text,
			visual_widget
		end
		
	EV_FONTABLE_IMP
		redefine
			interface,
			visual_widget
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a gtk label.
		do
			base_make (an_interface)
			set_c_object (C.gtk_scrolled_window_new (NULL, NULL))
			C.gtk_scrolled_window_set_policy (c_object, C.GTK_POLICY_AUTOMATIC_ENUM, C.GTK_POLICY_AUTOMATIC_ENUM)
			entry_widget := C.gtk_text_new (NULL, NULL)
			C.gtk_widget_show (entry_widget)
			C.gtk_container_add (c_object, entry_widget)
			C.gtk_text_set_editable (entry_widget, True)
		end
		
	visual_widget: POINTER is
			-- The widget the user sees on the screen.
		do
			Result := entry_widget
		end

feature -- Access

	text: STRING is
		local
			p: POINTER
		do
			p := C.gtk_editable_get_chars (entry_widget, 0, -1)
			create Result.make_from_c (p)
			C.g_free (p)
		end

	line (i: INTEGER): STRING is
			-- Returns the content of the `i'th line.
		local
			line_begin_pos, line_end_pos: INTEGER
			counter : INTEGER
			p: POINTER
		do
			from
				counter := 1
				line_begin_pos := 1
				line_end_pos := 1
			until
				counter = i
			loop
				line_begin_pos := text.index_of ('%N', line_begin_pos)
				counter := counter + 1
				line_begin_pos := line_begin_pos + 1
			end

			-- We do not substract 1 to `line_end_pos' because of 
			-- GTK function `gtk_editable_get_chars'.
			line_end_pos := text.index_of ('%N', line_begin_pos)

			if (line_end_pos = 0) and then (counter = line_count) then
				-- the required line is the last line and there
				-- is no return at the end of it.
				line_end_pos := text.count + 1
				-- The `+ 1' is due to GTK function `gtk_editable_get_chars'. 
			end

			p := C.gtk_editable_get_chars (entry_widget, line_begin_pos - 1, line_end_pos - 1)
			create Result.make_from_c (p)
			C.g_free (p)
		end

feature -- Status report

	current_line_number: INTEGER is
			-- Returns the number of the line the cursor currently
			-- is on.
		local
			p: POINTER
			temp_string: STRING
		do
			p := C.gtk_editable_get_chars (entry_widget, 0, C.gtk_text_get_point (entry_widget))
			create temp_string.make_from_c (p)
			C.g_free (p)
			Result := temp_string.occurrences ('%N') + 1
		end

	caret_position: INTEGER is
			-- Current position of the caret.
		do
			Result := C.gtk_text_get_point (entry_widget) + 1
		end

	first_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the first character on the `i'-th line.
		local
			pos : INTEGER
			count: INTEGER
			start: INTEGER
		do
			if (i = 1) then
				Result := 1
			else
				from
					count := 1
					pos := 1
					start := 1
				until
					count = i
				loop
					-- Look for the ith 'Return' in the string.
					-- Return is symbolized by '%N'
					pos := text.index_of ('%N', start)
					count := count + 1
					start := pos + 1
				end
				Result := pos + 1
			end
		end

	last_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the last character on the `i'-th line.
		local
			pos : INTEGER
			count: INTEGER
			start: INTEGER
		do
			if (i = line_count) then
				Result := text.count
			else
				from
					count := 1
					pos := 1
					start := 1
				until
					count = i + 1
				loop
					-- Look for the (i + 1)th `Return' in the string.
					-- Return is symbolized by '%N'
					pos := text.index_of ('%N', start)
					count := count + 1
					start := pos + 1
				end
				Result := pos
			end
		end

feature -- Status setting

	set_caret_position (pos: INTEGER) is
			-- Set the position of the caret to `pos'.
		do
			C.gtk_text_set_point (entry_widget, pos - 1)
		end
	
	insert_text (txt: STRING) is
		local
			a_gs: GEL_STRING
		do
			create a_gs.make (txt)
			C.gtk_text_insert (entry_widget, NULL, NULL, NULL, a_gs.item, -1)
		end
	
	set_text (txt: STRING) is
		do
			C.gtk_editable_delete_text (entry_widget, 0, -1)
			insert_text (txt)
		end
	
	append_text (txt: STRING) is
			-- Append `txt' to `text'.
		local
			temp_caret_pos: INTEGER
		do
			temp_caret_pos := caret_position
			C.gtk_text_set_point (entry_widget, text_length)
			insert_text (txt)
			set_caret_position (temp_caret_pos)
		end
	
	prepend_text (txt: STRING) is
			-- Prepend 'txt' to `text'.
		local
			temp_caret_pos: INTEGER
		do
			temp_caret_pos := caret_position
			C.gtk_text_set_point (entry_widget, 0)
			insert_text (txt)
			set_caret_position (temp_caret_pos)
		end
	
	delete_text (start, finish: INTEGER) is
			-- Delete the text between `start' and `finish' index
			-- both sides include.
		do
			C.gtk_editable_delete_text (entry_widget, start + 1, finish + 1)
		end

	freeze is
			-- Freeze the widget.
			-- If the widget is frozen any updates made to the
			-- window will not be shown until the widget is
			-- `thawed out' using `thaw'.
			-- Note: Only one window can be frozen at a time.
			-- This is because of a limitation on Windows.
		do
			C.gtk_text_freeze (entry_widget)
		end

	thaw is
			-- Thaw a frozen widget.
		do
			C.gtk_text_thaw (entry_widget)
		end

feature -- Basic operation

	put_new_line is
			-- Go to the beginning of the following line.
		do
			insert_text ("%N")
		end

	search (str: STRING; start: INTEGER): INTEGER is
			-- Position of first occurrence of `str' at or after `start';
			-- 0 if none.
		do
			Result := text.substring_index (str, start)
		end

	scroll_to_line (i: INTEGER) is
		do
		end

feature -- Assertions

	last_line_not_empty: BOOLEAN is
			-- Has the line at least one character?
		local
			temp_text: STRING
		do
			temp_text := text
			Result := not ((temp_text @ temp_text.count) = '%N')
		end
		
feature {NONE} -- Implementation

	entry_widget: POINTER
		-- Pointer to the gtk text editable.

feature {EV_ANY_I} -- Implementation

	interface: EV_TEXT

end -- class EV_TEXT_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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


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
			insert_text
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a gtk label.
		do
			base_make (an_interface)
			set_c_object (C.gtk_text_new (NULL, NULL))
			C.gtk_text_set_editable (c_object, True)
			entry_widget := c_object
		end

feature -- Access

	text: STRING is
		local
			p: POINTER
		do
			p := C.gtk_editable_get_chars (c_object, 0, -1)
			create Result.make_from_c (p)
			C.g_free (p)
			if Result.is_equal ("") then
				Result := Void
			end
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

			p := C.gtk_editable_get_chars (c_object, line_begin_pos - 1, line_end_pos - 1)
			create Result.make_from_c (p)
			C.g_free (p)
		end

feature -- Status report

	current_line_number: INTEGER is
			-- Returns the number of the line the cursor currently
			-- is on.
		do
			check
				To_be_implemented: False
			end
		end

	caret_position: INTEGER is
			-- Current position of the caret.
		do
			Result := C.gtk_text_get_point (c_object) + 1
		end

	line_count: INTEGER is
			-- Number of lines in widget.
		do
			if text /= Void then
				Result := text.occurrences ('%N') + 1
			end	
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

	has_system_frozen_widget: BOOLEAN is
			-- Is there any widget frozen?
			-- If a widget is frozen any updates made to it
			-- will not be shown until the widget is
			-- thawn again.
		do
			check
				To_be_implemented: False
			end
		end

feature -- Status setting

	set_caret_position (pos: INTEGER) is
			-- Set the position of the caret to `pos'.
		do
			C.gtk_text_set_point (c_object, pos - 1)
		end
	
	insert_text (txt: STRING) is
		do
			C.gtk_text_insert (c_object, NULL, NULL, NULL, eiffel_to_c (txt), -1)
		end
	
	set_text (txt: STRING) is
		do
			C.gtk_editable_delete_text (c_object, 0, -1)
			if txt /= Void then
				insert_text (txt)
			end
		end
	
	append_text (txt: STRING) is
			-- Append `txt' to `text'.
		local
			temp_caret_pos: INTEGER
		do
			temp_caret_pos := caret_position
			C.gtk_text_set_point (c_object, text_length)
			insert_text (txt)
			set_caret_position (temp_caret_pos)
		end
	
	prepend_text (txt: STRING) is
			-- Prepend 'txt' to `text'.
		do
			C.gtk_text_set_point (c_object, 0)
			insert_text (txt)
		end
	
	delete_text (start, finish: INTEGER) is
			-- Delete the text between `start' and `finish' index
			-- both sides include.
		do
			C.gtk_editable_delete_text (c_object, start + 1, finish + 1)
		end

	freeze is
			-- Freeze the widget.
			-- If the widget is frozen any updates made to the
			-- window will not be shown until the widget is
			-- `thawed out' using `thaw'.
			-- Note: Only one window can be frozen at a time.
			-- This is because of a limitation on Windows.
		do
			C.gtk_text_freeze (c_object)
		end

	thaw is
			-- Thaw a frozen widget.
		do
			C.gtk_text_thaw (c_object)
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
			if text /= Void then
				Result := text.substring_index (str, start)
			end	
		end

	scroll_to_line (i: INTEGER) is
		do
		end

feature -- Assertions

	last_line_not_empty: BOOLEAN is
			-- Has the line at least one character?
		do
			if text /= Void then
				Result := not ((text @ text.count) = '%N')
			end
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


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

	EV_TEXT_COMPONENT_IMP
		undefine
			set_default_options
		end

create
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create a gtk label.
		do
			widget := gtk_text_new (Default_pointer, 
				Default_pointer)
			gtk_object_ref (widget)
			gtk_text_set_editable (widget, True)
		end

	make_with_text (txt: STRING) is
			-- Create a text area with `par' as
			-- parent and `txt' as text.
		do
			make
			set_text (txt)
		end

feature -- Access

	text: STRING is
		local
			p: POINTER
		do
			p := gtk_editable_get_chars (GTK_EDITABLE(widget), 0, -1)
			create Result.make (0)
			Result.from_c (p)
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

			p := gtk_editable_get_chars (widget, line_begin_pos - 1, line_end_pos - 1)

			create Result.make (0)
			Result.from_c (p)
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

	line_count: INTEGER is
			-- Number of lines in widget.
			-- Based on the number of '%N' in the text.
			-- Should be replaced by a Gtk function as soon
			-- as it exists.
		local
			count: INTEGER
			pos: INTEGER
		do
			count := 1
			if (text /= Void) and then (not text.empty) then
				from
					pos := 1
				until
					(pos > text.count) or (pos = 0)
				loop
					-- Look for 'Return' in the string.
					-- Return is symbolized by '%N'
					pos := text.index_of ('%N', pos)
					if pos > 0 then
						count := count + 1
						-- increment the position of research of 1
						pos := pos + 1
					end
				end
			end
			Result := count		
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
					-- Look for the ith'Return' in the string.
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
	
	insert_text (txt: STRING) is
		local
			a: ANY
		do
			a := txt.to_c
			c_gtk_text_insert (widget, $a)
		end
	
	set_text (txt: STRING) is
		local
			a: ANY
		do
			a := txt.to_c
			delete_text (1, text_length + 1)
			insert_text (txt)
		end
	
	append_text (txt: STRING) is
		do
			gtk_text_set_point (widget, text_length)
			insert_text (txt)
		end
	
	prepend_text (txt: STRING) is
			-- prepend 'txt' to text
		do
			gtk_text_set_point (widget, 0)
			insert_text (txt)
		end
	
	delete_text (start, finish: INTEGER) is
			-- Delete the text between `start' and `finish' index
			-- both sides include.
		do
			set_position (start)
			gtk_text_forward_delete (widget, finish - start)
		end

	freeze is
			-- Freeze the widget.
			-- If the widget is frozen any updates made to the
			-- window will not be shown until the widget is
			-- `thawed out' using `thaw'.
			-- Note: Only one window can be frozen at a time.
			-- This is because of a limitation on Windows.
		do
			gtk_text_freeze (widget)
		end

	thaw is
			-- Thaw a frozen widget.
		do
			gtk_text_thaw (widget)
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

feature -- Assertions

	last_line_not_empty: BOOLEAN is
			-- Has the line at least one character?
		do
			Result := not ((text @ text.count) = '%N')
		end

feature -- Externals
	
	gtk_text_freeze (text_wid: POINTER) is
		external
			"C (GtkText *)| <gtk/gtk.h>"
		end

	gtk_text_thaw (text_wid: POINTER) is
		external
			"C (GtkText *)| <gtk/gtk.h>"
		end

end -- class EV_TEXT_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable  components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

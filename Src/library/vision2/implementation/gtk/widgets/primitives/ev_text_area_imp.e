--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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
--		undefine
--			set_default_options
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a gtk label.
		do
			base_make (an_interface)
			set_c_object (C.gtk_text_new (Default_pointer, Default_pointer))
			C.gtk_text_set_editable (c_object, True)
		end

feature -- Access

	text: STRING is
		local
			p: POINTER
		do
			p := C.gtk_editable_get_chars (c_object, 0, -1)
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

			p := C.gtk_editable_get_chars (c_object, line_begin_pos - 1, line_end_pos - 1)

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

	caret_position: INTEGER is
			-- Current position of the caret.
		do
			check
				To_be_implemented: False
			end
		end

	line_count: INTEGER is
			-- Number of lines in widget.
		do
			Result := text.occurrences ('%N') + 1
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

	set_caret_position (pos: INTEGER) is
			-- Set the position of the caret to `pos'.
		do
			check
				To_be_implemented: False
			end
		end
	
	insert_text (txt: STRING) is
		local
			a: ANY
		do
			a := txt.to_c
			C.c_gtk_text_insert (c_object, $a)
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
			C.gtk_text_set_point (c_object, text_length)
			insert_text (txt)
		end
	
	prepend_text (txt: STRING) is
			-- prepend 'txt' to text
		do
			C.gtk_text_set_point (c_object, 0)
			insert_text (txt)
		end
	
	delete_text (start, finish: INTEGER) is
			-- Delete the text between `start' and `finish' index
			-- both sides include.
		local	
			i: INTEGER
		do
			set_position (start)
			i := C.gtk_text_forward_delete (c_object, finish - start)
			-- FIXME return value?
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
			Result := text.substring_index (str, start)
		end

feature -- Assertions

	last_line_not_empty: BOOLEAN is
			-- Has the line at least one character?
		do
			Result := not ((text @ text.count) = '%N')
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TEXT

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.18  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.14.2.1.2.8  2000/02/04 05:14:06  oconnor
--| unreleased
--|
--| Revision 1.14.2.1.2.7  2000/02/04 05:01:15  oconnor
--| released
--|
--| Revision 1.14.2.1.2.6  2000/02/01 01:44:16  brendel
--| Simplified implementation of line_count.
--|
--| Revision 1.14.2.1.2.5  2000/01/27 19:29:48  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.14.2.1.2.4  2000/01/06 18:43:03  king
--| Added unimplemented caret_position and set_caret_position
--|
--| Revision 1.14.2.1.2.3  1999/12/23 01:34:13  king
--| Removed unneeded externals
--|
--| Revision 1.14.2.1.2.2  1999/12/09 18:12:40  oconnor
--| use new C externals
--|
--| Revision 1.14.2.1.2.1  1999/11/24 17:29:58  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.2.3  1999/11/17 01:53:06  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.12.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

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
			create Result.make (0)
			Result.from_c (p)
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
			Result := C.gtk_text_get_point (c_object) + 1
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
			Result := text.substring_index (str, start)
		end

	scroll_to_line (i: INTEGER) is
		do
		end

feature -- Assertions

	last_line_not_empty: BOOLEAN is
			-- Has the line at least one character?
		do
			Result := not ((text @ text.count) = '%N')
		end

feature {NONE} -- Implementation

	entry_widget: POINTER
		-- Pointer to the gtk text editable.

feature {EV_ANY_I} -- Implementation

	interface: EV_TEXT

end -- class EV_TEXT_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable  components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2001/07/14 12:46:23  manus
--| Replace --! by --|
--|
--| Revision 1.4  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.3  2001/06/23 00:30:16  pichery
--| Implemented "to be implemented" features.
--|
--| Revision 1.2  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.3  2001/04/13 23:56:53  king
--| Made compilable, implement later
--|
--| Revision 1.1.2.2  2000/10/27 22:45:02  king
--| Updated set/get text routines to account for interface revision
--|
--| Revision 1.1.2.1  2000/10/09 21:10:38  oconnor
--| Renamed ev_text_area_imp.e to ev_text_imp.e
--|
--| Revision 1.14.2.5  2000/09/13 16:43:08  oconnor
--| unused local
--|
--| Revision 1.14.2.4  2000/09/12 19:05:55  king
--| Redefing features moved up in to text_component_imp
--|
--| Revision 1.14.2.3  2000/09/11 22:40:28  oconnor
--| fixed delete_text and set_text
--|
--| Revision 1.14.2.2  2000/05/03 19:08:51  oconnor
--| mergred from HEAD
--|
--| Revision 1.23  2000/05/02 18:55:30  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.22  2000/04/18 19:53:04  oconnor
--| Revised to survive without externals.
--|
--| Revision 1.21  2000/04/13 23:06:46  brendel
--| Unreleased.
--|
--| Revision 1.20  2000/03/08 21:40:06  king
--| Added entry_widget pointer to be compatible with new text_component imp
--|
--| Revision 1.19  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

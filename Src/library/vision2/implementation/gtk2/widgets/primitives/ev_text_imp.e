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
			internal_set_caret_position,
			insert_text,
			visual_widget,
			set_background_color
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
		end

feature -- Access

	text: STRING is
		local
		do
		end

	line (i: INTEGER): STRING is
			-- Returns the content of the `i'th line.
		local
		do
		end

feature -- Status report

	line_count: INTEGER is
			-- Number of lines present in widget.
		local
		do
		end

	current_line_number: INTEGER is
			-- Returns the number of the line the cursor currently
			-- is on.
		do
		end

	caret_position: INTEGER is
			-- Current position of the caret.
		do
		end

	first_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the first character on the `i'-th line.
		local
		do
		end

	last_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the last character on the `i'-th line.
		local
		do
		end

feature -- Status setting
		
	set_background_color (a_color: EV_COLOR) is
			-- Set background color of present
		do
			Precursor {EV_TEXT_COMPONENT_IMP} (a_color)
		end

	internal_set_caret_position (pos: INTEGER) is
			-- Set the position of the caret to `pos'.
		do
			Precursor {EV_TEXT_COMPONENT_IMP} (pos)
		end
	
	insert_text (txt: STRING) is
		local
		do
		end
	
	set_text (txt: STRING) is
		do
		end
	
	append_text (txt: STRING) is
			-- Append `txt' to `text'.
		local
		do
		end
	
	prepend_text (txt: STRING) is
			-- Prepend 'txt' to `text'.
		local
		do
		end
	
	delete_text (start, finish: INTEGER) is
			-- Delete the text between `start' and `finish' index
			-- both sides include.
		do
		end

	freeze is
			-- Freeze the widget.
			-- If the widget is frozen any updates made to the
			-- window will not be shown until the widget is
			-- `thawed out' using `thaw'.
			-- Note: Only one window can be frozen at a time.
			-- This is because of a limitation on Windows.
		do
		end

	thaw is
			-- Thaw a frozen widget.
		do
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

	vertical_adjustment_struct: POINTER is
			-- Pointer to vertical adjustment struct use in the scrollbar.
		do
		end

	line_height: INTEGER is
			-- Height of the text lines in the widget.
		do
			if private_font /= Void then
				Result := private_font.ascent + private_font.descent
			else
				Result := App_implementation.Default_font_ascent + App_implementation.Default_font_descent
			end
		end

	entry_widget: POINTER
		-- Pointer to the gtk text editable.
		
	visual_widget: POINTER is
			-- Pointer to widget shown on screen.
		do
			Result := entry_widget
		end
		

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


indexing
	description: 
		"EiffelVision text area, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_I
	
inherit
	EV_TEXT_COMPONENT_I
		redefine
			set_default_options
		end	

feature {NONE} -- Initialization

	make_with_text (txt: STRING) is
			-- Create a text area with `par' as
			-- parent and `txt' as text.
		deferred
		end

feature -- Access

	line (i: INTEGER): STRING is
			-- Returns the content of the `i'th line.
		require
			valid_line: valid_line_index (i) and then
				(i = line_count implies last_line_not_empty)
		deferred
		ensure
			result_not_void: Result /= Void
		end


feature -- Status report

	current_line_number: INTEGER is
			-- Returns the number of the line the cursor currently
			-- is on.
		require
			exist: not destroyed
		deferred
		ensure
			valid_line_index: valid_line_index (Result)
		end

	line_count: INTEGER is
			-- Number of lines in widget
		require
			exist: not destroyed
		deferred
		ensure
			result_greater_zero: Result > 0
		end 

	first_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the first character on the `i'-th line.
		require
			exist: not destroyed
			valid_line: valid_line_index (i) and then
				(i = line_count implies last_line_not_empty)
		deferred
		ensure
			valid_position: valid_position (i)
		end

	last_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the last character on the `i'-th line.
		require
			exist: not destroyed
			valid_line: valid_line_index (i) and then
				(i = line_count implies last_line_not_empty)
		deferred
		ensure
			valid_position: valid_position (i)
		end

	has_system_frozen_widget: BOOLEAN is
			-- Is there any widget frozen?
			-- If a widget is frozen any updates made to it
			-- will not be shown until the widget is
			-- thawn again.
		require
			exist: not destroyed
		deferred
		end

feature -- Status settings

	freeze is
			-- Freeze the widget.
			-- If the widget is frozen any updates made to the
			-- window will not be shown until the widget is
			-- thawn again.
			-- Note: Only one window can be frozen at a time.
			-- This is because of a limitation on Windows.
		require
			exist: not destroyed
			not_widget_is_frozen: not has_system_frozen_widget
		deferred
		ensure
			is_frozen: has_system_frozen_widget
		end

	thaw is
			-- Thaw a frozen widget.
		require
			exist: not destroyed
			is_frozen: has_system_frozen_widget
		deferred
		ensure
			no_widget_is_frozen: not has_system_frozen_widget
		end

	set_default_options is
			-- Initialize the options of the widget.
		do
			set_expand (True)
			set_vertical_resize (True)
			set_horizontal_resize (True)
		end

feature -- Basic operation

	put_new_line is
			-- Go to the beginning of the following line.
		require
			exists: not destroyed
		deferred
		end

	search (str: STRING; start: INTEGER): INTEGER is
			-- Position of first occurrence of `str' at or after `start';
			-- 0 if none.
		require
			exists: not destroyed
			valid_string: str /= Void
		deferred
		end

feature -- Assertions

	valid_line_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid line index?
		require
			exist: not destroyed
		do
			Result := i > 0 and i <= line_count
		end

	last_line_not_empty: BOOLEAN is
			-- Has the last line at least one character?
		require
			exist: not destroyed
		deferred
		end

end -- class EV_TEXT_I

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

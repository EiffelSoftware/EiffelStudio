note
	description: "Wrapper for NSControl."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CONTROL

inherit
	NS_VIEW
		redefine
			make
		end

	TARGET_ACTION_SUPPORT
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Creation

	make
		do
			make_from_pointer ({NS_CONTROL_API}.new)
		end

feature -- Access

	set_double_value (a_double: DOUBLE)
			-- Sets the value of the receiver's cell using a double-precision floating-point number.
    		-- The value of the cell interpreted as a double-precision floating-point number.
			-- If the cell is being edited, this method aborts all editing before setting the value.
			-- If the cell does not inherit from NSActionCell, the method marks the cell's interior as needing to be redisplayed;
			-- NSActionCell performs its own updating of cells.
		do
			{NS_CONTROL_API}.set_double_value (item, a_double)
		ensure
			value_set: (a_double - double_value).abs < 0.03
		end

	double_value: DOUBLE
			-- Returns the value of the receiver's cell as a double-precision floating-point number.
			-- The value of the cell interpreted as a double-precision floating-point number.
			-- If the control contains many cells (for example, NSMatrix), then the value of the currently
			-- selected cell is returned. If the control is in the process of editing the affected cell, then
			-- it invokes the validateEditing method before extracting and returning the value.
		do
			Result := {NS_CONTROL_API}.double_value (item)
		end

	set_enabled (a_flag: BOOLEAN)
			-- Sets whether the receiver (and its cell) reacts to mouse events.
			-- True if you want the receiver to react to mouse events; otherwise, False.
			-- If flag is False, any editing is aborted. This method redraws the entire control if it is marked
			-- as needing redisplay. Subclasses may want to override this method to redraw only a portion of
			-- the control when the enabled state changes; NS_BUTTON and NS_SLIDER do this.
		do
			{NS_CONTROL_API}.set_enabled (item, a_flag)
		ensure
			enabled_set: a_flag = is_enabled
		end

	is_enabled: BOOLEAN
			-- Returns whether the receiver reacts to mouse events.
			-- True if the receiver responds to mouse events; otherwise False.
		do
			Result := {NS_CONTROL_API}.is_enabled (item)
		end

	set_string_value (a_string: STRING_GENERAL)
			-- Sets the value of the receiver's cell
			-- If the cell is being edited, this method aborts all editing before setting the value.
			-- If the cell does not inherit from NSActionCell, the method marks the cell's interior as needing to be redisplayed; NSActionCell performs its own updating of cells.
		do
			{NS_CONTROL_API}.set_string_value (item, (create {NS_STRING}.make_with_string (a_string)).item)
		ensure
			string_value_set:
		end

	string_value: NS_STRING -- assign set_string_value
		do
			create Result.share_from_pointer ({NS_CONTROL_API}.string_value (item))
		end

	set_cell (a_cell: NS_CELL)
			-- Sets the receiver's cell
			-- Use this method with great care as it can irrevocably damage the affected control;
			-- specifically, you should only use this method in initializers for subclasses of NS_CONTROL.
		do
			{NS_CONTROL_API}.set_cell (item, a_cell.item)
		ensure
			cell_set: a_cell = cell
		end

	cell: NS_CELL
			-- Returns the receiver's cell object.
		do
			create Result.share_from_pointer ({NS_CONTROL_API}.cell (item))
		ensure
			result_not_void: Result /= void
		end

feature -- Formatting Text

	alignment: INTEGER
			-- Returns the alignment mode of the text in the receiver's cell.
			-- The default value is NSNaturalTextAlignment
		do
			Result := {NS_CONTROL_API}.alignment (item)
		ensure
			valid_alignment: valid_alignment (Result)
		end

	set_alignment (a_alignment: INTEGER)
		require
			valid_alignment: valid_alignment (a_alignment)
		do
			{NS_CONTROL_API}.set_alignment (item, a_alignment)
		ensure
			alignment_set: alignment = a_alignment
		end

	font: NS_FONT
			-- Returns the font used to draw text in the receiver's cell.
		do
			create Result.share_from_pointer ({NS_CONTROL_API}.font (item))
		end

	set_font (a_font: NS_FONT)
			-- Sets the font used to draw text in the receiver's cell.
			-- If the cell is being edited, the text in the cell is redrawn in the new font, and the cell's editor
			-- (the NSText object used globally for editing) is updated with the new font object.
		do
			{NS_CONTROL_API}.set_font (item, a_font.item)
		ensure
			font_set: a_font.is_equal (font)
		end

feature -- Contract support

	valid_alignment (a_int: INTEGER): BOOLEAN
		do
			Result := (<<left_text_alignment, right_text_alignment, center_text_alignment, justified_text_alignment>>).has (a_int)
		end

feature -- NSTextAlignment Constants -- FIXME: move to NS_TEXT

	frozen left_text_alignment: INTEGER
			-- NSLeftTextAlignment
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSLeftTextAlignment"
		end

	frozen right_text_alignment: INTEGER
			-- NSRightTextAlignment
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRightTextAlignment"
		end

	frozen center_text_alignment: INTEGER
			-- NSCenterTextAlignment
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSCenterTextAlignment"
		end

	frozen justified_text_alignment: INTEGER
			-- NSJustifiedTextAlignment
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSJustifiedTextAlignment"
		end

	frozen natural_text_alignment: INTEGER
			-- NSNaturalTextAlignment
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSNaturalTextAlignment"
		end

end

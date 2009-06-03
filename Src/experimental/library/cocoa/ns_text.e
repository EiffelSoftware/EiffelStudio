note
	description: "Wrapper for NSText."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_TEXT

inherit
	NS_VIEW

feature -- Access

	string: NS_STRING
		do
			create Result.make_shared (text_string (item))
		end

	set_string (a_string: STRING_GENERAL)
			-- Replaces the receiver's entire text with `a_string', applying the formatting attributes of the old first character to its new contents.
			-- This method does not include undo support by default. Clients must invoke shouldChangeTextInRanges:replacementStrings: or shouldChangeTextInRange:replacementString: to include this method in an undoable action.
		do
			text_set_string (item, (create {NS_STRING}.make_with_string (a_string)).item)
		ensure
			string_set: a_string.is_equal (string.to_string)
		end

	size_to_fit
			-- Resizes the receiver to fit its text.
			-- The text view will not be sized any smaller than its minimum size, however.
		do
			text_size_to_fit (item)
		ensure
			horizontal_resize: not is_horizontally_resizable implies old frame.size.width = frame.size.width
		end

	set_horizontally_resizable (a_flag: BOOLEAN)
			-- Controls whether the receiver changes its width to fit the width of its text.
		do
			text_set_horizontally_resizable (item, a_flag)
		ensure
			flag_set: is_horizontally_resizable = a_flag
		end

	is_horizontally_resizable: BOOLEAN
			-- Returns True if the receiver automatically changes its width to accommodate the width of its text, False if it doesn't
			-- By default, an NSText object is not horizontally resizable.
		do
			Result := text_is_horizontally_resizable (item)
		end

	selected_range: NS_RANGE
			-- Returns the range of selected characters.
		do
			create Result.make
			text_selected_range (item, Result.item)
		ensure
			valid_location: 0 <= Result.location -- and Result.location <= string.length
			valid_length: 0 <= Result.length -- and Result.length <= string.length - Result.location
		end

feature {NONE} -- Objective-C Implementation

	frozen text_string (a_nstext: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSText*)$a_nstext string];"
		end

	frozen text_set_string (a_nstext: POINTER; a_nsstring: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSText*)$a_nstext setString: $a_nsstring];"
		end

feature {NONE} -- Constraining Size

	frozen text_size_to_fit (a_nstext: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSText*)$a_nstext sizeToFit];"
		end

	frozen text_set_horizontally_resizable (a_nstext: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSText*)$a_nstext setHorizontallyResizable: $a_flag];"
		end

	frozen text_is_horizontally_resizable (a_nstext: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSText*)$a_nstext isHorizontallyResizable];"
		end

feature {NONE} -- Changing the Selection

	frozen text_selected_range (a_nstext: POINTER; res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRange range = [(NSText*)$a_nstext selectedRange]; memcpy($res, &range, sizeof(NSRange));"
		end

end

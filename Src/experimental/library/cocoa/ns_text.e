note
	description: "Wrapper for NSText."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_TEXT

inherit
	NS_VIEW

	NS_TEXT_DELEGATE

feature -- Access

	string: NS_STRING
		do
			create Result.make_from_pointer ({NS_TEXT_API}.string (item))
		end

	size_to_fit
			-- Resizes the receiver to fit its text.
			-- The text view will not be sized any smaller than its minimum size, however.
		do
			{NS_TEXT_API}.size_to_fit (item)
		ensure
			horizontal_resize: not is_horizontally_resizable implies old frame.size.width = frame.size.width
		end

	set_horizontally_resizable (a_flag: BOOLEAN)
			-- Controls whether the receiver changes its width to fit the width of its text.
		do
			{NS_TEXT_API}.set_horizontally_resizable (item, a_flag)
		ensure
			flag_set: is_horizontally_resizable = a_flag
		end

	is_horizontally_resizable: BOOLEAN
			-- Returns True if the receiver automatically changes its width to accommodate the width of its text, False if it doesn't
			-- By default, an NSText object is not horizontally resizable.
		do
			Result := {NS_TEXT_API}.is_horizontally_resizable (item)
		end

	selected_range: NS_RANGE
			-- Returns the range of selected characters.
		do
			create Result.make
			{NS_TEXT_API}.selected_range (item, Result.item)
		ensure
			valid_location: 0 <= Result.location -- and Result.location <= string.length
			valid_length: 0 <= Result.length -- and Result.length <= string.length - Result.location
		end

feature -- Replacing Text

	replace_characters_in_range_with_string (a_range: NS_RANGE; a_string: NS_STRING)
			-- Replaces the characters in the given range with those in the given string.
			-- For a rich text object, the text of aString is assigned the formatting attributes of the first character of the text it replaces,
			-- or of the character immediately before aRange if the range's length is 0. If the range's location is 0, the formatting attributes of the first character in the receiver are used.
			-- This method does not include undo support by default. Clients must invoke shouldChangeTextInRanges:replacementStrings: or
			-- shouldChangeTextInRange:replacementString:to include this method in an undoable action.
			-- In most cases, programmatic modification of the text is best done by operating on the text storage directly, using the general methods of NSMutableAttributedString.
		do
			{NS_TEXT_API}.replace_characters_in_range_with_string (item, a_range.item, a_string.item)
		end

	set_string (a_string: NS_STRING)
			-- Replaces the receiver's entire text with `a_string', applying the formatting attributes of the old first character to its new contents.
			-- This method does not include undo support by default. Clients must invoke shouldChangeTextInRanges:replacementStrings: or shouldChangeTextInRange:replacementString: to include this method in an undoable action.
		do
			{NS_TEXT_API}.set_string (item, a_string.item)
		ensure
			string_set: a_string.is_equal (string)
		end

feature -- Scrolling

	scroll_range_to_visible (a_range: NS_RANGE)
			-- Scrolls the receiver in its enclosing scroll view so the first characters of aRange are visible.
		do
			{NS_TEXT_API}.scroll_range_to_visible (item, a_range.item)
		end

end

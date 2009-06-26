note
	description: "Summary description for {NS_TEXT_VIEW}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_VIEW

inherit
	NS_TEXT
		redefine
			make
		end
create
	make
create {NS_OBJECT}
	share_from_pointer

feature {NONE} -- Creation

	make
		do
			make_from_pointer (text_view_new)
			init_delegate
		end

feature -- Managing the Selection

	set_selected_range (a_range: NS_RANGE)
			-- Sets the selection to the characters in a single range.
			-- This method sets the selection to the characters in charRange, resets the selection granularity to NSSelectByCharacter, and posts an NSTextViewDidChangeSelectionNotification to the default notification center. It also removes the marking from marked text if the new selection is greater than the marked region.
		do
			text_view_set_selected_range (item, a_range.item)
		end

feature {NONE} -- Objective-C Implementation

	frozen text_view_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTextView new];"
		end

	frozen text_view_set_selected_range (a_target, a_range: POINTER)
			-- - (void)setSelectedRange:(NSRange)charRange
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextView*)$a_target setSelectedRange: *(NSRange*)$a_range];"
		end

end

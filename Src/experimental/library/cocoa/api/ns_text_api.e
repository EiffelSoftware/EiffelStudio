note
	description: "Summary description for {NS_TEXT_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_API

feature -- Objective-C Implementation

	frozen string (a_nstext: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSText*)$a_nstext string];"
		end

feature -- Constraining Size

	frozen size_to_fit (a_nstext: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSText*)$a_nstext sizeToFit];"
		end

	frozen set_horizontally_resizable (a_nstext: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSText*)$a_nstext setHorizontallyResizable: $a_flag];"
		end

	frozen is_horizontally_resizable (a_nstext: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSText*)$a_nstext isHorizontallyResizable];"
		end

feature -- Changing the Selection

	frozen selected_range (a_nstext: POINTER; res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRange range = [(NSText*)$a_nstext selectedRange]; memcpy($res, &range, sizeof(NSRange));"
		end

feature -- Replacing Text

	frozen replace_characters_in_range_with_string (a_nstext: POINTER; a_range: POINTER; a_string: POINTER)
			-- - (void)replaceCharactersInRange:(NSRange)aRange withString:(NSString *)aString
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSText*)$a_nstext replaceCharactersInRange: *(NSRange*)$a_range withString: $a_string];"
		end

	frozen set_string (a_nstext: POINTER; a_nsstring: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSText*)$a_nstext setString: $a_nsstring];"
		end

feature --

	frozen scroll_range_to_visible (a_nstext: POINTER; a_range: POINTER)
			-- - (void)scrollRangeToVisible:(NSRange)aRange
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSText*)$a_nstext scrollRangeToVisible: *(NSRange*)$a_range];"
		end

end

note
	description: "Summary description for {NS_ATTRIBUTED_STRING}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ATTRIBUTED_STRING

inherit
	NS_OBJECT

create
	make_with_string

feature {NONE} -- Creation

	make_with_string (a_string: NS_STRING)
			-- Creates an NS_ATTRIBUTED_STRING object initialized with the characters of a given string and no attribute information.
		do
			make_from_pointer (new)
			init_with_string (item, a_string.item)
		end

feature {NONE} -- Implementation

	frozen new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSAttributedString new];"
		end

	frozen init_with_string (target: POINTER; a_string: POINTER)
			-- - (id)initWithString:(NSString *)aString
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSAttributedString*)$target initWithString: $a_string];"
		end

end

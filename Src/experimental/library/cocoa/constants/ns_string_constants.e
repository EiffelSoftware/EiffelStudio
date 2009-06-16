note
	description: "Summary description for {NS_STRING_CONSTANTS}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_STRING_CONSTANTS

feature -- Access

	font_attribute_name: NS_STRING
		once
			create Result.make_from_pointer (ns_font_attribute_name)
		ensure
			Result /= void
		end

	frozen ns_font_attribute_name: POINTER
			-- NSFontAttributeName
			-- TODO Not sure where this should go
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSFontAttributeName;"
		end

end

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
		end

	frozen ns_font_attribute_name: POINTER
			-- NSFontAttributeName
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSFontAttributeName"
		end

end

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

	set_string (a_string: STRING)
		do
			text_set_string (item, (create {NS_STRING}.make_with_string (a_string)).item)
		end

feature {NONE} -- Objective-C Implementation

	frozen text_set_string (a_nstext: POINTER; a_nsstring: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSText*)$a_nstext setString: $a_nsstring];"
		end

end

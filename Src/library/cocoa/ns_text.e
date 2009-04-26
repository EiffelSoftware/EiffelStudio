note
	description: "Summary description for {NS_TEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_TEXT

inherit
	NS_VIEW

feature

	set_string (a_string: STRING)
		do
			text_set_string (cocoa_object, (create {NS_STRING}.make_with_string (a_string)).cocoa_object)
		end

feature {NONE} -- Objective-C Implementation

	frozen text_set_string (a_nstext: POINTER; a_nsstring: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSText*)$a_nstext setString: $a_nsstring];"
		end

end

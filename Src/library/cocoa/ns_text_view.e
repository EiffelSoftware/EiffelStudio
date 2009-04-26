note
	description: "Summary description for {NS_TEXT_VIEW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_VIEW

inherit
	NS_TEXT
		redefine
			new
		end
create
	new

feature

	new
		do
			cocoa_object := text_view_new
		end

feature {NONE} -- Objective-C Implementation

	frozen text_view_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTextView new];"
		end

end

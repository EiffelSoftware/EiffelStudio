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

feature

	make
		do
			make_shared (text_view_new)
		end

feature {NONE} -- Objective-C Implementation

	frozen text_view_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTextView new];"
		end

end

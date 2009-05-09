note
	description: "Summary description for {EV_COCOA_EXTERNALS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COCOA_EXTERNALS

feature -- Helpers

	frozen date_distant_future: POINTER
			--
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSDate distantFuture];"
		end

end

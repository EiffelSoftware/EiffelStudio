note
	description: "Summary description for {NS_SECURE_TEXT_FIELD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SECURE_TEXT_FIELD

inherit
	NS_TEXT_FIELD
		redefine
			new
		end

create
	new

feature -- Creation

	new
		do
			cocoa_object := secure_text_field_new
		end


feature {NONE} -- Objective-C implementation

	frozen secure_text_field_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSSecureTextField new];"
		end
end

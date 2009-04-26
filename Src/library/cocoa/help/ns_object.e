note
	description: "Summary description for {NS_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OBJECT

feature {NS_OBJECT}

	make_shared (a_pointer: POINTER)
		do
			-- FIXME: check if the pointer is valid and points to an NS_OBJECT object! (precondition)
			-- descendants should also check if the type of the cocoa object is what they need
			cocoa_object := a_pointer
		end

feature -- Constants

	font_attribute_name: NS_STRING
		once
			create Result.make_shared (ns_font_attribute_name)
		end

	frozen ns_font_attribute_name: POINTER
			-- NSFontAttributeName
			-- TODO Not sure where this should go
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSFontAttributeName;"
		end


feature {NONE} -- Shared functionality

	frozen target_new (an_object: POINTER; a_method: POINTER): POINTER
		external
			"C inline use %"actions.h%""
		alias
			"return [[SelectorWrapper new] initWithCallbackObject: $an_object andMethod: $a_method];"
		end

feature {NS_OBJECT} -- Should be used by classes in native only

	cocoa_object: POINTER
	 	-- The C-pointer to the Cocoa object

end

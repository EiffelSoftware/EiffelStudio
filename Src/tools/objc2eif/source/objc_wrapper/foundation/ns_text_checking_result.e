note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_CHECKING_RESULT

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- Properties

	result_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_result_type (item)
		end

	range: NS_RANGE
			-- Auto generated Objective-C wrapper.
		do
			create Result.make
			objc_range (item, Result.item)
		end

feature {NONE} -- Properties Externals

	objc_result_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSTextCheckingResult *)$an_item resultType];
			 ]"
		end

	objc_range (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSTextCheckingResult *)$an_item range];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTextCheckingResult"
		end

end

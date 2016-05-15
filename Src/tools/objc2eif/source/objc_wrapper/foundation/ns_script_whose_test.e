note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCRIPT_WHOSE_TEST

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSScriptWhoseTest

	is_true: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_true (item)
		end

feature {NONE} -- NSScriptWhoseTest Externals

	objc_is_true (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptWhoseTest *)$an_item isTrue];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSScriptWhoseTest"
		end

end

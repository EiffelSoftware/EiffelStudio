note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_AUTORELEASE_POOL

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSAutoreleasePool

	drain
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_drain (item)
		end

feature {NONE} -- NSAutoreleasePool Externals

	objc_drain (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAutoreleasePool *)$an_item drain];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSAutoreleasePool"
		end

end

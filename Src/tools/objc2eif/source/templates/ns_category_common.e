note
	description: "Common mechanisms to be inherited by *_CAT classes."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_CATEGORY_COMMON

inherit
	NS_ANY

feature {NONE} -- Externals

	objc_class_objc (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSObject>)$an_item class];
			 ]"
		end

end

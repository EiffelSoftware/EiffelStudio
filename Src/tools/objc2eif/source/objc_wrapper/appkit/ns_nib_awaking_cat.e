note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NIB_AWAKING_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSNibAwaking

	awake_from_nib (a_ns_object: NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_awake_from_nib (a_ns_object.item)
		end

feature {NONE} -- NSNibAwaking Externals

	objc_awake_from_nib (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item awakeFromNib];
			 ]"
		end

end

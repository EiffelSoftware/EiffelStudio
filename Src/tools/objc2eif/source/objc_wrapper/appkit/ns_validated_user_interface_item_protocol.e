note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_VALIDATED_USER_INTERFACE_ITEM_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

	action: detachable OBJC_SELECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_action (item)
			if result_pointer /= default_pointer then
				create {OBJC_SELECTOR} Result.make_with_pointer (result_pointer)
			end
			
		end

	tag: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tag (item)
		end

feature {NONE} -- Required Methods Externals

	objc_action (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSValidatedUserInterfaceItem>)$an_item action];
			 ]"
		end

	objc_tag (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSValidatedUserInterfaceItem>)$an_item tag];
			 ]"
		end

end

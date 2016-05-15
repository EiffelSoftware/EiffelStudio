note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TOOLBAR_ITEM_VALIDATION_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSToolbarItemValidation

	validate_toolbar_item_ (a_ns_object: NS_OBJECT; a_the_item: detachable NS_TOOLBAR_ITEM): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_the_item__item: POINTER
		do
			if attached a_the_item as a_the_item_attached then
				a_the_item__item := a_the_item_attached.item
			end
			Result := objc_validate_toolbar_item_ (a_ns_object.item, a_the_item__item)
		end

feature {NONE} -- NSToolbarItemValidation Externals

	objc_validate_toolbar_item_ (an_item: POINTER; a_the_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item validateToolbarItem:$a_the_item];
			 ]"
		end

end

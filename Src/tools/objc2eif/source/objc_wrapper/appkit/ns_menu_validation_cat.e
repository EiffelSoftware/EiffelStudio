note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MENU_VALIDATION_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSMenuValidation

	validate_menu_item_ (a_ns_object: NS_OBJECT; a_menu_item: detachable NS_MENU_ITEM): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_menu_item__item: POINTER
		do
			if attached a_menu_item as a_menu_item_attached then
				a_menu_item__item := a_menu_item_attached.item
			end
			Result := objc_validate_menu_item_ (a_ns_object.item, a_menu_item__item)
		end

feature {NONE} -- NSMenuValidation Externals

	objc_validate_menu_item_ (an_item: POINTER; a_menu_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item validateMenuItem:$a_menu_item];
			 ]"
		end

end

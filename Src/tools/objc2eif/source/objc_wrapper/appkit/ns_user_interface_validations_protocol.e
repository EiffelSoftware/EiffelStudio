note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_USER_INTERFACE_VALIDATIONS_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

	validate_user_interface_item_ (an_item: detachable NS_VALIDATED_USER_INTERFACE_ITEM_PROTOCOL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			an_item__item: POINTER
		do
			if attached an_item as an_item_attached then
				an_item__item := an_item_attached.item
			end
			Result := objc_validate_user_interface_item_ (item, an_item__item)
		end

feature {NONE} -- Required Methods Externals

	objc_validate_user_interface_item_ (an_item: POINTER; a_an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSUserInterfaceValidations>)$an_item validateUserInterfaceItem:$a_an_item];
			 ]"
		end

end

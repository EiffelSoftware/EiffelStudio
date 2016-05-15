note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_TOOLBAR_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	toolbar__item_for_item_identifier__will_be_inserted_into_toolbar_ (a_toolbar: detachable NS_TOOLBAR; a_item_identifier: detachable NS_STRING; a_flag: BOOLEAN): detachable NS_TOOLBAR_ITEM
			-- Auto generated Objective-C wrapper.
		require
			has_toolbar__item_for_item_identifier__will_be_inserted_into_toolbar_: has_toolbar__item_for_item_identifier__will_be_inserted_into_toolbar_
		local
			result_pointer: POINTER
			a_toolbar__item: POINTER
			a_item_identifier__item: POINTER
		do
			if attached a_toolbar as a_toolbar_attached then
				a_toolbar__item := a_toolbar_attached.item
			end
			if attached a_item_identifier as a_item_identifier_attached then
				a_item_identifier__item := a_item_identifier_attached.item
			end
			result_pointer := objc_toolbar__item_for_item_identifier__will_be_inserted_into_toolbar_ (item, a_toolbar__item, a_item_identifier__item, a_flag)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like toolbar__item_for_item_identifier__will_be_inserted_into_toolbar_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like toolbar__item_for_item_identifier__will_be_inserted_into_toolbar_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	toolbar_default_item_identifiers_ (a_toolbar: detachable NS_TOOLBAR): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		require
			has_toolbar_default_item_identifiers_: has_toolbar_default_item_identifiers_
		local
			result_pointer: POINTER
			a_toolbar__item: POINTER
		do
			if attached a_toolbar as a_toolbar_attached then
				a_toolbar__item := a_toolbar_attached.item
			end
			result_pointer := objc_toolbar_default_item_identifiers_ (item, a_toolbar__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like toolbar_default_item_identifiers_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like toolbar_default_item_identifiers_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	toolbar_allowed_item_identifiers_ (a_toolbar: detachable NS_TOOLBAR): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		require
			has_toolbar_allowed_item_identifiers_: has_toolbar_allowed_item_identifiers_
		local
			result_pointer: POINTER
			a_toolbar__item: POINTER
		do
			if attached a_toolbar as a_toolbar_attached then
				a_toolbar__item := a_toolbar_attached.item
			end
			result_pointer := objc_toolbar_allowed_item_identifiers_ (item, a_toolbar__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like toolbar_allowed_item_identifiers_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like toolbar_allowed_item_identifiers_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	toolbar_selectable_item_identifiers_ (a_toolbar: detachable NS_TOOLBAR): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		require
			has_toolbar_selectable_item_identifiers_: has_toolbar_selectable_item_identifiers_
		local
			result_pointer: POINTER
			a_toolbar__item: POINTER
		do
			if attached a_toolbar as a_toolbar_attached then
				a_toolbar__item := a_toolbar_attached.item
			end
			result_pointer := objc_toolbar_selectable_item_identifiers_ (item, a_toolbar__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like toolbar_selectable_item_identifiers_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like toolbar_selectable_item_identifiers_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	toolbar_will_add_item_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_toolbar_will_add_item_: has_toolbar_will_add_item_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_toolbar_will_add_item_ (item, a_notification__item)
		end

	toolbar_did_remove_item_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_toolbar_did_remove_item_: has_toolbar_did_remove_item_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_toolbar_did_remove_item_ (item, a_notification__item)
		end

feature -- Status Report

	has_toolbar__item_for_item_identifier__will_be_inserted_into_toolbar_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_toolbar__item_for_item_identifier__will_be_inserted_into_toolbar_ (item)
		end

	has_toolbar_default_item_identifiers_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_toolbar_default_item_identifiers_ (item)
		end

	has_toolbar_allowed_item_identifiers_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_toolbar_allowed_item_identifiers_ (item)
		end

	has_toolbar_selectable_item_identifiers_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_toolbar_selectable_item_identifiers_ (item)
		end

	has_toolbar_will_add_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_toolbar_will_add_item_ (item)
		end

	has_toolbar_did_remove_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_toolbar_did_remove_item_ (item)
		end

feature -- Status Report Externals

	objc_has_toolbar__item_for_item_identifier__will_be_inserted_into_toolbar_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(toolbar:itemForItemIdentifier:willBeInsertedIntoToolbar:)];
			 ]"
		end

	objc_has_toolbar_default_item_identifiers_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(toolbarDefaultItemIdentifiers:)];
			 ]"
		end

	objc_has_toolbar_allowed_item_identifiers_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(toolbarAllowedItemIdentifiers:)];
			 ]"
		end

	objc_has_toolbar_selectable_item_identifiers_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(toolbarSelectableItemIdentifiers:)];
			 ]"
		end

	objc_has_toolbar_will_add_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(toolbarWillAddItem:)];
			 ]"
		end

	objc_has_toolbar_did_remove_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(toolbarDidRemoveItem:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_toolbar__item_for_item_identifier__will_be_inserted_into_toolbar_ (an_item: POINTER; a_toolbar: POINTER; a_item_identifier: POINTER; a_flag: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSToolbarDelegate>)$an_item toolbar:$a_toolbar itemForItemIdentifier:$a_item_identifier willBeInsertedIntoToolbar:$a_flag];
			 ]"
		end

	objc_toolbar_default_item_identifiers_ (an_item: POINTER; a_toolbar: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSToolbarDelegate>)$an_item toolbarDefaultItemIdentifiers:$a_toolbar];
			 ]"
		end

	objc_toolbar_allowed_item_identifiers_ (an_item: POINTER; a_toolbar: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSToolbarDelegate>)$an_item toolbarAllowedItemIdentifiers:$a_toolbar];
			 ]"
		end

	objc_toolbar_selectable_item_identifiers_ (an_item: POINTER; a_toolbar: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSToolbarDelegate>)$an_item toolbarSelectableItemIdentifiers:$a_toolbar];
			 ]"
		end

	objc_toolbar_will_add_item_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSToolbarDelegate>)$an_item toolbarWillAddItem:$a_notification];
			 ]"
		end

	objc_toolbar_did_remove_item_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSToolbarDelegate>)$an_item toolbarDidRemoveItem:$a_notification];
			 ]"
		end

end

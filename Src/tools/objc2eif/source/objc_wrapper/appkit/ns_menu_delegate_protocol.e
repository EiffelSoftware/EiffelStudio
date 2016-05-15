note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_MENU_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	menu_needs_update_ (a_menu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		require
			has_menu_needs_update_: has_menu_needs_update_
		local
			a_menu__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			objc_menu_needs_update_ (item, a_menu__item)
		end

	number_of_items_in_menu_ (a_menu: detachable NS_MENU): INTEGER_64
			-- Auto generated Objective-C wrapper.
		require
			has_number_of_items_in_menu_: has_number_of_items_in_menu_
		local
			a_menu__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			Result := objc_number_of_items_in_menu_ (item, a_menu__item)
		end

	menu__update_item__at_index__should_cancel_ (a_menu: detachable NS_MENU; a_item: detachable NS_MENU_ITEM; a_index: INTEGER_64; a_should_cancel: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_menu__update_item__at_index__should_cancel_: has_menu__update_item__at_index__should_cancel_
		local
			a_menu__item: POINTER
			a_item__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_menu__update_item__at_index__should_cancel_ (item, a_menu__item, a_item__item, a_index, a_should_cancel)
		end

--	menu_has_key_equivalent__for_event__target__action_ (a_menu: detachable NS_MENU; a_event: detachable NS_EVENT; a_target: UNSUPPORTED_TYPE; a_action: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		require
--			has_menu_has_key_equivalent__for_event__target__action_: has_menu_has_key_equivalent__for_event__target__action_
--		local
--			a_menu__item: POINTER
--			a_event__item: POINTER
--			a_target__item: POINTER
--			a_action__item: POINTER
--		do
--			if attached a_menu as a_menu_attached then
--				a_menu__item := a_menu_attached.item
--			end
--			if attached a_event as a_event_attached then
--				a_event__item := a_event_attached.item
--			end
--			if attached a_target as a_target_attached then
--				a_target__item := a_target_attached.item
--			end
--			if attached a_action as a_action_attached then
--				a_action__item := a_action_attached.item
--			end
--			Result := objc_menu_has_key_equivalent__for_event__target__action_ (item, a_menu__item, a_event__item, a_target__item, a_action__item)
--		end

	menu_will_open_ (a_menu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		require
			has_menu_will_open_: has_menu_will_open_
		local
			a_menu__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			objc_menu_will_open_ (item, a_menu__item)
		end

	menu_did_close_ (a_menu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		require
			has_menu_did_close_: has_menu_did_close_
		local
			a_menu__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			objc_menu_did_close_ (item, a_menu__item)
		end

	menu__will_highlight_item_ (a_menu: detachable NS_MENU; a_item: detachable NS_MENU_ITEM)
			-- Auto generated Objective-C wrapper.
		require
			has_menu__will_highlight_item_: has_menu__will_highlight_item_
		local
			a_menu__item: POINTER
			a_item__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_menu__will_highlight_item_ (item, a_menu__item, a_item__item)
		end

	confinement_rect_for_menu__on_screen_ (a_menu: detachable NS_MENU; a_screen: detachable NS_SCREEN): NS_RECT
			-- Auto generated Objective-C wrapper.
		require
			has_confinement_rect_for_menu__on_screen_: has_confinement_rect_for_menu__on_screen_
		local
			a_menu__item: POINTER
			a_screen__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			if attached a_screen as a_screen_attached then
				a_screen__item := a_screen_attached.item
			end
			create Result.make
			objc_confinement_rect_for_menu__on_screen_ (item, Result.item, a_menu__item, a_screen__item)
		end

feature -- Status Report

	has_menu_needs_update_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_menu_needs_update_ (item)
		end

	has_number_of_items_in_menu_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_number_of_items_in_menu_ (item)
		end

	has_menu__update_item__at_index__should_cancel_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_menu__update_item__at_index__should_cancel_ (item)
		end

--	has_menu_has_key_equivalent__for_event__target__action_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_menu_has_key_equivalent__for_event__target__action_ (item)
--		end

	has_menu_will_open_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_menu_will_open_ (item)
		end

	has_menu_did_close_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_menu_did_close_ (item)
		end

	has_menu__will_highlight_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_menu__will_highlight_item_ (item)
		end

	has_confinement_rect_for_menu__on_screen_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_confinement_rect_for_menu__on_screen_ (item)
		end

feature -- Status Report Externals

	objc_has_menu_needs_update_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(menuNeedsUpdate:)];
			 ]"
		end

	objc_has_number_of_items_in_menu_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(numberOfItemsInMenu:)];
			 ]"
		end

	objc_has_menu__update_item__at_index__should_cancel_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(menu:updateItem:atIndex:shouldCancel:)];
			 ]"
		end

--	objc_has_menu_has_key_equivalent__for_event__target__action_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(menuHasKeyEquivalent:forEvent:target:action:)];
--			 ]"
--		end

	objc_has_menu_will_open_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(menuWillOpen:)];
			 ]"
		end

	objc_has_menu_did_close_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(menuDidClose:)];
			 ]"
		end

	objc_has_menu__will_highlight_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(menu:willHighlightItem:)];
			 ]"
		end

	objc_has_confinement_rect_for_menu__on_screen_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(confinementRectForMenu:onScreen:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_menu_needs_update_ (an_item: POINTER; a_menu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSMenuDelegate>)$an_item menuNeedsUpdate:$a_menu];
			 ]"
		end

	objc_number_of_items_in_menu_ (an_item: POINTER; a_menu: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSMenuDelegate>)$an_item numberOfItemsInMenu:$a_menu];
			 ]"
		end

	objc_menu__update_item__at_index__should_cancel_ (an_item: POINTER; a_menu: POINTER; a_item: POINTER; a_index: INTEGER_64; a_should_cancel: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSMenuDelegate>)$an_item menu:$a_menu updateItem:$a_item atIndex:$a_index shouldCancel:$a_should_cancel];
			 ]"
		end

--	objc_menu_has_key_equivalent__for_event__target__action_ (an_item: POINTER; a_menu: POINTER; a_event: POINTER; a_target: UNSUPPORTED_TYPE; a_action: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id <NSMenuDelegate>)$an_item menuHasKeyEquivalent:$a_menu forEvent:$a_event target: action:];
--			 ]"
--		end

	objc_menu_will_open_ (an_item: POINTER; a_menu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSMenuDelegate>)$an_item menuWillOpen:$a_menu];
			 ]"
		end

	objc_menu_did_close_ (an_item: POINTER; a_menu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSMenuDelegate>)$an_item menuDidClose:$a_menu];
			 ]"
		end

	objc_menu__will_highlight_item_ (an_item: POINTER; a_menu: POINTER; a_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSMenuDelegate>)$an_item menu:$a_menu willHighlightItem:$a_item];
			 ]"
		end

	objc_confinement_rect_for_menu__on_screen_ (an_item: POINTER; result_pointer: POINTER; a_menu: POINTER; a_screen: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(id <NSMenuDelegate>)$an_item confinementRectForMenu:$a_menu onScreen:$a_screen];
			 ]"
		end

end

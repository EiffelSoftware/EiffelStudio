note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_TAB_VIEW_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	tab_view__should_select_tab_view_item_ (a_tab_view: detachable NS_TAB_VIEW; a_tab_view_item: detachable NS_TAB_VIEW_ITEM): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_tab_view__should_select_tab_view_item_: has_tab_view__should_select_tab_view_item_
		local
			a_tab_view__item: POINTER
			a_tab_view_item__item: POINTER
		do
			if attached a_tab_view as a_tab_view_attached then
				a_tab_view__item := a_tab_view_attached.item
			end
			if attached a_tab_view_item as a_tab_view_item_attached then
				a_tab_view_item__item := a_tab_view_item_attached.item
			end
			Result := objc_tab_view__should_select_tab_view_item_ (item, a_tab_view__item, a_tab_view_item__item)
		end

	tab_view__will_select_tab_view_item_ (a_tab_view: detachable NS_TAB_VIEW; a_tab_view_item: detachable NS_TAB_VIEW_ITEM)
			-- Auto generated Objective-C wrapper.
		require
			has_tab_view__will_select_tab_view_item_: has_tab_view__will_select_tab_view_item_
		local
			a_tab_view__item: POINTER
			a_tab_view_item__item: POINTER
		do
			if attached a_tab_view as a_tab_view_attached then
				a_tab_view__item := a_tab_view_attached.item
			end
			if attached a_tab_view_item as a_tab_view_item_attached then
				a_tab_view_item__item := a_tab_view_item_attached.item
			end
			objc_tab_view__will_select_tab_view_item_ (item, a_tab_view__item, a_tab_view_item__item)
		end

	tab_view__did_select_tab_view_item_ (a_tab_view: detachable NS_TAB_VIEW; a_tab_view_item: detachable NS_TAB_VIEW_ITEM)
			-- Auto generated Objective-C wrapper.
		require
			has_tab_view__did_select_tab_view_item_: has_tab_view__did_select_tab_view_item_
		local
			a_tab_view__item: POINTER
			a_tab_view_item__item: POINTER
		do
			if attached a_tab_view as a_tab_view_attached then
				a_tab_view__item := a_tab_view_attached.item
			end
			if attached a_tab_view_item as a_tab_view_item_attached then
				a_tab_view_item__item := a_tab_view_item_attached.item
			end
			objc_tab_view__did_select_tab_view_item_ (item, a_tab_view__item, a_tab_view_item__item)
		end

	tab_view_did_change_number_of_tab_view_items_ (a__tab_view: detachable NS_TAB_VIEW)
			-- Auto generated Objective-C wrapper.
		require
			has_tab_view_did_change_number_of_tab_view_items_: has_tab_view_did_change_number_of_tab_view_items_
		local
			a__tab_view__item: POINTER
		do
			if attached a__tab_view as a__tab_view_attached then
				a__tab_view__item := a__tab_view_attached.item
			end
			objc_tab_view_did_change_number_of_tab_view_items_ (item, a__tab_view__item)
		end

feature -- Status Report

	has_tab_view__should_select_tab_view_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_tab_view__should_select_tab_view_item_ (item)
		end

	has_tab_view__will_select_tab_view_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_tab_view__will_select_tab_view_item_ (item)
		end

	has_tab_view__did_select_tab_view_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_tab_view__did_select_tab_view_item_ (item)
		end

	has_tab_view_did_change_number_of_tab_view_items_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_tab_view_did_change_number_of_tab_view_items_ (item)
		end

feature -- Status Report Externals

	objc_has_tab_view__should_select_tab_view_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tabView:shouldSelectTabViewItem:)];
			 ]"
		end

	objc_has_tab_view__will_select_tab_view_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tabView:willSelectTabViewItem:)];
			 ]"
		end

	objc_has_tab_view__did_select_tab_view_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tabView:didSelectTabViewItem:)];
			 ]"
		end

	objc_has_tab_view_did_change_number_of_tab_view_items_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tabViewDidChangeNumberOfTabViewItems:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_tab_view__should_select_tab_view_item_ (an_item: POINTER; a_tab_view: POINTER; a_tab_view_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTabViewDelegate>)$an_item tabView:$a_tab_view shouldSelectTabViewItem:$a_tab_view_item];
			 ]"
		end

	objc_tab_view__will_select_tab_view_item_ (an_item: POINTER; a_tab_view: POINTER; a_tab_view_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTabViewDelegate>)$an_item tabView:$a_tab_view willSelectTabViewItem:$a_tab_view_item];
			 ]"
		end

	objc_tab_view__did_select_tab_view_item_ (an_item: POINTER; a_tab_view: POINTER; a_tab_view_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTabViewDelegate>)$an_item tabView:$a_tab_view didSelectTabViewItem:$a_tab_view_item];
			 ]"
		end

	objc_tab_view_did_change_number_of_tab_view_items_ (an_item: POINTER; a__tab_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTabViewDelegate>)$an_item tabViewDidChangeNumberOfTabViewItems:$a__tab_view];
			 ]"
		end

end

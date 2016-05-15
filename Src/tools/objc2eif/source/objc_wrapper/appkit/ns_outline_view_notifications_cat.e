note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OUTLINE_VIEW_NOTIFICATIONS_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSOutlineViewNotifications

	outline_view_selection_did_change_ (a_ns_object: NS_OBJECT; a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_outline_view_selection_did_change_ (a_ns_object.item, a_notification__item)
		end

	outline_view_column_did_move_ (a_ns_object: NS_OBJECT; a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_outline_view_column_did_move_ (a_ns_object.item, a_notification__item)
		end

	outline_view_column_did_resize_ (a_ns_object: NS_OBJECT; a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_outline_view_column_did_resize_ (a_ns_object.item, a_notification__item)
		end

	outline_view_selection_is_changing_ (a_ns_object: NS_OBJECT; a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_outline_view_selection_is_changing_ (a_ns_object.item, a_notification__item)
		end

	outline_view_item_will_expand_ (a_ns_object: NS_OBJECT; a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_outline_view_item_will_expand_ (a_ns_object.item, a_notification__item)
		end

	outline_view_item_did_expand_ (a_ns_object: NS_OBJECT; a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_outline_view_item_did_expand_ (a_ns_object.item, a_notification__item)
		end

	outline_view_item_will_collapse_ (a_ns_object: NS_OBJECT; a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_outline_view_item_will_collapse_ (a_ns_object.item, a_notification__item)
		end

	outline_view_item_did_collapse_ (a_ns_object: NS_OBJECT; a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_outline_view_item_did_collapse_ (a_ns_object.item, a_notification__item)
		end

feature {NONE} -- NSOutlineViewNotifications Externals

	objc_outline_view_selection_did_change_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item outlineViewSelectionDidChange:$a_notification];
			 ]"
		end

	objc_outline_view_column_did_move_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item outlineViewColumnDidMove:$a_notification];
			 ]"
		end

	objc_outline_view_column_did_resize_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item outlineViewColumnDidResize:$a_notification];
			 ]"
		end

	objc_outline_view_selection_is_changing_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item outlineViewSelectionIsChanging:$a_notification];
			 ]"
		end

	objc_outline_view_item_will_expand_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item outlineViewItemWillExpand:$a_notification];
			 ]"
		end

	objc_outline_view_item_did_expand_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item outlineViewItemDidExpand:$a_notification];
			 ]"
		end

	objc_outline_view_item_will_collapse_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item outlineViewItemWillCollapse:$a_notification];
			 ]"
		end

	objc_outline_view_item_did_collapse_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item outlineViewItemDidCollapse:$a_notification];
			 ]"
		end

end

note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_DRAWER_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	drawer_should_open_ (a_sender: detachable NS_DRAWER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_drawer_should_open_: has_drawer_should_open_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			Result := objc_drawer_should_open_ (item, a_sender__item)
		end

	drawer_should_close_ (a_sender: detachable NS_DRAWER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_drawer_should_close_: has_drawer_should_close_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			Result := objc_drawer_should_close_ (item, a_sender__item)
		end

	drawer_will_resize_contents__to_size_ (a_sender: detachable NS_DRAWER; a_content_size: NS_SIZE): NS_SIZE
			-- Auto generated Objective-C wrapper.
		require
			has_drawer_will_resize_contents__to_size_: has_drawer_will_resize_contents__to_size_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			create Result.make
			objc_drawer_will_resize_contents__to_size_ (item, Result.item, a_sender__item, a_content_size.item)
		end

	drawer_will_open_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_drawer_will_open_: has_drawer_will_open_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_drawer_will_open_ (item, a_notification__item)
		end

	drawer_did_open_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_drawer_did_open_: has_drawer_did_open_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_drawer_did_open_ (item, a_notification__item)
		end

	drawer_will_close_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_drawer_will_close_: has_drawer_will_close_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_drawer_will_close_ (item, a_notification__item)
		end

	drawer_did_close_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_drawer_did_close_: has_drawer_did_close_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_drawer_did_close_ (item, a_notification__item)
		end

feature -- Status Report

	has_drawer_should_open_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_drawer_should_open_ (item)
		end

	has_drawer_should_close_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_drawer_should_close_ (item)
		end

	has_drawer_will_resize_contents__to_size_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_drawer_will_resize_contents__to_size_ (item)
		end

	has_drawer_will_open_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_drawer_will_open_ (item)
		end

	has_drawer_did_open_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_drawer_did_open_ (item)
		end

	has_drawer_will_close_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_drawer_will_close_ (item)
		end

	has_drawer_did_close_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_drawer_did_close_ (item)
		end

feature -- Status Report Externals

	objc_has_drawer_should_open_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(drawerShouldOpen:)];
			 ]"
		end

	objc_has_drawer_should_close_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(drawerShouldClose:)];
			 ]"
		end

	objc_has_drawer_will_resize_contents__to_size_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(drawerWillResizeContents:toSize:)];
			 ]"
		end

	objc_has_drawer_will_open_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(drawerWillOpen:)];
			 ]"
		end

	objc_has_drawer_did_open_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(drawerDidOpen:)];
			 ]"
		end

	objc_has_drawer_will_close_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(drawerWillClose:)];
			 ]"
		end

	objc_has_drawer_did_close_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(drawerDidClose:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_drawer_should_open_ (an_item: POINTER; a_sender: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSDrawerDelegate>)$an_item drawerShouldOpen:$a_sender];
			 ]"
		end

	objc_drawer_should_close_ (an_item: POINTER; a_sender: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSDrawerDelegate>)$an_item drawerShouldClose:$a_sender];
			 ]"
		end

	objc_drawer_will_resize_contents__to_size_ (an_item: POINTER; result_pointer: POINTER; a_sender: POINTER; a_content_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(id <NSDrawerDelegate>)$an_item drawerWillResizeContents:$a_sender toSize:*((NSSize *)$a_content_size)];
			 ]"
		end

	objc_drawer_will_open_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSDrawerDelegate>)$an_item drawerWillOpen:$a_notification];
			 ]"
		end

	objc_drawer_did_open_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSDrawerDelegate>)$an_item drawerDidOpen:$a_notification];
			 ]"
		end

	objc_drawer_will_close_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSDrawerDelegate>)$an_item drawerWillClose:$a_notification];
			 ]"
		end

	objc_drawer_did_close_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSDrawerDelegate>)$an_item drawerDidClose:$a_notification];
			 ]"
		end

end

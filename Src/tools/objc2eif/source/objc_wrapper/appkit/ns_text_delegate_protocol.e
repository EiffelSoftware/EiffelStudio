note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_TEXT_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	text_should_begin_editing_ (a_text_object: detachable NS_TEXT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_text_should_begin_editing_: has_text_should_begin_editing_
		local
			a_text_object__item: POINTER
		do
			if attached a_text_object as a_text_object_attached then
				a_text_object__item := a_text_object_attached.item
			end
			Result := objc_text_should_begin_editing_ (item, a_text_object__item)
		end

	text_should_end_editing_ (a_text_object: detachable NS_TEXT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_text_should_end_editing_: has_text_should_end_editing_
		local
			a_text_object__item: POINTER
		do
			if attached a_text_object as a_text_object_attached then
				a_text_object__item := a_text_object_attached.item
			end
			Result := objc_text_should_end_editing_ (item, a_text_object__item)
		end

	text_did_begin_editing_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_text_did_begin_editing_: has_text_did_begin_editing_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_text_did_begin_editing_ (item, a_notification__item)
		end

	text_did_end_editing_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_text_did_end_editing_: has_text_did_end_editing_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_text_did_end_editing_ (item, a_notification__item)
		end

	text_did_change_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_text_did_change_: has_text_did_change_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_text_did_change_ (item, a_notification__item)
		end

feature -- Status Report

	has_text_should_begin_editing_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_should_begin_editing_ (item)
		end

	has_text_should_end_editing_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_should_end_editing_ (item)
		end

	has_text_did_begin_editing_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_did_begin_editing_ (item)
		end

	has_text_did_end_editing_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_did_end_editing_ (item)
		end

	has_text_did_change_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_did_change_ (item)
		end

feature -- Status Report Externals

	objc_has_text_should_begin_editing_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textShouldBeginEditing:)];
			 ]"
		end

	objc_has_text_should_end_editing_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textShouldEndEditing:)];
			 ]"
		end

	objc_has_text_did_begin_editing_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textDidBeginEditing:)];
			 ]"
		end

	objc_has_text_did_end_editing_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textDidEndEditing:)];
			 ]"
		end

	objc_has_text_did_change_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textDidChange:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_text_should_begin_editing_ (an_item: POINTER; a_text_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextDelegate>)$an_item textShouldBeginEditing:$a_text_object];
			 ]"
		end

	objc_text_should_end_editing_ (an_item: POINTER; a_text_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextDelegate>)$an_item textShouldEndEditing:$a_text_object];
			 ]"
		end

	objc_text_did_begin_editing_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextDelegate>)$an_item textDidBeginEditing:$a_notification];
			 ]"
		end

	objc_text_did_end_editing_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextDelegate>)$an_item textDidEndEditing:$a_notification];
			 ]"
		end

	objc_text_did_change_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextDelegate>)$an_item textDidChange:$a_notification];
			 ]"
		end

end

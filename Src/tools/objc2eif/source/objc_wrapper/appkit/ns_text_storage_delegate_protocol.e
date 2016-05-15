note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_TEXT_STORAGE_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	text_storage_will_process_editing_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_text_storage_will_process_editing_: has_text_storage_will_process_editing_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_text_storage_will_process_editing_ (item, a_notification__item)
		end

	text_storage_did_process_editing_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_text_storage_did_process_editing_: has_text_storage_did_process_editing_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_text_storage_did_process_editing_ (item, a_notification__item)
		end

feature -- Status Report

	has_text_storage_will_process_editing_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_storage_will_process_editing_ (item)
		end

	has_text_storage_did_process_editing_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_storage_did_process_editing_ (item)
		end

feature -- Status Report Externals

	objc_has_text_storage_will_process_editing_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textStorageWillProcessEditing:)];
			 ]"
		end

	objc_has_text_storage_did_process_editing_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textStorageDidProcessEditing:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_text_storage_will_process_editing_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextStorageDelegate>)$an_item textStorageWillProcessEditing:$a_notification];
			 ]"
		end

	objc_text_storage_did_process_editing_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextStorageDelegate>)$an_item textStorageDidProcessEditing:$a_notification];
			 ]"
		end

end

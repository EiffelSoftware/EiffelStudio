note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PASTEBOARD_OWNER_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSPasteboardOwner

	pasteboard__provide_data_for_type_ (a_ns_object: NS_OBJECT; a_sender: detachable NS_PASTEBOARD; a_type: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
			a_type__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			objc_pasteboard__provide_data_for_type_ (a_ns_object.item, a_sender__item, a_type__item)
		end

	pasteboard_changed_owner_ (a_ns_object: NS_OBJECT; a_sender: detachable NS_PASTEBOARD)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_pasteboard_changed_owner_ (a_ns_object.item, a_sender__item)
		end

feature {NONE} -- NSPasteboardOwner Externals

	objc_pasteboard__provide_data_for_type_ (an_item: POINTER; a_sender: POINTER; a_type: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item pasteboard:$a_sender provideDataForType:$a_type];
			 ]"
		end

	objc_pasteboard_changed_owner_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item pasteboardChangedOwner:$a_sender];
			 ]"
		end

end

note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CONTROL_SUBCLASS_NOTIFICATIONS_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSControlSubclassNotifications

	control_text_did_begin_editing_ (a_ns_object: NS_OBJECT; a_obj: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			objc_control_text_did_begin_editing_ (a_ns_object.item, a_obj__item)
		end

	control_text_did_end_editing_ (a_ns_object: NS_OBJECT; a_obj: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			objc_control_text_did_end_editing_ (a_ns_object.item, a_obj__item)
		end

	control_text_did_change_ (a_ns_object: NS_OBJECT; a_obj: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			objc_control_text_did_change_ (a_ns_object.item, a_obj__item)
		end

feature {NONE} -- NSControlSubclassNotifications Externals

	objc_control_text_did_begin_editing_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item controlTextDidBeginEditing:$a_obj];
			 ]"
		end

	objc_control_text_did_end_editing_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item controlTextDidEndEditing:$a_obj];
			 ]"
		end

	objc_control_text_did_change_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item controlTextDidChange:$a_obj];
			 ]"
		end

end

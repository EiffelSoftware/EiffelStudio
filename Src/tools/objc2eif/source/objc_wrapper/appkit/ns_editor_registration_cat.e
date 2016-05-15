note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_EDITOR_REGISTRATION_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSEditorRegistration

	object_did_begin_editing_ (a_ns_object: NS_OBJECT; a_editor: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_editor__item: POINTER
		do
			if attached a_editor as a_editor_attached then
				a_editor__item := a_editor_attached.item
			end
			objc_object_did_begin_editing_ (a_ns_object.item, a_editor__item)
		end

	object_did_end_editing_ (a_ns_object: NS_OBJECT; a_editor: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_editor__item: POINTER
		do
			if attached a_editor as a_editor_attached then
				a_editor__item := a_editor_attached.item
			end
			objc_object_did_end_editing_ (a_ns_object.item, a_editor__item)
		end

feature {NONE} -- NSEditorRegistration Externals

	objc_object_did_begin_editing_ (an_item: POINTER; a_editor: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item objectDidBeginEditing:$a_editor];
			 ]"
		end

	objc_object_did_end_editing_ (an_item: POINTER; a_editor: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item objectDidEndEditing:$a_editor];
			 ]"
		end

end

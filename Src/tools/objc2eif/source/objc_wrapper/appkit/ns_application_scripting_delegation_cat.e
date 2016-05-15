note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_APPLICATION_SCRIPTING_DELEGATION_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSApplicationScriptingDelegation

	application__delegate_handles_key_ (a_ns_object: NS_OBJECT; a_sender: detachable NS_APPLICATION; a_key: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
			a_key__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_application__delegate_handles_key_ (a_ns_object.item, a_sender__item, a_key__item)
		end

feature {NONE} -- NSApplicationScriptingDelegation Externals

	objc_application__delegate_handles_key_ (an_item: POINTER; a_sender: POINTER; a_key: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item application:$a_sender delegateHandlesKey:$a_key];
			 ]"
		end

end

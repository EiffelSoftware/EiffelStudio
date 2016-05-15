note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT_MANAGER_RESPONDER_METHOD_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSFontManagerResponderMethod

	change_font_ (a_ns_object: NS_OBJECT; a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_change_font_ (a_ns_object.item, a_sender__item)
		end

feature {NONE} -- NSFontManagerResponderMethod Externals

	objc_change_font_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item changeFont:$a_sender];
			 ]"
		end

end

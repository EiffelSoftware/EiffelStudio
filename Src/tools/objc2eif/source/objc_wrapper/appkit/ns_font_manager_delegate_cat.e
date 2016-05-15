note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT_MANAGER_DELEGATE_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSFontManagerDelegate

	font_manager__will_include_font_ (a_ns_object: NS_OBJECT; a_sender: detachable NS_OBJECT; a_font_name: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
			a_font_name__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_font_name as a_font_name_attached then
				a_font_name__item := a_font_name_attached.item
			end
			Result := objc_font_manager__will_include_font_ (a_ns_object.item, a_sender__item, a_font_name__item)
		end

feature {NONE} -- NSFontManagerDelegate Externals

	objc_font_manager__will_include_font_ (an_item: POINTER; a_sender: POINTER; a_font_name: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item fontManager:$a_sender willIncludeFont:$a_font_name];
			 ]"
		end

end

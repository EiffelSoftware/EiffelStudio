note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PASTEBOARD_SUPPORT_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSPasteboardSupport

	write_to_pasteboard_ (a_ns_url: NS_URL; a_paste_board: detachable NS_PASTEBOARD)
			-- Auto generated Objective-C wrapper.
		local
			a_paste_board__item: POINTER
		do
			if attached a_paste_board as a_paste_board_attached then
				a_paste_board__item := a_paste_board_attached.item
			end
			objc_write_to_pasteboard_ (a_ns_url.item, a_paste_board__item)
		end

feature {NONE} -- NSPasteboardSupport Externals

	objc_write_to_pasteboard_ (an_item: POINTER; a_paste_board: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSURL *)$an_item writeToPasteboard:$a_paste_board];
			 ]"
		end

end

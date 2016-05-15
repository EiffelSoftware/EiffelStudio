note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_CHANGE_SPELLING_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

	change_spelling_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_change_spelling_ (item, a_sender__item)
		end

feature {NONE} -- Required Methods Externals

	objc_change_spelling_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSChangeSpelling>)$an_item changeSpelling:$a_sender];
			 ]"
		end

end

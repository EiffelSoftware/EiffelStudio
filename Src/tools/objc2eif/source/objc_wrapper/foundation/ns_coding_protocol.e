note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_CODING_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

	encode_with_coder_ (a_coder: detachable NS_CODER)
			-- Auto generated Objective-C wrapper.
		local
			a_coder__item: POINTER
		do
			if attached a_coder as a_coder_attached then
				a_coder__item := a_coder_attached.item
			end
			objc_encode_with_coder_ (item, a_coder__item)
		end

feature {NONE} -- Required Methods Externals

	objc_encode_with_coder_ (an_item: POINTER; a_coder: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSCoding>)$an_item encodeWithCoder:$a_coder];
			 ]"
		end

end

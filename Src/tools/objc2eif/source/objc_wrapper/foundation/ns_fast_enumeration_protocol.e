note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_FAST_ENUMERATION_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

--	count_by_enumerating_with_state__objects__count_ (a_state: UNSUPPORTED_TYPE; a_stackbuf: UNSUPPORTED_TYPE; a_len: NATURAL_64): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--			a_state__item: POINTER
--			a_stackbuf__item: POINTER
--		do
--			if attached a_state as a_state_attached then
--				a_state__item := a_state_attached.item
--			end
--			if attached a_stackbuf as a_stackbuf_attached then
--				a_stackbuf__item := a_stackbuf_attached.item
--			end
--			Result := objc_count_by_enumerating_with_state__objects__count_ (item, a_state__item, a_stackbuf__item, a_len)
--		end

feature {NONE} -- Required Methods Externals

--	objc_count_by_enumerating_with_state__objects__count_ (an_item: POINTER; a_state: UNSUPPORTED_TYPE; a_stackbuf: UNSUPPORTED_TYPE; a_len: NATURAL_64): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(id <NSFastEnumeration>)$an_item countByEnumeratingWithState: objects: count:$a_len];
--			 ]"
--		end

end

note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_DISCARDABLE_CONTENT_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

	begin_content_access: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_begin_content_access (item)
		end

	end_content_access
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_end_content_access (item)
		end

	discard_content_if_possible
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_discard_content_if_possible (item)
		end

	is_content_discarded: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_content_discarded (item)
		end

feature {NONE} -- Required Methods Externals

	objc_begin_content_access (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id <NSDiscardableContent>)$an_item beginContentAccess];
			 ]"
		end

	objc_end_content_access (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSDiscardableContent>)$an_item endContentAccess];
			 ]"
		end

	objc_discard_content_if_possible (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSDiscardableContent>)$an_item discardContentIfPossible];
			 ]"
		end

	objc_is_content_discarded (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id <NSDiscardableContent>)$an_item isContentDiscarded];
			 ]"
		end

end

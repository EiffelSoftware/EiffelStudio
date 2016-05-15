note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SERVICES_REQUESTS_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSServicesRequests

	write_selection_to_pasteboard__types_ (a_ns_object: NS_OBJECT; a_pboard: detachable NS_PASTEBOARD; a_types: detachable NS_ARRAY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_pboard__item: POINTER
			a_types__item: POINTER
		do
			if attached a_pboard as a_pboard_attached then
				a_pboard__item := a_pboard_attached.item
			end
			if attached a_types as a_types_attached then
				a_types__item := a_types_attached.item
			end
			Result := objc_write_selection_to_pasteboard__types_ (a_ns_object.item, a_pboard__item, a_types__item)
		end

	read_selection_from_pasteboard_ (a_ns_object: NS_OBJECT; a_pboard: detachable NS_PASTEBOARD): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_pboard__item: POINTER
		do
			if attached a_pboard as a_pboard_attached then
				a_pboard__item := a_pboard_attached.item
			end
			Result := objc_read_selection_from_pasteboard_ (a_ns_object.item, a_pboard__item)
		end

feature {NONE} -- NSServicesRequests Externals

	objc_write_selection_to_pasteboard__types_ (an_item: POINTER; a_pboard: POINTER; a_types: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item writeSelectionToPasteboard:$a_pboard types:$a_types];
			 ]"
		end

	objc_read_selection_from_pasteboard_ (an_item: POINTER; a_pboard: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item readSelectionFromPasteboard:$a_pboard];
			 ]"
		end

end

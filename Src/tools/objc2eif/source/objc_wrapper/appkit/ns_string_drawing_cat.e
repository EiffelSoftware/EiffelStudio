note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_STRING_DRAWING_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSStringDrawing

	size_with_attributes_ (a_ns_string: NS_STRING; a_attrs: detachable NS_DICTIONARY): NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
			a_attrs__item: POINTER
		do
			if attached a_attrs as a_attrs_attached then
				a_attrs__item := a_attrs_attached.item
			end
			create Result.make
			objc_size_with_attributes_ (a_ns_string.item, Result.item, a_attrs__item)
		end

	draw_at_point__with_attributes_ (a_ns_string: NS_STRING; a_point: NS_POINT; a_attrs: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_attrs__item: POINTER
		do
			if attached a_attrs as a_attrs_attached then
				a_attrs__item := a_attrs_attached.item
			end
			objc_draw_at_point__with_attributes_ (a_ns_string.item, a_point.item, a_attrs__item)
		end

	draw_in_rect__with_attributes_ (a_ns_string: NS_STRING; a_rect: NS_RECT; a_attrs: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_attrs__item: POINTER
		do
			if attached a_attrs as a_attrs_attached then
				a_attrs__item := a_attrs_attached.item
			end
			objc_draw_in_rect__with_attributes_ (a_ns_string.item, a_rect.item, a_attrs__item)
		end

feature {NONE} -- NSStringDrawing Externals

	objc_size_with_attributes_ (an_item: POINTER; result_pointer: POINTER; a_attrs: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSString *)$an_item sizeWithAttributes:$a_attrs];
			 ]"
		end

	objc_draw_at_point__with_attributes_ (an_item: POINTER; a_point: POINTER; a_attrs: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSString *)$an_item drawAtPoint:*((NSPoint *)$a_point) withAttributes:$a_attrs];
			 ]"
		end

	objc_draw_in_rect__with_attributes_ (an_item: POINTER; a_rect: POINTER; a_attrs: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSString *)$an_item drawInRect:*((NSRect *)$a_rect) withAttributes:$a_attrs];
			 ]"
		end

end

note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_EXTENDED_STRING_DRAWING_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSExtendedStringDrawing

	draw_with_rect__options__attributes_ (a_ns_string: NS_STRING; a_rect: NS_RECT; a_options: INTEGER_64; a_attributes: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_attributes__item: POINTER
		do
			if attached a_attributes as a_attributes_attached then
				a_attributes__item := a_attributes_attached.item
			end
			objc_draw_with_rect__options__attributes_ (a_ns_string.item, a_rect.item, a_options, a_attributes__item)
		end

	bounding_rect_with_size__options__attributes_ (a_ns_string: NS_STRING; a_size: NS_SIZE; a_options: INTEGER_64; a_attributes: detachable NS_DICTIONARY): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_attributes__item: POINTER
		do
			if attached a_attributes as a_attributes_attached then
				a_attributes__item := a_attributes_attached.item
			end
			create Result.make
			objc_bounding_rect_with_size__options__attributes_ (a_ns_string.item, Result.item, a_size.item, a_options, a_attributes__item)
		end

feature {NONE} -- NSExtendedStringDrawing Externals

	objc_draw_with_rect__options__attributes_ (an_item: POINTER; a_rect: POINTER; a_options: INTEGER_64; a_attributes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSString *)$an_item drawWithRect:*((NSRect *)$a_rect) options:$a_options attributes:$a_attributes];
			 ]"
		end

	objc_bounding_rect_with_size__options__attributes_ (an_item: POINTER; result_pointer: POINTER; a_size: POINTER; a_options: INTEGER_64; a_attributes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSString *)$an_item boundingRectWithSize:*((NSSize *)$a_size) options:$a_options attributes:$a_attributes];
			 ]"
		end

end

note
	description: "Summary description for {NS_STRING}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_STRING

inherit
	NS_STRING_BASE
		export
			{NS_OBJECT, NS_OUTLINE_VIEW_DATA_SOURCE} item
		end

create
	make_with_string,
	make_with_cstring,
	make_empty
create {NS_OBJECT, NS_IMAGE_CONSTANTS, NS_STRING_CONSTANTS}
	make_from_pointer,
	share_from_pointer
convert
	make_with_string ({STRING_32, STRING_8, STRING_GENERAL}),
	as_string_8: {STRING_8, READABLE_STRING_8},
	as_string_32: {STRING_32, READABLE_STRING_32}

feature -- NSString Additions: Drawing String Objects

	draw_at_point_with_attributes (a_point: NS_POINT; a_attributes: NS_DICTIONARY)
			-- Draws the receiver with the font and other display characteristics of the given attributes, at the specified point in the currently focused view.
			-- aPoint
			--    The origin for the bounding box for drawing the string. If the focused view is flipped, the origin is the upper-left corner of the drawing bounding box; otherwise, the origin is the lower-left corner.
			-- attributes
			--    A dictionary of text attributes to be applied to the string. These are the same attributes that can be applied to an NSAttributedString object, but in the case of NSString objects, the attributes apply to the entire string, rather than ranges within the string.
			-- The width (height for vertical layout) of the rendering area is unlimited, unlike drawInRect:withAttributes:, which uses a bounding rectangle. As a result, this method renders the text in a single line.
			-- You should only invoke this method when an NSView object has focus.
		do
			c_draw_at_point_with_attributes (item, a_point.item, a_attributes.item)
		end

	draw_in_rect_with_attributes (a_rect: NS_RECT; a_attributes: NS_DICTIONARY)
			-- Draws the receiver with the font and other display characteristics of the given attributes, within the specified rectangle in the currently focused NSView.
		do
			c_draw_in_rect_with_attributes (item, a_rect.item, a_attributes.item)
		end

	size_with_attributes (a_attributes: NS_DICTIONARY): NS_SIZE
			-- Returns the bounding box size the receiver occupies when drawn with the given attributes.
			-- 'a_attributes' is a dictionary of text attributes to be applied to the string. These are the same attributes that can be applied to an
			-- NSAttributedString object, but in the case of NSString objects, the attributes apply to the entire string, rather than ranges within the string.
		require
			attributes_not_void: a_attributes /= void -- May nil be passed?
		do
			create Result.make
			c_size_with_attributes (item, a_attributes.item, Result.item)
		ensure
			result_not_void: Result /= void
		end


feature -- NSString Additions: Drawing String Objects

	frozen c_draw_at_point_with_attributes (a_ns_string: POINTER; a_point: POINTER; a_attributes: POINTER)
			--- (void)drawAtPoint:(NSPoint)aPoint withAttributes:(NSDictionary *)attributes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSString*)$a_ns_string drawAtPoint: *(NSPoint*)$a_point withAttributes: $a_attributes];"
		end

	frozen c_draw_in_rect_with_attributes (a_ns_string: POINTER; a_rect: POINTER; a_attributes: POINTER)
			--- (void)drawAInRect:(NSRect)aPoint withAttributes:(NSDictionary *)attributes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSString*)$a_ns_string drawInRect: *(NSRect*)$a_rect withAttributes: $a_attributes];"
		end

	frozen c_size_with_attributes (a_ns_string: POINTER; a_attributes: POINTER; res: POINTER)
			-- - (NSSize)sizeWithAttributes:(NSDictionary *)attributes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				{
					NSSize size = [(NSString*)$a_ns_string sizeWithAttributes: $a_attributes];
					memcpy($res, &size, sizeof(NSSize));
				}
			]"
		end

feature -- NSString Additions: Getting the Bounding Rect of Rendered Strings
end

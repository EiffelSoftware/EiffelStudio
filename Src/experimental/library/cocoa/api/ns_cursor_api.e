note
	description: "Summary description for {NS_CURSOR_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CURSOR_API

feature -- Initializing a New Cursor

	frozen alloc: POINTER
			-- + (id)alloc
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSCursor alloc];"
		end

	frozen init_with_image_hot_spot (a_cursor: POINTER; a_new_image: POINTER; a_point: POINTER)
			-- - (id)initWithImage: (NSImage *) newImage hotSpot: aPoint
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCursor*)$a_cursor initWithImage: $a_new_image hotSpot: *(NSPoint*)$a_point];"
		end

feature -- Setting Cursor Attributes

	frozen image (a_cursor: POINTER): POINTER
			-- - (NSImage *)image
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSCursor*)$a_cursor image];"
		end

feature -- Retrieving Cursor Instances

	frozen current_cursor : POINTER
			-- + (NSCursor *)currentCursor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSCursor currentCursor];"
		end

	frozen arrow_cursor : POINTER
			-- + (NSCursor *)arrowCursor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSCursor arrowCursor];"
		end

	frozen ibeam_cursor : POINTER
			-- + (NSCursor *)IBeamCursor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSCursor IBeamCursor];"
		end

	frozen pointing_hand_cursor : POINTER
			-- + (NSCursor *)pointingHandCursor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSCursor pointingHandCursor];"
		end

	frozen closed_hand_cursor : POINTER
			-- + (NSCursor *)closedHandCursor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSCursor closedHandCursor];"
		end

	frozen open_hand_cursor : POINTER
			-- + (NSCursor *)openHandCursor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSCursor openHandCursor];"
		end

	frozen resize_left_cursor : POINTER
			-- + (NSCursor *)resizeLeftCursor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSCursor resizeLeftCursor];"
		end

	frozen resize_right_cursor : POINTER
			-- + (NSCursor *)resizeRightCursor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSCursor resizeRightCursor];"
		end

	frozen resize_left_right_cursor : POINTER
			-- + (NSCursor *)resizeLeftRightCursor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSCursor resizeLeftRightCursor];"
		end

	frozen resize_up_cursor : POINTER
			-- + (NSCursor *)resizeUpCursor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSCursor resizeUpCursor];"
		end

	frozen resize_down_cursor : POINTER
			-- + (NSCursor *)resizeDownCursor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSCursor resizeDownCursor];"
		end

	frozen resize_up_down_cursor : POINTER
			-- + (NSCursor *)resizeUpDownCursor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSCursor resizeUpDownCursor];"
		end

	frozen crosshair_cursor : POINTER
			-- + (NSCursor *)crosshairCursor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSCursor crosshairCursor];"
		end

	frozen disappearing_item_cursor : POINTER
			-- + (NSCursor *)disappearingItemCursor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSCursor disappearingItemCursor];"
		end

end

note
	description: "Wrapper for NSRect. This usually has call-by-value sementics in Objective-C. The wrapper takes care of that."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RECT

inherit
	MEMORY_STRUCTURE
		rename
			make as allocate
		end

create
	make,
	make_rect

feature {NONE} -- Creation

	make
		do
			allocate
			create origin.make_by_pointer (origin_address (item))
			create size.make_by_pointer (size_address (item))
		end

	make_rect (a_x, a_y, a_width, a_height: INTEGER)
		do
			allocate
			rect_make_rect (item, a_x, a_y, a_width, a_height)
			create origin.make_by_pointer (origin_address (item))
			create size.make_by_pointer (size_address (item))
		end

	zero_rect
		do
			allocate
			rect_zero_rect (item)
			create origin.make_by_pointer (origin_address (item))
			create size.make_by_pointer (size_address (item))
		end

feature -- Access

	origin: NS_POINT

	size: NS_SIZE

feature {NONE} -- Implementation

	structure_size: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return sizeof(NSRect);"
		end

 	origin_address (p: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return &((*(NSRect *)$p).origin);"
		end

 	size_address (p: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return &((*(NSRect *)$p).size);"
		end

	frozen rect_make_rect (res: POINTER; a_x, a_y, a_w, a_h: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRect rect = NSMakeRect($a_x, $a_y, $a_w, $a_h); memcpy($res, &rect, sizeof(NSRect));"
		end

	frozen rect_zero_rect (res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRect rect = NSZeroRect; memcpy($res, &rect, sizeof(NSRect));"
		end
end

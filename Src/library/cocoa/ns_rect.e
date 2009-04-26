note
	description: "Summary description for {NS_RECT}."
	author: ""
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

feature -- Creation

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

end

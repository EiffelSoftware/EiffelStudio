note
	description: "Wrapper for NSSize. This usually has call-by-value sementics in Objective-C. The wrapper takes care of that."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SIZE

inherit
	MEMORY_STRUCTURE

	DEBUG_OUTPUT
	
	NS_OBJECT_BASIC_TYPE

create
	make,
	make_size
create {NS_RECT, NS_OBJECT}
	make_by_pointer

feature {NONE} -- Creation

	make_size (a_width, a_height: like cg_float)
		do
			make
			set_width (a_width)
			set_height (a_height)
		end

feature -- Measurement

	width: like cg_float
		do
			Result := internal_width (item)
		end

	height: like cg_float
		do
			Result := internal_height (item)
		end

	set_width (a_width: like cg_float)
		do
			internal_set_width (item, a_width)
		end

	set_height (a_height: like cg_float)
		do
			internal_set_height (item, a_height)
		end

feature -- Status report

	debug_output: STRING
		do
			Result := "(Width: " + width.out +
				", Height: " + height.out + ")"
		end

feature {NONE} -- Implementation

    internal_width (p: POINTER): like cg_float
            -- Access field width of struct pointed by `p'.
        external
            "C [struct <Cocoa/Cocoa.h>] (NSSize): EIF_REAL"
        alias
            "width"
        end

    internal_height (p: POINTER): like cg_float
            -- Access field height of struct pointed by `p'.
        external
            "C [struct <Cocoa/Cocoa.h>] (NSSize): EIF_REAL"
        alias
            "height"
        end

	internal_set_width (p: POINTER; v: like cg_float)
            -- Set field x of struct pointed by `p'.
        external
            "C [struct <Cocoa/Cocoa.h>] (NSSize, CGFloat)"
        alias
            "width"
        end

    internal_set_height (p: POINTER; v: like cg_float)
            -- Set field y of struct pointed by `p' with `v'.
        external
            "C [struct <Cocoa/Cocoa.h>] (NSSize, CGFloat)"
        alias
            "height"
        end

	structure_size: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return sizeof(NSSize);"
		end
end

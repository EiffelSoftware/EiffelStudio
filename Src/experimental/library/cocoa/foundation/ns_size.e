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

create
	make,
	make_size
create {NS_RECT}
	make_by_pointer

feature {NONE} -- Creation

	make_size (a_width, a_height: INTEGER)
		do
			make
			set_width (a_width)
			set_height (a_height)
		end

feature -- Measurement

	width: INTEGER
		do
			Result := internal_width (item)
		end

	height: INTEGER
		do
			Result := internal_height (item)
		end

	set_width (a_width: INTEGER)
		do
			internal_set_width (item, a_width)
		end

	set_height (a_height: INTEGER)
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

    internal_width (p: POINTER): INTEGER
            -- Access field width of struct pointed by `p'.
        external
            "C [struct <Cocoa/Cocoa.h>] (NSSize): EIF_INTEGER"
        alias
            "width"
        end

    internal_height (p: POINTER): INTEGER
            -- Access field height of struct pointed by `p'.
        external
            "C [struct <Cocoa/Cocoa.h>] (NSSize): EIF_INTEGER"
        alias
            "height"
        end

	internal_set_width (p: POINTER; v: INTEGER)
            -- Set field x of struct pointed by `p'.
        external
            "C [struct <Cocoa/Cocoa.h>] (NSSize, int)"
        alias
            "width"
        end

    internal_set_height (p: POINTER; v: INTEGER)
            -- Set field y of struct pointed by `p' with `v'.
        external
            "C [struct <Cocoa/Cocoa.h>] (NSSize, int)"
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

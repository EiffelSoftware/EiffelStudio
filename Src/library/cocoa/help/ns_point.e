note
	description: "Summary description for {NS_POINT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_POINT

inherit
	MEMORY_STRUCTURE

create
	make,
	make_point,
	make_by_pointer

feature -- Creation

	make_point (a_x, a_y: INTEGER)
		do
			make
			set_x (a_x)
			set_y (a_y)
		end

feature -- Measurement

	x: INTEGER
		do
			Result := internal_x (item)
		end

	y: INTEGER
		do
			Result := internal_y (item)
		end

	set_x (a_x: INTEGER)
		do
			internal_set_x (item, a_x)
		end

	set_y (a_y: INTEGER)
		do
			internal_set_y (item, a_y)
		end

feature {NONE} -- Implementation

    internal_x (p: POINTER): INTEGER
            -- Access field x of struct pointed by `p'.
        external
            "C [struct <Cocoa/Cocoa.h>] (NSPoint): EIF_INTEGER"
        alias
            "x"
        end

    internal_y (p: POINTER): INTEGER
            -- Access field y of struct pointed by `p'.
        external
            "C [struct <Cocoa/Cocoa.h>] (NSPoint): EIF_INTEGER"
        alias
            "y"
        end

	internal_set_x (p: POINTER; v: INTEGER)
            -- Set field x of struct pointed by `p'.
        external
            "C [struct <Cocoa/Cocoa.h>] (NSPoint, int)"
        alias
            "x"
        end

    internal_set_y (p: POINTER; v: INTEGER)
            -- Set field y of struct pointed by `p' with `v'.
        external
            "C [struct <Cocoa/Cocoa.h>] (NSPoint, int)"
        alias
            "y"
        end

    structure_size: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return sizeof(NSPoint);"
		end

end

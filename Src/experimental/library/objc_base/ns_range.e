note
	description: "Wrapper for NSRange. This usually has call-by-value sementics in Objective-C. The wrapper takes care of that."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RANGE

inherit
	MEMORY_STRUCTURE

create
	make,
	make_range

feature {NONE} -- Creation

	make_range (a_length, a_location: INTEGER)
		do
			make
			set_length (a_length)
			set_location (a_location)
		end

feature -- Measurement

	location: INTEGER assign set_length
		do
			Result := internal_location (item)
		end

	length: INTEGER assign set_location
		do
			Result := internal_length (item)
		end

	set_location (a_location: INTEGER)
		do
			internal_set_location (item, a_location)
		end

	set_length (a_length: INTEGER)
		do
			internal_set_length (item, a_length)
		end

feature {NONE} -- Implementation

    internal_location (p: POINTER): INTEGER
            -- Access field length of struct pointed by `p'.
        external
            "C [struct <Cocoa/Cocoa.h>] (NSRange): EIF_INTEGER"
        alias
            "location"
        end

    internal_length (p: POINTER): INTEGER
            -- Access field location of struct pointed by `p'.
        external
            "C [struct <Cocoa/Cocoa.h>] (NSRange): EIF_INTEGER"
        alias
            "length"
        end

	internal_set_length (p: POINTER; v: INTEGER)
            -- Set field length of struct pointed by `p'.
        external
            "C [struct <Cocoa/Cocoa.h>] (NSRange, int)"
        alias
            "length"
        end

    internal_set_location (p: POINTER; v: INTEGER)
            -- Set field location of struct pointed by `p' with `v'.
        external
            "C [struct <Cocoa/Cocoa.h>] (NSRange, int)"
        alias
            "location"
        end

    structure_size: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return sizeof(NSPoint);"
		end

end

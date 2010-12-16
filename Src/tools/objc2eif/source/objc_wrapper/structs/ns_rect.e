note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RECT

inherit
	MEMORY_STRUCTURE
		redefine
			out,
			is_equal
		end

	DEBUG_OUTPUT
		redefine
			out,
			is_equal
		end


create
	make,
	make_by_pointer,
	make_with_coordinates

feature {NONE} -- Initialization

	make_with_coordinates (a_x: REAL_64; a_y: REAL_64; a_width: REAL_64; a_height: REAL_64)
			-- Initialize `Current' with the passed coordinates.
		local
			p: NS_POINT
			s: NS_SIZE
		do
			make
			create p.make
			p.x := a_x
			p.y := a_y
			create s.make
			s.width := a_width
			s.height := a_height
			set_origin (p)
			set_size (s)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := item.memory_compare (other.item, structure_size)
		end

feature -- Settings

	set_origin (a_origin: CG_POINT)
			-- Set `origin' with 'a_origin'.
		do
			c_set_origin (item, a_origin.item)
		ensure
			origin_set: origin ~ a_origin
		end

	set_size (a_size: CG_SIZE)
			-- Set `size' with 'a_size'.
		do
			c_set_size (item, a_size.item)
		ensure
			size_set: size ~ a_size
		end

feature -- Access

	origin: CG_POINT assign set_origin
			-- Return the struct field.
		do
			create Result.make
			c_copy_origin (item, Result.item)
		end

	size: CG_SIZE assign set_size
			-- Return the struct field.
		do
			create Result.make
			c_copy_size (item, Result.item)
		end

feature {NONE} -- Implementation

	structure_size: INTEGER
			-- Size to allocate (in bytes).
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return sizeof(NSRect);"
		end

	c_copy_origin (a_struct_pointer: POINTER; result_pointer: POINTER)
			-- Return the address of a copy of the field.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				size_t size = sizeof(((NSRect *) $a_struct_pointer)->origin);
				memcpy($result_pointer, &(((NSRect *) $a_struct_pointer)->origin), size);
			]"
		end

	c_copy_size (a_struct_pointer: POINTER; result_pointer: POINTER)
			-- Return the address of a copy of the field.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				size_t size = sizeof(((NSRect *) $a_struct_pointer)->size);
				memcpy($result_pointer, &(((NSRect *) $a_struct_pointer)->size), size);
			]"
		end

	c_set_origin (a_struct_pointer: POINTER; a_c_origin: POINTER)
			-- Set the corresponding C struct field with `a_c_origin'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((NSRect *) $a_struct_pointer)->origin = *((CGPoint *) $a_c_origin);"
		end

	c_set_size (a_struct_pointer: POINTER; a_c_size: POINTER)
			-- Set the corresponding C struct field with `a_c_size'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((NSRect *) $a_struct_pointer)->size = *((CGSize *) $a_c_size);"
		end

feature -- Debug Output

	out, debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{" +
					"origin: " + origin.out + ", " +
					"size: " + size.out +
				"}"
		end

end

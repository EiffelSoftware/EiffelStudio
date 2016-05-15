note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_POINT

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
	make_by_pointer

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := item.memory_compare (other.item, structure_size)
		end

feature -- Settings

	set_x (a_x: REAL_64)
			-- Set `x' with 'a_x'.
		do
			c_set_x (item, a_x)
		ensure
			x_set: x ~ a_x
		end

	set_y (a_y: REAL_64)
			-- Set `y' with 'a_y'.
		do
			c_set_y (item, a_y)
		ensure
			y_set: y ~ a_y
		end

feature -- Access

	x: REAL_64 assign set_x
			-- Return the struct field.
		do
			Result := c_x (item)
		end

	y: REAL_64 assign set_y
			-- Return the struct field.
		do
			Result := c_y (item)
		end

feature {NONE} -- Implementation

	structure_size: INTEGER
			-- Size to allocate (in bytes).
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return sizeof(NSPoint);"
		end

	c_x (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((NSPoint *) $a_struct_pointer)->x);"
		end

	c_y (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((NSPoint *) $a_struct_pointer)->y);"
		end

	c_set_x (a_struct_pointer: POINTER; a_c_x: REAL_64)
			-- Set the corresponding C struct field with `a_c_x'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((NSPoint *) $a_struct_pointer)->x = $a_c_x;"
		end

	c_set_y (a_struct_pointer: POINTER; a_c_y: REAL_64)
			-- Set the corresponding C struct field with `a_c_y'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((NSPoint *) $a_struct_pointer)->y = $a_c_y;"
		end

feature -- Debug Output

	out, debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{" +
					"x: " + x.out + ", " +
					"y: " + y.out +
				"}"
		end

end

note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SIZE

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

	set_width (a_width: REAL_64)
			-- Set `width' with 'a_width'.
		do
			c_set_width (item, a_width)
		ensure
			width_set: width ~ a_width
		end

	set_height (a_height: REAL_64)
			-- Set `height' with 'a_height'.
		do
			c_set_height (item, a_height)
		ensure
			height_set: height ~ a_height
		end

feature -- Access

	width: REAL_64 assign set_width
			-- Return the struct field.
		do
			Result := c_width (item)
		end

	height: REAL_64 assign set_height
			-- Return the struct field.
		do
			Result := c_height (item)
		end

feature {NONE} -- Implementation

	structure_size: INTEGER
			-- Size to allocate (in bytes).
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return sizeof(NSSize);"
		end

	c_width (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((NSSize *) $a_struct_pointer)->width);"
		end

	c_height (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((NSSize *) $a_struct_pointer)->height);"
		end

	c_set_width (a_struct_pointer: POINTER; a_c_width: REAL_64)
			-- Set the corresponding C struct field with `a_c_width'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((NSSize *) $a_struct_pointer)->width = $a_c_width;"
		end

	c_set_height (a_struct_pointer: POINTER; a_c_height: REAL_64)
			-- Set the corresponding C struct field with `a_c_height'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((NSSize *) $a_struct_pointer)->height = $a_c_height;"
		end

feature -- Debug Output

	out, debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{" +
					"width: " + width.out + ", " +
					"height: " + height.out +
				"}"
		end

end

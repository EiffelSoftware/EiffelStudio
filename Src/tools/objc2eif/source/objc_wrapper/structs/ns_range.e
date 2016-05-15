note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RANGE

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

	set_location (a_location: NATURAL_64)
			-- Set `location' with 'a_location'.
		do
			c_set_location (item, a_location)
		ensure
			location_set: location ~ a_location
		end

	set_length (a_length: NATURAL_64)
			-- Set `length' with 'a_length'.
		do
			c_set_length (item, a_length)
		ensure
			length_set: length ~ a_length
		end

feature -- Access

	location: NATURAL_64 assign set_location
			-- Return the struct field.
		do
			Result := c_location (item)
		end

	length: NATURAL_64 assign set_length
			-- Return the struct field.
		do
			Result := c_length (item)
		end

feature {NONE} -- Implementation

	structure_size: INTEGER
			-- Size to allocate (in bytes).
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return sizeof(NSRange);"
		end

	c_location (a_struct_pointer: POINTER): NATURAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((NSRange *) $a_struct_pointer)->location);"
		end

	c_length (a_struct_pointer: POINTER): NATURAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((NSRange *) $a_struct_pointer)->length);"
		end

	c_set_location (a_struct_pointer: POINTER; a_c_location: NATURAL_64)
			-- Set the corresponding C struct field with `a_c_location'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((NSRange *) $a_struct_pointer)->location = $a_c_location;"
		end

	c_set_length (a_struct_pointer: POINTER; a_c_length: NATURAL_64)
			-- Set the corresponding C struct field with `a_c_length'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((NSRange *) $a_struct_pointer)->length = $a_c_length;"
		end

feature -- Debug Output

	out, debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{" +
					"location: " + location.out + ", " +
					"length: " + length.out +
				"}"
		end

end

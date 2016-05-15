note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_AFFINE_TRANSFORM_STRUCT

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

	set_m11 (a_m11: REAL_64)
			-- Set `m11' with 'a_m11'.
		do
			c_set_m11 (item, a_m11)
		ensure
			m11_set: m11 ~ a_m11
		end

	set_m12 (a_m12: REAL_64)
			-- Set `m12' with 'a_m12'.
		do
			c_set_m12 (item, a_m12)
		ensure
			m12_set: m12 ~ a_m12
		end

	set_m21 (a_m21: REAL_64)
			-- Set `m21' with 'a_m21'.
		do
			c_set_m21 (item, a_m21)
		ensure
			m21_set: m21 ~ a_m21
		end

	set_m22 (a_m22: REAL_64)
			-- Set `m22' with 'a_m22'.
		do
			c_set_m22 (item, a_m22)
		ensure
			m22_set: m22 ~ a_m22
		end

	set_t_x (a_t_x: REAL_64)
			-- Set `t_x' with 'a_t_x'.
		do
			c_set_t_x (item, a_t_x)
		ensure
			t_x_set: t_x ~ a_t_x
		end

	set_t_y (a_t_y: REAL_64)
			-- Set `t_y' with 'a_t_y'.
		do
			c_set_t_y (item, a_t_y)
		ensure
			t_y_set: t_y ~ a_t_y
		end

feature -- Access

	m11: REAL_64 assign set_m11
			-- Return the struct field.
		do
			Result := c_m11 (item)
		end

	m12: REAL_64 assign set_m12
			-- Return the struct field.
		do
			Result := c_m12 (item)
		end

	m21: REAL_64 assign set_m21
			-- Return the struct field.
		do
			Result := c_m21 (item)
		end

	m22: REAL_64 assign set_m22
			-- Return the struct field.
		do
			Result := c_m22 (item)
		end

	t_x: REAL_64 assign set_t_x
			-- Return the struct field.
		do
			Result := c_t_x (item)
		end

	t_y: REAL_64 assign set_t_y
			-- Return the struct field.
		do
			Result := c_t_y (item)
		end

feature {NONE} -- Implementation

	structure_size: INTEGER
			-- Size to allocate (in bytes).
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return sizeof(NSAffineTransformStruct);"
		end

	c_m11 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((NSAffineTransformStruct *) $a_struct_pointer)->m11);"
		end

	c_m12 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((NSAffineTransformStruct *) $a_struct_pointer)->m12);"
		end

	c_m21 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((NSAffineTransformStruct *) $a_struct_pointer)->m21);"
		end

	c_m22 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((NSAffineTransformStruct *) $a_struct_pointer)->m22);"
		end

	c_t_x (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((NSAffineTransformStruct *) $a_struct_pointer)->tX);"
		end

	c_t_y (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((NSAffineTransformStruct *) $a_struct_pointer)->tY);"
		end

	c_set_m11 (a_struct_pointer: POINTER; a_c_m11: REAL_64)
			-- Set the corresponding C struct field with `a_c_m11'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((NSAffineTransformStruct *) $a_struct_pointer)->m11 = $a_c_m11;"
		end

	c_set_m12 (a_struct_pointer: POINTER; a_c_m12: REAL_64)
			-- Set the corresponding C struct field with `a_c_m12'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((NSAffineTransformStruct *) $a_struct_pointer)->m12 = $a_c_m12;"
		end

	c_set_m21 (a_struct_pointer: POINTER; a_c_m21: REAL_64)
			-- Set the corresponding C struct field with `a_c_m21'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((NSAffineTransformStruct *) $a_struct_pointer)->m21 = $a_c_m21;"
		end

	c_set_m22 (a_struct_pointer: POINTER; a_c_m22: REAL_64)
			-- Set the corresponding C struct field with `a_c_m22'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((NSAffineTransformStruct *) $a_struct_pointer)->m22 = $a_c_m22;"
		end

	c_set_t_x (a_struct_pointer: POINTER; a_c_t_x: REAL_64)
			-- Set the corresponding C struct field with `a_c_t_x'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((NSAffineTransformStruct *) $a_struct_pointer)->tX = $a_c_t_x;"
		end

	c_set_t_y (a_struct_pointer: POINTER; a_c_t_y: REAL_64)
			-- Set the corresponding C struct field with `a_c_t_y'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((NSAffineTransformStruct *) $a_struct_pointer)->tY = $a_c_t_y;"
		end

feature -- Debug Output

	out, debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{" +
					"m11: " + m11.out + ", " +
					"m12: " + m12.out + ", " +
					"m21: " + m21.out + ", " +
					"m22: " + m22.out + ", " +
					"t_x: " + t_x.out + ", " +
					"t_y: " + t_y.out +
				"}"
		end

end

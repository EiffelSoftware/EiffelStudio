note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_TRANSFORM3D

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

	set_m13 (a_m13: REAL_64)
			-- Set `m13' with 'a_m13'.
		do
			c_set_m13 (item, a_m13)
		ensure
			m13_set: m13 ~ a_m13
		end

	set_m14 (a_m14: REAL_64)
			-- Set `m14' with 'a_m14'.
		do
			c_set_m14 (item, a_m14)
		ensure
			m14_set: m14 ~ a_m14
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

	set_m23 (a_m23: REAL_64)
			-- Set `m23' with 'a_m23'.
		do
			c_set_m23 (item, a_m23)
		ensure
			m23_set: m23 ~ a_m23
		end

	set_m24 (a_m24: REAL_64)
			-- Set `m24' with 'a_m24'.
		do
			c_set_m24 (item, a_m24)
		ensure
			m24_set: m24 ~ a_m24
		end

	set_m31 (a_m31: REAL_64)
			-- Set `m31' with 'a_m31'.
		do
			c_set_m31 (item, a_m31)
		ensure
			m31_set: m31 ~ a_m31
		end

	set_m32 (a_m32: REAL_64)
			-- Set `m32' with 'a_m32'.
		do
			c_set_m32 (item, a_m32)
		ensure
			m32_set: m32 ~ a_m32
		end

	set_m33 (a_m33: REAL_64)
			-- Set `m33' with 'a_m33'.
		do
			c_set_m33 (item, a_m33)
		ensure
			m33_set: m33 ~ a_m33
		end

	set_m34 (a_m34: REAL_64)
			-- Set `m34' with 'a_m34'.
		do
			c_set_m34 (item, a_m34)
		ensure
			m34_set: m34 ~ a_m34
		end

	set_m41 (a_m41: REAL_64)
			-- Set `m41' with 'a_m41'.
		do
			c_set_m41 (item, a_m41)
		ensure
			m41_set: m41 ~ a_m41
		end

	set_m42 (a_m42: REAL_64)
			-- Set `m42' with 'a_m42'.
		do
			c_set_m42 (item, a_m42)
		ensure
			m42_set: m42 ~ a_m42
		end

	set_m43 (a_m43: REAL_64)
			-- Set `m43' with 'a_m43'.
		do
			c_set_m43 (item, a_m43)
		ensure
			m43_set: m43 ~ a_m43
		end

	set_m44 (a_m44: REAL_64)
			-- Set `m44' with 'a_m44'.
		do
			c_set_m44 (item, a_m44)
		ensure
			m44_set: m44 ~ a_m44
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

	m13: REAL_64 assign set_m13
			-- Return the struct field.
		do
			Result := c_m13 (item)
		end

	m14: REAL_64 assign set_m14
			-- Return the struct field.
		do
			Result := c_m14 (item)
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

	m23: REAL_64 assign set_m23
			-- Return the struct field.
		do
			Result := c_m23 (item)
		end

	m24: REAL_64 assign set_m24
			-- Return the struct field.
		do
			Result := c_m24 (item)
		end

	m31: REAL_64 assign set_m31
			-- Return the struct field.
		do
			Result := c_m31 (item)
		end

	m32: REAL_64 assign set_m32
			-- Return the struct field.
		do
			Result := c_m32 (item)
		end

	m33: REAL_64 assign set_m33
			-- Return the struct field.
		do
			Result := c_m33 (item)
		end

	m34: REAL_64 assign set_m34
			-- Return the struct field.
		do
			Result := c_m34 (item)
		end

	m41: REAL_64 assign set_m41
			-- Return the struct field.
		do
			Result := c_m41 (item)
		end

	m42: REAL_64 assign set_m42
			-- Return the struct field.
		do
			Result := c_m42 (item)
		end

	m43: REAL_64 assign set_m43
			-- Return the struct field.
		do
			Result := c_m43 (item)
		end

	m44: REAL_64 assign set_m44
			-- Return the struct field.
		do
			Result := c_m44 (item)
		end

feature {NONE} -- Implementation

	structure_size: INTEGER
			-- Size to allocate (in bytes).
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return sizeof(CATransform3D);"
		end

	c_m11 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CATransform3D *) $a_struct_pointer)->m11);"
		end

	c_m12 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CATransform3D *) $a_struct_pointer)->m12);"
		end

	c_m13 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CATransform3D *) $a_struct_pointer)->m13);"
		end

	c_m14 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CATransform3D *) $a_struct_pointer)->m14);"
		end

	c_m21 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CATransform3D *) $a_struct_pointer)->m21);"
		end

	c_m22 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CATransform3D *) $a_struct_pointer)->m22);"
		end

	c_m23 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CATransform3D *) $a_struct_pointer)->m23);"
		end

	c_m24 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CATransform3D *) $a_struct_pointer)->m24);"
		end

	c_m31 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CATransform3D *) $a_struct_pointer)->m31);"
		end

	c_m32 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CATransform3D *) $a_struct_pointer)->m32);"
		end

	c_m33 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CATransform3D *) $a_struct_pointer)->m33);"
		end

	c_m34 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CATransform3D *) $a_struct_pointer)->m34);"
		end

	c_m41 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CATransform3D *) $a_struct_pointer)->m41);"
		end

	c_m42 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CATransform3D *) $a_struct_pointer)->m42);"
		end

	c_m43 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CATransform3D *) $a_struct_pointer)->m43);"
		end

	c_m44 (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CATransform3D *) $a_struct_pointer)->m44);"
		end

	c_set_m11 (a_struct_pointer: POINTER; a_c_m11: REAL_64)
			-- Set the corresponding C struct field with `a_c_m11'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CATransform3D *) $a_struct_pointer)->m11 = $a_c_m11;"
		end

	c_set_m12 (a_struct_pointer: POINTER; a_c_m12: REAL_64)
			-- Set the corresponding C struct field with `a_c_m12'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CATransform3D *) $a_struct_pointer)->m12 = $a_c_m12;"
		end

	c_set_m13 (a_struct_pointer: POINTER; a_c_m13: REAL_64)
			-- Set the corresponding C struct field with `a_c_m13'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CATransform3D *) $a_struct_pointer)->m13 = $a_c_m13;"
		end

	c_set_m14 (a_struct_pointer: POINTER; a_c_m14: REAL_64)
			-- Set the corresponding C struct field with `a_c_m14'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CATransform3D *) $a_struct_pointer)->m14 = $a_c_m14;"
		end

	c_set_m21 (a_struct_pointer: POINTER; a_c_m21: REAL_64)
			-- Set the corresponding C struct field with `a_c_m21'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CATransform3D *) $a_struct_pointer)->m21 = $a_c_m21;"
		end

	c_set_m22 (a_struct_pointer: POINTER; a_c_m22: REAL_64)
			-- Set the corresponding C struct field with `a_c_m22'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CATransform3D *) $a_struct_pointer)->m22 = $a_c_m22;"
		end

	c_set_m23 (a_struct_pointer: POINTER; a_c_m23: REAL_64)
			-- Set the corresponding C struct field with `a_c_m23'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CATransform3D *) $a_struct_pointer)->m23 = $a_c_m23;"
		end

	c_set_m24 (a_struct_pointer: POINTER; a_c_m24: REAL_64)
			-- Set the corresponding C struct field with `a_c_m24'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CATransform3D *) $a_struct_pointer)->m24 = $a_c_m24;"
		end

	c_set_m31 (a_struct_pointer: POINTER; a_c_m31: REAL_64)
			-- Set the corresponding C struct field with `a_c_m31'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CATransform3D *) $a_struct_pointer)->m31 = $a_c_m31;"
		end

	c_set_m32 (a_struct_pointer: POINTER; a_c_m32: REAL_64)
			-- Set the corresponding C struct field with `a_c_m32'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CATransform3D *) $a_struct_pointer)->m32 = $a_c_m32;"
		end

	c_set_m33 (a_struct_pointer: POINTER; a_c_m33: REAL_64)
			-- Set the corresponding C struct field with `a_c_m33'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CATransform3D *) $a_struct_pointer)->m33 = $a_c_m33;"
		end

	c_set_m34 (a_struct_pointer: POINTER; a_c_m34: REAL_64)
			-- Set the corresponding C struct field with `a_c_m34'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CATransform3D *) $a_struct_pointer)->m34 = $a_c_m34;"
		end

	c_set_m41 (a_struct_pointer: POINTER; a_c_m41: REAL_64)
			-- Set the corresponding C struct field with `a_c_m41'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CATransform3D *) $a_struct_pointer)->m41 = $a_c_m41;"
		end

	c_set_m42 (a_struct_pointer: POINTER; a_c_m42: REAL_64)
			-- Set the corresponding C struct field with `a_c_m42'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CATransform3D *) $a_struct_pointer)->m42 = $a_c_m42;"
		end

	c_set_m43 (a_struct_pointer: POINTER; a_c_m43: REAL_64)
			-- Set the corresponding C struct field with `a_c_m43'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CATransform3D *) $a_struct_pointer)->m43 = $a_c_m43;"
		end

	c_set_m44 (a_struct_pointer: POINTER; a_c_m44: REAL_64)
			-- Set the corresponding C struct field with `a_c_m44'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CATransform3D *) $a_struct_pointer)->m44 = $a_c_m44;"
		end

feature -- Debug Output

	out, debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{" +
					"m11: " + m11.out + ", " +
					"m12: " + m12.out + ", " +
					"m13: " + m13.out + ", " +
					"m14: " + m14.out + ", " +
					"m21: " + m21.out + ", " +
					"m22: " + m22.out + ", " +
					"m23: " + m23.out + ", " +
					"m24: " + m24.out + ", " +
					"m31: " + m31.out + ", " +
					"m32: " + m32.out + ", " +
					"m33: " + m33.out + ", " +
					"m34: " + m34.out + ", " +
					"m41: " + m41.out + ", " +
					"m42: " + m42.out + ", " +
					"m43: " + m43.out + ", " +
					"m44: " + m44.out +
				"}"
		end

end

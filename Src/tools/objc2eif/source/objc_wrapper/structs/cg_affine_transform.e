note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	CG_AFFINE_TRANSFORM

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

	set_a (a_a: REAL_64)
			-- Set `a' with 'a_a'.
		do
			c_set_a (item, a_a)
		ensure
			a_set: a ~ a_a
		end

	set_b (a_b: REAL_64)
			-- Set `b' with 'a_b'.
		do
			c_set_b (item, a_b)
		ensure
			b_set: b ~ a_b
		end

	set_c (a_c: REAL_64)
			-- Set `c' with 'a_c'.
		do
			c_set_c (item, a_c)
		ensure
			c_set: c ~ a_c
		end

	set_d (a_d: REAL_64)
			-- Set `d' with 'a_d'.
		do
			c_set_d (item, a_d)
		ensure
			d_set: d ~ a_d
		end

	set_tx (a_tx: REAL_64)
			-- Set `tx' with 'a_tx'.
		do
			c_set_tx (item, a_tx)
		ensure
			tx_set: tx ~ a_tx
		end

	set_ty (a_ty: REAL_64)
			-- Set `ty' with 'a_ty'.
		do
			c_set_ty (item, a_ty)
		ensure
			ty_set: ty ~ a_ty
		end

feature -- Access

	a: REAL_64 assign set_a
			-- Return the struct field.
		do
			Result := c_a (item)
		end

	b: REAL_64 assign set_b
			-- Return the struct field.
		do
			Result := c_b (item)
		end

	c: REAL_64 assign set_c
			-- Return the struct field.
		do
			Result := c_c (item)
		end

	d: REAL_64 assign set_d
			-- Return the struct field.
		do
			Result := c_d (item)
		end

	tx: REAL_64 assign set_tx
			-- Return the struct field.
		do
			Result := c_tx (item)
		end

	ty: REAL_64 assign set_ty
			-- Return the struct field.
		do
			Result := c_ty (item)
		end

feature {NONE} -- Implementation

	structure_size: INTEGER
			-- Size to allocate (in bytes).
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return sizeof(CGAffineTransform);"
		end

	c_a (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CGAffineTransform *) $a_struct_pointer)->a);"
		end

	c_b (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CGAffineTransform *) $a_struct_pointer)->b);"
		end

	c_c (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CGAffineTransform *) $a_struct_pointer)->c);"
		end

	c_d (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CGAffineTransform *) $a_struct_pointer)->d);"
		end

	c_tx (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CGAffineTransform *) $a_struct_pointer)->tx);"
		end

	c_ty (a_struct_pointer: POINTER): REAL_64
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CGAffineTransform *) $a_struct_pointer)->ty);"
		end

	c_set_a (a_struct_pointer: POINTER; a_c_a: REAL_64)
			-- Set the corresponding C struct field with `a_c_a'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CGAffineTransform *) $a_struct_pointer)->a = $a_c_a;"
		end

	c_set_b (a_struct_pointer: POINTER; a_c_b: REAL_64)
			-- Set the corresponding C struct field with `a_c_b'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CGAffineTransform *) $a_struct_pointer)->b = $a_c_b;"
		end

	c_set_c (a_struct_pointer: POINTER; a_c_c: REAL_64)
			-- Set the corresponding C struct field with `a_c_c'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CGAffineTransform *) $a_struct_pointer)->c = $a_c_c;"
		end

	c_set_d (a_struct_pointer: POINTER; a_c_d: REAL_64)
			-- Set the corresponding C struct field with `a_c_d'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CGAffineTransform *) $a_struct_pointer)->d = $a_c_d;"
		end

	c_set_tx (a_struct_pointer: POINTER; a_c_tx: REAL_64)
			-- Set the corresponding C struct field with `a_c_tx'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CGAffineTransform *) $a_struct_pointer)->tx = $a_c_tx;"
		end

	c_set_ty (a_struct_pointer: POINTER; a_c_ty: REAL_64)
			-- Set the corresponding C struct field with `a_c_ty'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CGAffineTransform *) $a_struct_pointer)->ty = $a_c_ty;"
		end

feature -- Debug Output

	out, debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{" +
					"a: " + a.out + ", " +
					"b: " + b.out + ", " +
					"c: " + c.out + ", " +
					"d: " + d.out + ", " +
					"tx: " + tx.out + ", " +
					"ty: " + ty.out +
				"}"
		end

end

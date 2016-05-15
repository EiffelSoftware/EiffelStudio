note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DECIMAL

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

--	set_field1 (a_field1: UNSUPPORTED_TYPE)
--			-- Set `field1' with 'a_field1'.
--		do
--			c_set_field1 (item, a_field1.item)
--		ensure
--			field1_set: field1 ~ a_field1
--		end

--	set_field2 (a_field2: UNSUPPORTED_TYPE)
--			-- Set `field2' with 'a_field2'.
--		do
--			c_set_field2 (item, a_field2.item)
--		ensure
--			field2_set: field2 ~ a_field2
--		end

--	set_field3 (a_field3: UNSUPPORTED_TYPE)
--			-- Set `field3' with 'a_field3'.
--		do
--			c_set_field3 (item, a_field3.item)
--		ensure
--			field3_set: field3 ~ a_field3
--		end

--	set_field4 (a_field4: UNSUPPORTED_TYPE)
--			-- Set `field4' with 'a_field4'.
--		do
--			c_set_field4 (item, a_field4.item)
--		ensure
--			field4_set: field4 ~ a_field4
--		end

--	set_field5 (a_field5: UNSUPPORTED_TYPE)
--			-- Set `field5' with 'a_field5'.
--		do
--			c_set_field5 (item, a_field5.item)
--		ensure
--			field5_set: field5 ~ a_field5
--		end

--	set_field6 (a_field6: UNSUPPORTED_TYPE)
--			-- Set `field6' with 'a_field6'.
--		do
--			c_set_field6 (item, a_field6.item)
--		ensure
--			field6_set: field6 ~ a_field6
--		end

feature -- Access

--	field1: UNSUPPORTED_TYPE assign set_field1
--			-- Return the struct field.
--		do
--			create Result.make
--			c_copy_field1 (item, Result.item)
--		end

--	field2: UNSUPPORTED_TYPE assign set_field2
--			-- Return the struct field.
--		do
--			create Result.make
--			c_copy_field2 (item, Result.item)
--		end

--	field3: UNSUPPORTED_TYPE assign set_field3
--			-- Return the struct field.
--		do
--			create Result.make
--			c_copy_field3 (item, Result.item)
--		end

--	field4: UNSUPPORTED_TYPE assign set_field4
--			-- Return the struct field.
--		do
--			create Result.make
--			c_copy_field4 (item, Result.item)
--		end

--	field5: UNSUPPORTED_TYPE assign set_field5
--			-- Return the struct field.
--		do
--			create Result.make
--			c_copy_field5 (item, Result.item)
--		end

--	field6: UNSUPPORTED_TYPE assign set_field6
--			-- Return the struct field.
--		do
--			create Result.make
--			c_copy_field6 (item, Result.item)
--		end

feature {NONE} -- Implementation

	structure_size: INTEGER
			-- Size to allocate (in bytes).
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return sizeof(NSDecimal);"
		end

--	c_copy_field1 (a_struct_pointer: POINTER; result_pointer: POINTER)
--			-- Return the address of a copy of the field.
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[
--				size_t size = sizeof(((NSDecimal *) $a_struct_pointer)->field1);
--				memcpy($result_pointer, &(((NSDecimal *) $a_struct_pointer)->field1), size);
--			]"
--		end

--	c_copy_field2 (a_struct_pointer: POINTER; result_pointer: POINTER)
--			-- Return the address of a copy of the field.
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[
--				size_t size = sizeof(((NSDecimal *) $a_struct_pointer)->field2);
--				memcpy($result_pointer, &(((NSDecimal *) $a_struct_pointer)->field2), size);
--			]"
--		end

--	c_copy_field3 (a_struct_pointer: POINTER; result_pointer: POINTER)
--			-- Return the address of a copy of the field.
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[
--				size_t size = sizeof(((NSDecimal *) $a_struct_pointer)->field3);
--				memcpy($result_pointer, &(((NSDecimal *) $a_struct_pointer)->field3), size);
--			]"
--		end

--	c_copy_field4 (a_struct_pointer: POINTER; result_pointer: POINTER)
--			-- Return the address of a copy of the field.
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[
--				size_t size = sizeof(((NSDecimal *) $a_struct_pointer)->field4);
--				memcpy($result_pointer, &(((NSDecimal *) $a_struct_pointer)->field4), size);
--			]"
--		end

--	c_copy_field5 (a_struct_pointer: POINTER; result_pointer: POINTER)
--			-- Return the address of a copy of the field.
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[
--				size_t size = sizeof(((NSDecimal *) $a_struct_pointer)->field5);
--				memcpy($result_pointer, &(((NSDecimal *) $a_struct_pointer)->field5), size);
--			]"
--		end

--	c_copy_field6 (a_struct_pointer: POINTER; result_pointer: POINTER)
--			-- Return the address of a copy of the field.
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[
--				size_t size = sizeof(((NSDecimal *) $a_struct_pointer)->field6);
--				memcpy($result_pointer, &(((NSDecimal *) $a_struct_pointer)->field6), size);
--			]"
--		end

--	c_set_field1 (a_struct_pointer: POINTER; a_c_field1: POINTER)
--			-- Set the corresponding C struct field with `a_c_field1'.
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"((NSDecimal *) $a_struct_pointer)->field1 = *((unsupported *) $a_c_field1);"
--		end

--	c_set_field2 (a_struct_pointer: POINTER; a_c_field2: POINTER)
--			-- Set the corresponding C struct field with `a_c_field2'.
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"((NSDecimal *) $a_struct_pointer)->field2 = *((unsupported *) $a_c_field2);"
--		end

--	c_set_field3 (a_struct_pointer: POINTER; a_c_field3: POINTER)
--			-- Set the corresponding C struct field with `a_c_field3'.
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"((NSDecimal *) $a_struct_pointer)->field3 = *((unsupported *) $a_c_field3);"
--		end

--	c_set_field4 (a_struct_pointer: POINTER; a_c_field4: POINTER)
--			-- Set the corresponding C struct field with `a_c_field4'.
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"((NSDecimal *) $a_struct_pointer)->field4 = *((unsupported *) $a_c_field4);"
--		end

--	c_set_field5 (a_struct_pointer: POINTER; a_c_field5: POINTER)
--			-- Set the corresponding C struct field with `a_c_field5'.
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"((NSDecimal *) $a_struct_pointer)->field5 = *((unsupported *) $a_c_field5);"
--		end

--	c_set_field6 (a_struct_pointer: POINTER; a_c_field6: POINTER)
--			-- Set the corresponding C struct field with `a_c_field6'.
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"((NSDecimal *) $a_struct_pointer)->field6 = *((unsigned short[] *) $a_c_field6);"
--		end

feature -- Debug Output

	out, debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{" +
				--	"field1: " + field1.out + ", " +
				--	"field2: " + field2.out + ", " +
				--	"field3: " + field3.out + ", " +
				--	"field4: " + field4.out + ", " +
				--	"field5: " + field5.out + ", " +
				--	"field6: " + field6.out +
				"}"
		end

end

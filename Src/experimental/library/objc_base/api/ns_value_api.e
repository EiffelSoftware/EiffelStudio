note
	description: "Summary description for {NS_VALUE_API}."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_VALUE_API

feature -- Creating an NSValue

	frozen init_with_bytes_obj_ctype (a_ns_value: POINTER; a_value: POINTER; a_type: POINTER): POINTER
			-- - (id)initWithBytes: (const void *) value objCType: (const char *) type
		external
			"C inline use <Foundation/NSValue.h>"
		alias
			"return [(NSValue*)$a_ns_value initWithBytes: $a_value objCType: $a_type];"
		end

	frozen value_with_bytes_obj_ctype (a_value: POINTER; a_type: POINTER): POINTER
			-- + (NSValue *)valueWithBytes: (const void *) value objCType: (const char *) type
		external
			"C inline use <Foundation/NSValue.h>"
		alias
			"return [NSValue valueWithBytes: $a_value objCType: $a_type];"
		end

	frozen value_with_obj_ctype (a_value: POINTER; a_type: POINTER): POINTER
			-- + (NSValue *)value: (const void *) value withObjCType: (const char *) type
		external
			"C inline use <Foundation/NSValue.h>"
		alias
			"return [NSValue value: $a_value withObjCType: $a_type];"
		end

	frozen value_with_nonretained_object (a_an_object: POINTER): POINTER
			-- + (NSValue *)valueWithNonretainedObject: (id) anObject
		external
			"C inline use <Foundation/NSValue.h>"
		alias
			"return [NSValue valueWithNonretainedObject: $a_an_object];"
		end

	frozen value_with_pointer (a_pointer: POINTER): POINTER
			-- + (NSValue *)valueWithPointer: (const void *) pointer
		external
			"C inline use <Foundation/NSValue.h>"
		alias
			"return [NSValue valueWithPointer: $a_pointer];"
		end

-- Error generating valueWithPoint:: Message signature for feature not set
-- Error generating valueWithRange:: Message signature for feature not set
-- Error generating valueWithRect:: Message signature for feature not set
-- Error generating valueWithSize:: Message signature for feature not set

feature -- Accessing Data

	frozen get_value (a_ns_value: POINTER; a_value: POINTER)
			-- - (void)getValue: (void *) value
		external
			"C inline use <Foundation/NSValue.h>"
		alias
			"[(NSValue*)$a_ns_value getValue: $a_value];"
		end

	frozen nonretained_object_value (a_ns_value: POINTER): POINTER
			-- - (id)nonretainedObjectValue
		external
			"C inline use <Foundation/NSValue.h>"
		alias
			"return [(NSValue*)$a_ns_value nonretainedObjectValue];"
		end

	frozen obj_ctype (a_ns_value: POINTER): POINTER
			-- - (const char *)objCType
		external
			"C inline use <Foundation/NSValue.h>"
		alias
			"return [(NSValue*)$a_ns_value objCType];"
		end

-- Error generating pointValue: Message signature for feature not set

	frozen pointer_value (a_ns_value: POINTER): POINTER
			-- - (void *)pointerValue
		external
			"C inline use <Foundation/NSValue.h>"
		alias
			"return [(NSValue*)$a_ns_value pointerValue];"
		end

-- Error generating rangeValue: Message signature for feature not set
-- Error generating rectValue: Message signature for feature not set

	frozen size_value (a_ns_value: POINTER; res: POINTER)
			-- - (NSSize)sizeValue
		external
			"C inline use <Foundation/NSValue.h>"
		alias
			"NSSize size = [(NSValue*)$a_ns_value sizeValue]; memcpy($res, &size, sizeof(NSSize));"
		end

feature -- Comparing Objects

	frozen is_equal_to_value (a_ns_value: POINTER; a_value: POINTER): BOOLEAN
			-- - (BOOL)isEqualToValue: (NSValue *) value
		external
			"C inline use <Foundation/NSValue.h>"
		alias
			"return [(NSValue*)$a_ns_value isEqualToValue: $a_value];"
		end
end

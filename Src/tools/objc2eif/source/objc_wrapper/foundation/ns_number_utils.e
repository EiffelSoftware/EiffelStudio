note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NUMBER_UTILS

inherit
	NS_VALUE_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSNumberCreation

	number_with_char_ (a_value: CHARACTER): detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_number_with_char_ (l_objc_class.item, a_value)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like number_with_char_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like number_with_char_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_with_unsigned_char_ (a_value: CHARACTER): detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_number_with_unsigned_char_ (l_objc_class.item, a_value)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like number_with_unsigned_char_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like number_with_unsigned_char_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_with_short_ (a_value: INTEGER_16): detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_number_with_short_ (l_objc_class.item, a_value)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like number_with_short_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like number_with_short_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_with_unsigned_short_ (a_value: NATURAL_16): detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_number_with_unsigned_short_ (l_objc_class.item, a_value)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like number_with_unsigned_short_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like number_with_unsigned_short_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_with_int_ (a_value: INTEGER_32): detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_number_with_int_ (l_objc_class.item, a_value)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like number_with_int_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like number_with_int_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_with_unsigned_int_ (a_value: NATURAL_32): detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_number_with_unsigned_int_ (l_objc_class.item, a_value)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like number_with_unsigned_int_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like number_with_unsigned_int_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_with_long_ (a_value: INTEGER_64): detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_number_with_long_ (l_objc_class.item, a_value)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like number_with_long_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like number_with_long_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_with_unsigned_long_ (a_value: NATURAL_64): detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_number_with_unsigned_long_ (l_objc_class.item, a_value)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like number_with_unsigned_long_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like number_with_unsigned_long_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_with_long_long_ (a_value: INTEGER_64): detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_number_with_long_long_ (l_objc_class.item, a_value)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like number_with_long_long_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like number_with_long_long_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_with_unsigned_long_long_ (a_value: NATURAL_64): detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_number_with_unsigned_long_long_ (l_objc_class.item, a_value)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like number_with_unsigned_long_long_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like number_with_unsigned_long_long_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_with_float_ (a_value: REAL_32): detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_number_with_float_ (l_objc_class.item, a_value)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like number_with_float_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like number_with_float_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_with_double_ (a_value: REAL_64): detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_number_with_double_ (l_objc_class.item, a_value)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like number_with_double_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like number_with_double_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_with_bool_ (a_value: BOOLEAN): detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_number_with_bool_ (l_objc_class.item, a_value)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like number_with_bool_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like number_with_bool_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_with_integer_ (a_value: INTEGER_64): detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_number_with_integer_ (l_objc_class.item, a_value)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like number_with_integer_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like number_with_integer_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_with_unsigned_integer_ (a_value: NATURAL_64): detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_number_with_unsigned_integer_ (l_objc_class.item, a_value)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like number_with_unsigned_integer_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like number_with_unsigned_integer_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSNumberCreation Externals

	objc_number_with_char_ (a_class_object: POINTER; a_value: CHARACTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object numberWithChar:$a_value];
			 ]"
		end

	objc_number_with_unsigned_char_ (a_class_object: POINTER; a_value: CHARACTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object numberWithUnsignedChar:$a_value];
			 ]"
		end

	objc_number_with_short_ (a_class_object: POINTER; a_value: INTEGER_16): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object numberWithShort:$a_value];
			 ]"
		end

	objc_number_with_unsigned_short_ (a_class_object: POINTER; a_value: NATURAL_16): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object numberWithUnsignedShort:$a_value];
			 ]"
		end

	objc_number_with_int_ (a_class_object: POINTER; a_value: INTEGER_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object numberWithInt:$a_value];
			 ]"
		end

	objc_number_with_unsigned_int_ (a_class_object: POINTER; a_value: NATURAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object numberWithUnsignedInt:$a_value];
			 ]"
		end

	objc_number_with_long_ (a_class_object: POINTER; a_value: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object numberWithLong:$a_value];
			 ]"
		end

	objc_number_with_unsigned_long_ (a_class_object: POINTER; a_value: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object numberWithUnsignedLong:$a_value];
			 ]"
		end

	objc_number_with_long_long_ (a_class_object: POINTER; a_value: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object numberWithLongLong:$a_value];
			 ]"
		end

	objc_number_with_unsigned_long_long_ (a_class_object: POINTER; a_value: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object numberWithUnsignedLongLong:$a_value];
			 ]"
		end

	objc_number_with_float_ (a_class_object: POINTER; a_value: REAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object numberWithFloat:$a_value];
			 ]"
		end

	objc_number_with_double_ (a_class_object: POINTER; a_value: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object numberWithDouble:$a_value];
			 ]"
		end

	objc_number_with_bool_ (a_class_object: POINTER; a_value: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object numberWithBool:$a_value];
			 ]"
		end

	objc_number_with_integer_ (a_class_object: POINTER; a_value: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object numberWithInteger:$a_value];
			 ]"
		end

	objc_number_with_unsigned_integer_ (a_class_object: POINTER; a_value: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object numberWithUnsignedInteger:$a_value];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSNumber"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end

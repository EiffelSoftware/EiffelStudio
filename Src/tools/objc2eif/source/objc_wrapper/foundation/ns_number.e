note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NUMBER

inherit
	NS_VALUE
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_char_,
	make_with_unsigned_char_,
	make_with_short_,
	make_with_unsigned_short_,
	make_with_int_,
	make_with_unsigned_int_,
	make_with_long_,
	make_with_unsigned_long_,
	make_with_long_long_,
	make_with_unsigned_long_long_,
	make_with_float_,
	make_with_double_,
	make_with_bool_,
	make_with_integer_,
	make_with_unsigned_integer_,
	make

feature -- NSNumber

	char_value: CHARACTER
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_char_value (item)
		end

	unsigned_char_value: CHARACTER
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_unsigned_char_value (item)
		end

	short_value: INTEGER_16
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_short_value (item)
		end

	unsigned_short_value: NATURAL_16
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_unsigned_short_value (item)
		end

	int_value: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_int_value (item)
		end

	unsigned_int_value: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_unsigned_int_value (item)
		end

	long_value: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_long_value (item)
		end

	unsigned_long_value: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_unsigned_long_value (item)
		end

	long_long_value: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_long_long_value (item)
		end

	unsigned_long_long_value: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_unsigned_long_long_value (item)
		end

	float_value: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_float_value (item)
		end

	double_value: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_double_value (item)
		end

	bool_value: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_bool_value (item)
		end

	integer_value: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_integer_value (item)
		end

	unsigned_integer_value: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_unsigned_integer_value (item)
		end

	string_value: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_string_value (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_value} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_value} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	compare_ (a_other_number: detachable NS_NUMBER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_other_number__item: POINTER
		do
			if attached a_other_number as a_other_number_attached then
				a_other_number__item := a_other_number_attached.item
			end
			Result := objc_compare_ (item, a_other_number__item)
		end

	is_equal_to_number_ (a_number: detachable NS_NUMBER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_number__item: POINTER
		do
			if attached a_number as a_number_attached then
				a_number__item := a_number_attached.item
			end
			Result := objc_is_equal_to_number_ (item, a_number__item)
		end

	description_with_locale_ (a_locale: detachable NS_OBJECT): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_locale__item: POINTER
		do
			if attached a_locale as a_locale_attached then
				a_locale__item := a_locale_attached.item
			end
			result_pointer := objc_description_with_locale_ (item, a_locale__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like description_with_locale_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like description_with_locale_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSNumber Externals

	objc_char_value (an_item: POINTER): CHARACTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumber *)$an_item charValue];
			 ]"
		end

	objc_unsigned_char_value (an_item: POINTER): CHARACTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumber *)$an_item unsignedCharValue];
			 ]"
		end

	objc_short_value (an_item: POINTER): INTEGER_16
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumber *)$an_item shortValue];
			 ]"
		end

	objc_unsigned_short_value (an_item: POINTER): NATURAL_16
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumber *)$an_item unsignedShortValue];
			 ]"
		end

	objc_int_value (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumber *)$an_item intValue];
			 ]"
		end

	objc_unsigned_int_value (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumber *)$an_item unsignedIntValue];
			 ]"
		end

	objc_long_value (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumber *)$an_item longValue];
			 ]"
		end

	objc_unsigned_long_value (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumber *)$an_item unsignedLongValue];
			 ]"
		end

	objc_long_long_value (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumber *)$an_item longLongValue];
			 ]"
		end

	objc_unsigned_long_long_value (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumber *)$an_item unsignedLongLongValue];
			 ]"
		end

	objc_float_value (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumber *)$an_item floatValue];
			 ]"
		end

	objc_double_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumber *)$an_item doubleValue];
			 ]"
		end

	objc_bool_value (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumber *)$an_item boolValue];
			 ]"
		end

	objc_integer_value (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumber *)$an_item integerValue];
			 ]"
		end

	objc_unsigned_integer_value (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumber *)$an_item unsignedIntegerValue];
			 ]"
		end

	objc_string_value (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumber *)$an_item stringValue];
			 ]"
		end

	objc_compare_ (an_item: POINTER; a_other_number: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumber *)$an_item compare:$a_other_number];
			 ]"
		end

	objc_is_equal_to_number_ (an_item: POINTER; a_number: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumber *)$an_item isEqualToNumber:$a_number];
			 ]"
		end

	objc_description_with_locale_ (an_item: POINTER; a_locale: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumber *)$an_item descriptionWithLocale:$a_locale];
			 ]"
		end

feature {NONE} -- Initialization

	make_with_char_ (a_value: CHARACTER)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_char_(allocate_object, a_value))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_unsigned_char_ (a_value: CHARACTER)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_unsigned_char_(allocate_object, a_value))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_short_ (a_value: INTEGER_16)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_short_(allocate_object, a_value))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_unsigned_short_ (a_value: NATURAL_16)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_unsigned_short_(allocate_object, a_value))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_int_ (a_value: INTEGER_32)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_int_(allocate_object, a_value))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_unsigned_int_ (a_value: NATURAL_32)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_unsigned_int_(allocate_object, a_value))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_long_ (a_value: INTEGER_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_long_(allocate_object, a_value))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_unsigned_long_ (a_value: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_unsigned_long_(allocate_object, a_value))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_long_long_ (a_value: INTEGER_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_long_long_(allocate_object, a_value))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_unsigned_long_long_ (a_value: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_unsigned_long_long_(allocate_object, a_value))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_float_ (a_value: REAL_32)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_float_(allocate_object, a_value))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_double_ (a_value: REAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_double_(allocate_object, a_value))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_bool_ (a_value: BOOLEAN)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_bool_(allocate_object, a_value))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_integer_ (a_value: INTEGER_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_integer_(allocate_object, a_value))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_unsigned_integer_ (a_value: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_unsigned_integer_(allocate_object, a_value))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSNumberCreation Externals

	objc_init_with_char_ (an_item: POINTER; a_value: CHARACTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumber *)$an_item initWithChar:$a_value];
			 ]"
		end

	objc_init_with_unsigned_char_ (an_item: POINTER; a_value: CHARACTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumber *)$an_item initWithUnsignedChar:$a_value];
			 ]"
		end

	objc_init_with_short_ (an_item: POINTER; a_value: INTEGER_16): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumber *)$an_item initWithShort:$a_value];
			 ]"
		end

	objc_init_with_unsigned_short_ (an_item: POINTER; a_value: NATURAL_16): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumber *)$an_item initWithUnsignedShort:$a_value];
			 ]"
		end

	objc_init_with_int_ (an_item: POINTER; a_value: INTEGER_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumber *)$an_item initWithInt:$a_value];
			 ]"
		end

	objc_init_with_unsigned_int_ (an_item: POINTER; a_value: NATURAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumber *)$an_item initWithUnsignedInt:$a_value];
			 ]"
		end

	objc_init_with_long_ (an_item: POINTER; a_value: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumber *)$an_item initWithLong:$a_value];
			 ]"
		end

	objc_init_with_unsigned_long_ (an_item: POINTER; a_value: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumber *)$an_item initWithUnsignedLong:$a_value];
			 ]"
		end

	objc_init_with_long_long_ (an_item: POINTER; a_value: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumber *)$an_item initWithLongLong:$a_value];
			 ]"
		end

	objc_init_with_unsigned_long_long_ (an_item: POINTER; a_value: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumber *)$an_item initWithUnsignedLongLong:$a_value];
			 ]"
		end

	objc_init_with_float_ (an_item: POINTER; a_value: REAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumber *)$an_item initWithFloat:$a_value];
			 ]"
		end

	objc_init_with_double_ (an_item: POINTER; a_value: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumber *)$an_item initWithDouble:$a_value];
			 ]"
		end

	objc_init_with_bool_ (an_item: POINTER; a_value: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumber *)$an_item initWithBool:$a_value];
			 ]"
		end

	objc_init_with_integer_ (an_item: POINTER; a_value: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumber *)$an_item initWithInteger:$a_value];
			 ]"
		end

	objc_init_with_unsigned_integer_ (an_item: POINTER; a_value: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumber *)$an_item initWithUnsignedInteger:$a_value];
			 ]"
		end

feature -- NSDecimalNumberExtensions

	decimal_value: NS_DECIMAL
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_decimal_value (item, Result.item)
		end

feature {NONE} -- NSDecimalNumberExtensions Externals

	objc_decimal_value (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSDecimal *)$result_pointer = [(NSNumber *)$an_item decimalValue];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSNumber"
		end

end

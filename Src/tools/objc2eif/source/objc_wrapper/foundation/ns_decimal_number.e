note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DECIMAL_NUMBER

inherit
	NS_NUMBER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_mantissa__exponent__is_negative_,
	make_with_decimal_,
	make_with_string_,
	make_with_string__locale_,
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

feature {NONE} -- Initialization

	make_with_mantissa__exponent__is_negative_ (a_mantissa: NATURAL_64; a_exponent: INTEGER_16; a_flag: BOOLEAN)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_mantissa__exponent__is_negative_(allocate_object, a_mantissa, a_exponent, a_flag))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_decimal_ (a_dcm: NS_DECIMAL)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_decimal_(allocate_object, a_dcm.item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_string_ (a_number_value: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_number_value__item: POINTER
		do
			if attached a_number_value as a_number_value_attached then
				a_number_value__item := a_number_value_attached.item
			end
			make_with_pointer (objc_init_with_string_(allocate_object, a_number_value__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_string__locale_ (a_number_value: detachable NS_STRING; a_locale: detachable NS_OBJECT)
			-- Initialize `Current'.
		local
			a_number_value__item: POINTER
			a_locale__item: POINTER
		do
			if attached a_number_value as a_number_value_attached then
				a_number_value__item := a_number_value_attached.item
			end
			if attached a_locale as a_locale_attached then
				a_locale__item := a_locale_attached.item
			end
			make_with_pointer (objc_init_with_string__locale_(allocate_object, a_number_value__item, a_locale__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSDecimalNumber Externals

	objc_init_with_mantissa__exponent__is_negative_ (an_item: POINTER; a_mantissa: NATURAL_64; a_exponent: INTEGER_16; a_flag: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumber *)$an_item initWithMantissa:$a_mantissa exponent:$a_exponent isNegative:$a_flag];
			 ]"
		end

	objc_init_with_decimal_ (an_item: POINTER; a_dcm: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumber *)$an_item initWithDecimal:*((NSDecimal *)$a_dcm)];
			 ]"
		end

	objc_init_with_string_ (an_item: POINTER; a_number_value: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumber *)$an_item initWithString:$a_number_value];
			 ]"
		end

	objc_init_with_string__locale_ (an_item: POINTER; a_number_value: POINTER; a_locale: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumber *)$an_item initWithString:$a_number_value locale:$a_locale];
			 ]"
		end

	objc_decimal_number_by_adding_ (an_item: POINTER; a_decimal_number: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumber *)$an_item decimalNumberByAdding:$a_decimal_number];
			 ]"
		end

	objc_decimal_number_by_adding__with_behavior_ (an_item: POINTER; a_decimal_number: POINTER; a_behavior: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumber *)$an_item decimalNumberByAdding:$a_decimal_number withBehavior:$a_behavior];
			 ]"
		end

	objc_decimal_number_by_subtracting_ (an_item: POINTER; a_decimal_number: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumber *)$an_item decimalNumberBySubtracting:$a_decimal_number];
			 ]"
		end

	objc_decimal_number_by_subtracting__with_behavior_ (an_item: POINTER; a_decimal_number: POINTER; a_behavior: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumber *)$an_item decimalNumberBySubtracting:$a_decimal_number withBehavior:$a_behavior];
			 ]"
		end

	objc_decimal_number_by_multiplying_by_ (an_item: POINTER; a_decimal_number: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumber *)$an_item decimalNumberByMultiplyingBy:$a_decimal_number];
			 ]"
		end

	objc_decimal_number_by_multiplying_by__with_behavior_ (an_item: POINTER; a_decimal_number: POINTER; a_behavior: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumber *)$an_item decimalNumberByMultiplyingBy:$a_decimal_number withBehavior:$a_behavior];
			 ]"
		end

	objc_decimal_number_by_dividing_by_ (an_item: POINTER; a_decimal_number: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumber *)$an_item decimalNumberByDividingBy:$a_decimal_number];
			 ]"
		end

	objc_decimal_number_by_dividing_by__with_behavior_ (an_item: POINTER; a_decimal_number: POINTER; a_behavior: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumber *)$an_item decimalNumberByDividingBy:$a_decimal_number withBehavior:$a_behavior];
			 ]"
		end

	objc_decimal_number_by_raising_to_power_ (an_item: POINTER; a_power: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumber *)$an_item decimalNumberByRaisingToPower:$a_power];
			 ]"
		end

	objc_decimal_number_by_raising_to_power__with_behavior_ (an_item: POINTER; a_power: NATURAL_64; a_behavior: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumber *)$an_item decimalNumberByRaisingToPower:$a_power withBehavior:$a_behavior];
			 ]"
		end

	objc_decimal_number_by_multiplying_by_power_of10_ (an_item: POINTER; a_power: INTEGER_16): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumber *)$an_item decimalNumberByMultiplyingByPowerOf10:$a_power];
			 ]"
		end

	objc_decimal_number_by_multiplying_by_power_of10__with_behavior_ (an_item: POINTER; a_power: INTEGER_16; a_behavior: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumber *)$an_item decimalNumberByMultiplyingByPowerOf10:$a_power withBehavior:$a_behavior];
			 ]"
		end

	objc_decimal_number_by_rounding_according_to_behavior_ (an_item: POINTER; a_behavior: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumber *)$an_item decimalNumberByRoundingAccordingToBehavior:$a_behavior];
			 ]"
		end

feature -- NSDecimalNumber

	decimal_number_by_adding_ (a_decimal_number: detachable NS_DECIMAL_NUMBER): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_decimal_number__item: POINTER
		do
			if attached a_decimal_number as a_decimal_number_attached then
				a_decimal_number__item := a_decimal_number_attached.item
			end
			result_pointer := objc_decimal_number_by_adding_ (item, a_decimal_number__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_by_adding_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_by_adding_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decimal_number_by_adding__with_behavior_ (a_decimal_number: detachable NS_DECIMAL_NUMBER; a_behavior: detachable NS_DECIMAL_NUMBER_BEHAVIORS_PROTOCOL): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_decimal_number__item: POINTER
			a_behavior__item: POINTER
		do
			if attached a_decimal_number as a_decimal_number_attached then
				a_decimal_number__item := a_decimal_number_attached.item
			end
			if attached a_behavior as a_behavior_attached then
				a_behavior__item := a_behavior_attached.item
			end
			result_pointer := objc_decimal_number_by_adding__with_behavior_ (item, a_decimal_number__item, a_behavior__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_by_adding__with_behavior_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_by_adding__with_behavior_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decimal_number_by_subtracting_ (a_decimal_number: detachable NS_DECIMAL_NUMBER): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_decimal_number__item: POINTER
		do
			if attached a_decimal_number as a_decimal_number_attached then
				a_decimal_number__item := a_decimal_number_attached.item
			end
			result_pointer := objc_decimal_number_by_subtracting_ (item, a_decimal_number__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_by_subtracting_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_by_subtracting_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decimal_number_by_subtracting__with_behavior_ (a_decimal_number: detachable NS_DECIMAL_NUMBER; a_behavior: detachable NS_DECIMAL_NUMBER_BEHAVIORS_PROTOCOL): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_decimal_number__item: POINTER
			a_behavior__item: POINTER
		do
			if attached a_decimal_number as a_decimal_number_attached then
				a_decimal_number__item := a_decimal_number_attached.item
			end
			if attached a_behavior as a_behavior_attached then
				a_behavior__item := a_behavior_attached.item
			end
			result_pointer := objc_decimal_number_by_subtracting__with_behavior_ (item, a_decimal_number__item, a_behavior__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_by_subtracting__with_behavior_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_by_subtracting__with_behavior_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decimal_number_by_multiplying_by_ (a_decimal_number: detachable NS_DECIMAL_NUMBER): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_decimal_number__item: POINTER
		do
			if attached a_decimal_number as a_decimal_number_attached then
				a_decimal_number__item := a_decimal_number_attached.item
			end
			result_pointer := objc_decimal_number_by_multiplying_by_ (item, a_decimal_number__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_by_multiplying_by_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_by_multiplying_by_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decimal_number_by_multiplying_by__with_behavior_ (a_decimal_number: detachable NS_DECIMAL_NUMBER; a_behavior: detachable NS_DECIMAL_NUMBER_BEHAVIORS_PROTOCOL): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_decimal_number__item: POINTER
			a_behavior__item: POINTER
		do
			if attached a_decimal_number as a_decimal_number_attached then
				a_decimal_number__item := a_decimal_number_attached.item
			end
			if attached a_behavior as a_behavior_attached then
				a_behavior__item := a_behavior_attached.item
			end
			result_pointer := objc_decimal_number_by_multiplying_by__with_behavior_ (item, a_decimal_number__item, a_behavior__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_by_multiplying_by__with_behavior_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_by_multiplying_by__with_behavior_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decimal_number_by_dividing_by_ (a_decimal_number: detachable NS_DECIMAL_NUMBER): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_decimal_number__item: POINTER
		do
			if attached a_decimal_number as a_decimal_number_attached then
				a_decimal_number__item := a_decimal_number_attached.item
			end
			result_pointer := objc_decimal_number_by_dividing_by_ (item, a_decimal_number__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_by_dividing_by_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_by_dividing_by_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decimal_number_by_dividing_by__with_behavior_ (a_decimal_number: detachable NS_DECIMAL_NUMBER; a_behavior: detachable NS_DECIMAL_NUMBER_BEHAVIORS_PROTOCOL): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_decimal_number__item: POINTER
			a_behavior__item: POINTER
		do
			if attached a_decimal_number as a_decimal_number_attached then
				a_decimal_number__item := a_decimal_number_attached.item
			end
			if attached a_behavior as a_behavior_attached then
				a_behavior__item := a_behavior_attached.item
			end
			result_pointer := objc_decimal_number_by_dividing_by__with_behavior_ (item, a_decimal_number__item, a_behavior__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_by_dividing_by__with_behavior_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_by_dividing_by__with_behavior_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decimal_number_by_raising_to_power_ (a_power: NATURAL_64): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_decimal_number_by_raising_to_power_ (item, a_power)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_by_raising_to_power_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_by_raising_to_power_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decimal_number_by_raising_to_power__with_behavior_ (a_power: NATURAL_64; a_behavior: detachable NS_DECIMAL_NUMBER_BEHAVIORS_PROTOCOL): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_behavior__item: POINTER
		do
			if attached a_behavior as a_behavior_attached then
				a_behavior__item := a_behavior_attached.item
			end
			result_pointer := objc_decimal_number_by_raising_to_power__with_behavior_ (item, a_power, a_behavior__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_by_raising_to_power__with_behavior_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_by_raising_to_power__with_behavior_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decimal_number_by_multiplying_by_power_of10_ (a_power: INTEGER_16): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_decimal_number_by_multiplying_by_power_of10_ (item, a_power)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_by_multiplying_by_power_of10_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_by_multiplying_by_power_of10_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decimal_number_by_multiplying_by_power_of10__with_behavior_ (a_power: INTEGER_16; a_behavior: detachable NS_DECIMAL_NUMBER_BEHAVIORS_PROTOCOL): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_behavior__item: POINTER
		do
			if attached a_behavior as a_behavior_attached then
				a_behavior__item := a_behavior_attached.item
			end
			result_pointer := objc_decimal_number_by_multiplying_by_power_of10__with_behavior_ (item, a_power, a_behavior__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_by_multiplying_by_power_of10__with_behavior_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_by_multiplying_by_power_of10__with_behavior_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decimal_number_by_rounding_according_to_behavior_ (a_behavior: detachable NS_DECIMAL_NUMBER_BEHAVIORS_PROTOCOL): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_behavior__item: POINTER
		do
			if attached a_behavior as a_behavior_attached then
				a_behavior__item := a_behavior_attached.item
			end
			result_pointer := objc_decimal_number_by_rounding_according_to_behavior_ (item, a_behavior__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_by_rounding_according_to_behavior_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_by_rounding_according_to_behavior_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDecimalNumber"
		end

end

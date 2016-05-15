note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DECIMAL_NUMBER_UTILS

inherit
	NS_NUMBER_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSDecimalNumber

	decimal_number_with_mantissa__exponent__is_negative_ (a_mantissa: NATURAL_64; a_exponent: INTEGER_16; a_flag: BOOLEAN): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_decimal_number_with_mantissa__exponent__is_negative_ (l_objc_class.item, a_mantissa, a_exponent, a_flag)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_with_mantissa__exponent__is_negative_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_with_mantissa__exponent__is_negative_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decimal_number_with_decimal_ (a_dcm: NS_DECIMAL): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_decimal_number_with_decimal_ (l_objc_class.item, a_dcm.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_with_decimal_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_with_decimal_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decimal_number_with_string_ (a_number_value: detachable NS_STRING): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_number_value__item: POINTER
		do
			if attached a_number_value as a_number_value_attached then
				a_number_value__item := a_number_value_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_decimal_number_with_string_ (l_objc_class.item, a_number_value__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_with_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_with_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decimal_number_with_string__locale_ (a_number_value: detachable NS_STRING; a_locale: detachable NS_OBJECT): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_number_value__item: POINTER
			a_locale__item: POINTER
		do
			if attached a_number_value as a_number_value_attached then
				a_number_value__item := a_number_value_attached.item
			end
			if attached a_locale as a_locale_attached then
				a_locale__item := a_locale_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_decimal_number_with_string__locale_ (l_objc_class.item, a_number_value__item, a_locale__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_with_string__locale_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_with_string__locale_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	zero: detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_zero (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like zero} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like zero} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	one: detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_one (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like one} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like one} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	minimum_decimal_number: detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_minimum_decimal_number (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like minimum_decimal_number} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like minimum_decimal_number} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	maximum_decimal_number: detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_maximum_decimal_number (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like maximum_decimal_number} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like maximum_decimal_number} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	not_a_number: detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_not_a_number (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like not_a_number} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like not_a_number} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_default_behavior_ (a_behavior: detachable NS_DECIMAL_NUMBER_BEHAVIORS_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_behavior__item: POINTER
		do
			if attached a_behavior as a_behavior_attached then
				a_behavior__item := a_behavior_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_default_behavior_ (l_objc_class.item, a_behavior__item)
		end

	default_behavior: detachable NS_DECIMAL_NUMBER_BEHAVIORS_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_default_behavior (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like default_behavior} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like default_behavior} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSDecimalNumber Externals

	objc_decimal_number_with_mantissa__exponent__is_negative_ (a_class_object: POINTER; a_mantissa: NATURAL_64; a_exponent: INTEGER_16; a_flag: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object decimalNumberWithMantissa:$a_mantissa exponent:$a_exponent isNegative:$a_flag];
			 ]"
		end

	objc_decimal_number_with_decimal_ (a_class_object: POINTER; a_dcm: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object decimalNumberWithDecimal:*((NSDecimal *)$a_dcm)];
			 ]"
		end

	objc_decimal_number_with_string_ (a_class_object: POINTER; a_number_value: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object decimalNumberWithString:$a_number_value];
			 ]"
		end

	objc_decimal_number_with_string__locale_ (a_class_object: POINTER; a_number_value: POINTER; a_locale: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object decimalNumberWithString:$a_number_value locale:$a_locale];
			 ]"
		end

	objc_zero (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object zero];
			 ]"
		end

	objc_one (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object one];
			 ]"
		end

	objc_minimum_decimal_number (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object minimumDecimalNumber];
			 ]"
		end

	objc_maximum_decimal_number (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object maximumDecimalNumber];
			 ]"
		end

	objc_not_a_number (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object notANumber];
			 ]"
		end

	objc_set_default_behavior_ (a_class_object: POINTER; a_behavior: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object setDefaultBehavior:$a_behavior];
			 ]"
		end

	objc_default_behavior (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object defaultBehavior];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDecimalNumber"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
